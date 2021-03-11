// **************************************************************************** //
// **************************************************************************** //
// ********** NEXYS TETRIS: HEAVILY INFLUENCED BY TETRIS ON THE NES. ********** //
// ******** HDL/DRIVERS CREATED BY MANUEL KELLY USING VIVADO AND VITIS. ******* //
// ******* ALL CODE WAS BUILT TO BE IMPLEMENTED ON THE OLD NEXYS4 FPGA. ******* //
// ******** YOU WILL NEED TO USE: XADC & POTENTIOMETER AND USB MOUSE. ********* //
// ******************************** HAVE FUN! ********************************* //
// **************************************************************************** //
// **************************************************************************** //

#include "chu_init.h"
#include "gpio_cores.h"
#include "vga_core.h"
#include "sseg_core.h"
#include "ps2_core.h"
#include "xadc_core.h"
#include "adsr_core.h"

// *** FUNCTIONS USED FOR THIS PROJECT *** //
int mouse_cursor(SpriteCore*, Ps2Core*); // Used to display a mouse cursor on screen
void mainMenu(OsdCore*); // Draws the main menu of Nexys Tetris
void drawLevel(OsdCore*, FrameCore*); // Draws the Tetris Stage
int movePixels(int rotation); // Moves the sprite based on its orientation (up/down/left/right by 16 pixels)
void level1(SpriteCore*, SpriteCore*, PwmCore*, Ps2Core*, XadcCore*, FrameCore*, GpoCore*, OsdCore*); // Framework of level 1
void gameOver(GpoCore*, OsdCore*); // Draws the game over screen
void addBlock(int, int, int); // Algorithms to add block to a 2 Dim array [spaces[][] and colors[][] on line 40/41]
void drawBlocks(FrameCore*); // Draws the blocks to the screen
void removeBlocks(int); // Removes blocks from the 2 Dim array
void clearFlash(GpoCore*, OsdCore*); // Flashes all LEDs when a row is full/cleared
int rowFull(); // Checks to see if any rows are full of blocks
int blockAddr(int); // Returns the block address based on its rotation
int blockWidth(int, int); // Returns the width of a block
int blockShiftX(int, int); // Shifts a block to correct its position based on the 32x32 sprite grid
int blockShiftY(int, int); // Shifts a block to correct its position based on the 32x32 sprite grid
int btnClick(Ps2Core*); // Checks and returns any buttons pressed by the mouse
void setRGB(PwmCore*, int, bool); // Sets the RGB LEDs based on color of current/next block
int moveBlock(XadcCore*, int); // Moves a block on screen using the built in XADC and potentiometer
// *** FUNCTIONS USED FOR THIS PROJECT *** //

// *** GLOBAL VARIABLES USED FOR THIS PROJECT *** //
bool spaces[10][20]; // 2 Dim array storing whether a space is taken or not in the tetris board
int colors[10][20]; // 2 Dim array storing the colors each space (block) has on the tetris board
int stackHeight[10]; // stores the height of each column
bool lost = false; // returns whether the user has lost the game
bool cleared = false; // clears all the tetris spaces in the spaces[][] 2 Dim array
bool title = false; // used to tell whether the title screen has been written to the screen
// *** GLOBAL VARIABLES USED FOR THIS PROJECT *** //

// external core instantiation
GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
GpiCore sw(get_slot_addr(BRIDGE_BASE, S3_SW));
XadcCore adc(get_slot_addr(BRIDGE_BASE, S5_XDAC));
FrameCore frame(FRAME_BASE);
SpriteCore ghost(get_sprite_addr(BRIDGE_BASE, V3_GHOST), 1024);
SpriteCore mouse(get_sprite_addr(BRIDGE_BASE, V1_MOUSE), 1024);
OsdCore osd(get_sprite_addr(BRIDGE_BASE, V2_OSD));
SsegCore sseg(get_slot_addr(BRIDGE_BASE, S8_SSEG));
Ps2Core ps2(get_slot_addr(BRIDGE_BASE, S11_PS2));
PwmCore pwm(get_slot_addr(BRIDGE_BASE, S6_PWM));

// *** NEW SPRITE CORES ** //
SpriteCore block1(get_sprite_addr(BRIDGE_BASE, V4_BLOCK1), 16384); // has blocks i, o, t and s in order
SpriteCore block2(get_sprite_addr(BRIDGE_BASE, V5_BLOCK2), 12288); // has blocks z, j and l in order
// *** NEW SPRITE CORES ** //

int main() {
   ps2.init();
   ghost.bypass(1); // bypasses ghost sprite
   mouse.move_xy(641, 0); // moves the mouse cursor by one pixel out of the screen
   block1.move_xy(641, 0); // moves blobk1 by one pixel out of the screen
   block2.move_xy(641, 0); // moves blobk2 by one pixel out of the screen
   bool inMain = true; // returns whether the user is in the main menu or not
   bool drawing = true; // tells the program that we are drawing the screen
   frame.clr_screen(0x000);
   while (1) {
	   if(inMain) { // main menu
		   mainMenu(&osd);
		   if (mouse_cursor(&mouse, &ps2) == 1) { // If the user clicks the START button
			   inMain = false;
			   osd.clr_screen();
			   mouse.move_xy(641, 0);
		   }
		   else if (mouse_cursor(&mouse, &ps2) == 2) { // If the user clicks the EXIT button
			   osd.clr_screen();
			   mouse.move_xy(641, 0);
			   break;
		   }
	   }
	   else {
		   if (!lost) { // is playing tetris
			   if (drawing) {
				   drawLevel(&osd, &frame);
				   drawing = false;
			   }
			   level1(&block1, &block2, &pwm, &ps2, &adc, &frame, &led, &osd); // function to move a mouse cursor
		   }
		   else { // if user lost the game, clear / reset everything
			   sleep_ms(1000);
			   mouse.move_xy(641, 0);
			   block1.move_xy(641, 0);
			   block2.move_xy(641, 0);
			   frame.clr_screen(0x000);
			   inMain = true;
			   lost = false;
			   cleared = false;
			   drawing = true;
			   title = false;
			   osd.clr_screen();
			   for (int i = 0; i < 6; i++)
				   pwm.set_duty(0.0, i);
		   }
	   }
   }
} //main

int mouse_cursor(SpriteCore *sprite_p, Ps2Core *ps2_p) { // function to move a mouse cursor
	int lbtn, rbtn, xmov, ymov;
	static int xpos = 0, ypos = 0; // static to store the previous position of the mouse
	int tempX = 0, tempY = 0; // stores the current movement of the mouse

	if (ps2_p->get_mouse_activity(&lbtn, &rbtn, &xmov, &ymov)) {
	    sprite_p->move_xy(xpos, ypos); // moves cursor using our static integers
	    tempX = xpos + xmov;
	    tempY = ypos - ymov;
	    // if the new move is within our bounds of 640 x 480, we change the cursor's x or y position
	    if (tempX >= 0 && tempX < 640)
	    	xpos = tempX;
	    if (tempY >= 0 && tempY < 480)
	        ypos = tempY;
	}   // end get_mouse_activitiy()

	if (lbtn) {
		if (xpos > 290 && xpos < 340) {
			if (ypos > 155 && ypos < 180)
				return 1; // Start Game
			else if (ypos > 250 && ypos < 278)
				return 2; // Exit Game
		}
	}
	return 0;
}

void mainMenu(OsdCore* osd_p) { // Draws the main menu
	static char nexysTetris[12] = {'N', 'e', 'x', 'y', 's', ' ', 'T', 'e', 't', 'r', 'i', 's'};
	static char start[5] = {'S', 'T', 'A', 'R', 'T'};
	static char exit[4] = {'E', 'X', 'I', 'T'};

	if (!title) {
		osd_p->set_color(0x0f0, 0x001); // dark gray/green
		osd_p->bypass(0);
		osd_p->clr_screen();
		for (int i = 0; i < 12; i++) {
			osd_p->wr_char(34 + i, 2, nexysTetris[i], 0);
			sleep_ms(100);
		}
		for (int i = 0; i < 5; i++) {
			osd_p->wr_char(37 + i, 10, start[i], 0);
			sleep_ms(100);
		}
		for (int i = 0; i < 4; i++) {
			osd_p->wr_char(37 + i, 16, exit[i], 0);
			sleep_ms(100);
		}
		title = true;
	}
}

void drawLevel(OsdCore* osd_p, FrameCore* frame_p) { // draws the tetris stage
	int x0, y0, x, y, color;
	static char nextBlock[10] {'N', 'e', 'x', 't', ' ', 'B', 'l', 'o', 'c', 'k'};
	static char haveFun[9] {'H', 'a', 'v', 'e', ' ', 'F', 'u', 'n', '!'};

	frame_p->bypass(0);
	frame_p->clr_screen(0x000);  // black
	for (int i = 278; i < 369; i++) {
	   x0 = i;
	   x = x0;
	   y0 = 115;
	   y = 342;
	   color = 0x777;
	   frame_p->plot_line(x0, y0, x, y, color);
	}
	for (int i = 283; i < 364; i++) {
	   x0 = i;
	   x = x0;
	   y0 = 115;
	   y = 337;
	   color = 0x000;
	   frame_p->plot_line(x0, y0, x, y, color);
	}
	for (int i = 0; i < 3; i++) {
	   x0 = 283;
	   x = 363;
	   y0 = 176 + i; // 176 is our 20 block height for 8x8 blocks
	   y = y0;
	   color = 0xf00;
	   frame_p->plot_line(x0, y0, x, y, color);
	}
	for (int i = 534; i < 634; i++) {
	   x0 = i;
	   x = x0;
	   y0 = 38;
	   y = 117;
	   color = 0x777;
	   frame_p->plot_line(x0, y0, x, y, color);
	}

	osd_p->set_color(0x0f0, 0x001); // dark gray/green
	osd_p->bypass(0);
	osd_p->clr_screen();
	for (int i = 0; i < 10; i++) {
		osd_p->wr_char(68 + i, 3, nextBlock[i], 0);
		sleep_ms(100);
	}
	for (int i = 0; i < 9; i++) {
		osd_p->wr_char(37 + i, 3, haveFun[i], 0);
		sleep_ms(100);
	}
}

void level1(SpriteCore *block1_p, SpriteCore *block2_p, PwmCore* pwm_p, Ps2Core *ps2_p, XadcCore *adc_p, FrameCore *frame_p, GpoCore *led_p, OsdCore *osd_p) { // level 1 game framework
	if (!cleared) { // clears all spaces on the board
		for (int i = 0; i < 10; i++) {
			for (int j = 0; j < 20; j++) {
				spaces[i][j] = false; // false = empty space
				colors[i][j] = 0x000;
			}
			stackHeight[i] = 0;
		}
		cleared = true;
	}

	static int xpos = 282, ypos = 137; // static to store the previous position of the mouse // y = 177 is 20 blocks high // y = 137 is 25 blocks high
	static int xpos2 = 568, ypos2 = 75; // for next block
	static bool foundAddr = false;
	static bool foundAddr2 = false;
	static int rotation = 0;
	static int counter = 0; // for moving the blocks downward
	static int blk1Count = 0; // using this instead of rand() because I get a bram overflow error
	static int blk2Count = 4; // using this instead of rand() because I get a bram overflow error
	int button = btnClick(ps2_p);

	static int currBlock = 0; // start at block 0
	static int nextBlock = 5; // can be blocks 4 through 6
	static int currBlkAddr = 0;
	static int nextBlkAddr = 0;
	static int dropSpeed = 9997;

	static int ymax = 0;
	static int xmax = 0;
	static bool fixedError = false; // fixes the sprite position based on where it was written in the 32x32 grid
	static bool changeRotation = false; // used for rotating a block once
	static int currX = 0; // current x value on the board
	static int blockW = 0; // stores the width of the current block
	static int maxHeight = 0; // max height of a current stack
	static int blockAt = 0; // used for moving the block

	// *** MOUSE READ *** //
	if (button == 2) {
		if (rotation == 3)
			rotation = 0;
		else
			rotation++;
		changeRotation = true;
		fixedError = false;
		maxHeight = 0;
	}
	else if (button == 1)
		dropSpeed = 997;
	// *** MOUSE READ *** //

	// fixes the sprite position based on where it was written in the 32x32 grid
	if (!fixedError) {
		xmax = blockShiftX(currBlock, rotation);
		ymax = blockShiftY(currBlock, rotation);
		fixedError = true;
	}
	blockW = blockWidth(currBlock, rotation);
	blockAt = moveBlock(adc_p, blockW);
	xpos = 282 + blockAt;
	currX = blockAt / 8; // what block we are at in a 2 dim 10x20 array

	// **************************** //
	// ****** BLOCK MOVEMENT ****** //
	// **************************** //
	for (int i = 0; i < blockW; i++) {
		int tempHeight = stackHeight[i + currX];
		if (tempHeight > maxHeight)
			maxHeight = tempHeight;
	}

	if (currBlock < 4) {
		if (!foundAddr) {
			currBlkAddr = blockAddr(currBlock);
			setRGB(pwm_p, currBlock, false);
			foundAddr = true;
		}
		block1_p->wr_ctrl(currBlkAddr + rotation);
		block1_p->move_xy(xpos - xmax, ypos + ymax);
	}
	else {
		if (!foundAddr) {
			currBlkAddr = blockAddr(currBlock - 4);
			setRGB(pwm_p, currBlock, false);
			foundAddr = true;
		}
		block2_p->wr_ctrl(currBlkAddr + rotation);
		block2_p->move_xy(xpos - xmax, ypos + ymax);
	}

	if (nextBlock < 4) {
		if (!foundAddr2) {
			nextBlkAddr = blockAddr(nextBlock);
			block1_p->wr_ctrl(nextBlkAddr);
			setRGB(pwm_p, nextBlock, true);
			foundAddr2 = true;
		}
		block1_p->move_xy(xpos2, ypos2);
	}
	else {
		if (!foundAddr2) {
			nextBlkAddr = blockAddr(nextBlock - 4);
			block2_p->wr_ctrl(nextBlkAddr);
			setRGB(pwm_p, nextBlock, true);
			foundAddr2 = true;
		}
		block2_p->move_xy(xpos2, ypos2);
	}
	// **************************** //
	// ****** BLOCK MOVEMENT ****** //
	// **************************** //

	// *** BLOCK SELECTION *** //
	blk1Count++;
	blk2Count++;
	if (blk1Count == 4)
		blk1Count = 0;
	if (blk2Count == 7)
		blk2Count = 4;
	// *** BLOCK SELECTION *** //

	// *** BLOCK Y AXIS DROP AND SPEED *** //
	counter++;
	if (counter >= dropSpeed) {
		counter = 0;
		ypos += 8;
		uart.disp("\n\r");
		uart.disp(ypos);
		uart.disp("\n\r");
	}
	// *** BLOCK Y AXIS DROP AND SPEED *** //

	// **************************** //
	// ****** BLOCK SETTING ******* //
	// **************************** //
	if (ypos >= 337 - 24 - (maxHeight * 8)) { // - 24
		if (!lost) {
			if (currBlock < 4)
				block1_p->move_xy(641, 0);
			else
				block2_p->move_xy(641, 0);
		}
		addBlock(blockAt / 8, currBlock, rotation);
		drawBlocks(frame_p);
		int rowErase = 1;
		while (rowErase > 0) {
			rowErase = rowFull();
			if (rowErase > 0) {
				removeBlocks(rowErase);
				clearFlash(led_p, osd_p);
			}
			drawBlocks(frame_p);
		}
		uart.disp("\n\r");
		uart.disp("Block bottom value: ");
		uart.disp(ypos + ymax);
		uart.disp("\n\r");
		ypos = 137; // 165 is max for 20 blocks
		currBlock = nextBlock;
		if (currBlock < 4)
			nextBlock = blk2Count;  // can be blocks 4 through 6
		else
			nextBlock = blk1Count;  // can be blocks 0 through 3
		foundAddr = false;
		foundAddr2 = false;
		rotation = 0;
		dropSpeed = 9997;
		fixedError = false;
		maxHeight = 0;
		if (lost) {
			gameOver(led_p, osd_p);
		}
	}
	// **************************** //
	// ****** BLOCK SETTING ******* //
	// **************************** //
}

void gameOver(GpoCore* led_p, OsdCore* osd_p) { // Draws game over screen
	static char youLose[9] {'Y', 'o', 'u', ' ', 'L', 'o', 's', 'e', '!'};

	osd_p->set_color(0x0f0, 0x001); // dark gray/green
	osd_p->clr_screen();

	for (int i = 0; i < 9; i++) {
		osd_p->wr_char(37 + i, 3, youLose[i], 0);
	}
	led_p->write(0xffff);
	sleep_ms(500);
	osd_p->clr_screen();
	led_p->write(0x0000);
	sleep_ms(500);

	for (int i = 0; i < 9; i++) {
		osd_p->wr_char(37 + i, 3, youLose[i], 0);
	}
	led_p->write(0xffff);
	sleep_ms(500);
	osd_p->clr_screen();
	led_p->write(0x0000);
	sleep_ms(500);
}

// ************ VERY LONG FUNCTION ************ //
void addBlock(int x, int block, int rotation) { // adds a new block to the array of spaces
	// ******************************************** //
	// ******* ALGORITHMS TO SET EACH BLOCK ******* //
	// ******************************************** //
	int maxH = 0;
	if (block == 0) { // i block
		if (rotation == 0 || rotation == 3) {
			maxH = stackHeight[x];
			if (maxH >= 17)
				lost = true;
			else {
				for (int i = 0; i < 4; i++) {
					spaces[x][19 - maxH - i] = true; // spaces are taken
					colors[x][19 - maxH - i] = 0x0ff;
				}
				stackHeight[x] += 4;
			}
		}
		else {
			maxH = stackHeight[x];
			for (int i = x + 1; i < x + 4; i++) {
				if (stackHeight[i] > maxH)
					maxH = stackHeight[i];
			}
			if (maxH == 20)
				lost = true;
			else {
				for (int j = 0; j < 4; j++) {
					spaces[x + j][19 - maxH] = true;
					colors[x + j][19 - maxH] = 0x0ff;
					stackHeight[x + j] = maxH + 1;
				}
			}
		}
	}
	else if (block == 1) { // o block
		maxH = stackHeight[x];
		if (stackHeight[x + 1] > maxH)
			maxH = stackHeight[x + 1];
		if (maxH >= 19)
			lost = true;
		else {
			for (int i = 0; i < 2; i++) {
				spaces[x + i][19 - maxH] = true;
				spaces[x + i][19 - maxH - 1] = true;
				colors[x + i][19 - maxH] = 0xff0;
				colors[x + i][19 - maxH - 1] = 0xff0;
				stackHeight[x + i] = maxH + 2;
			}
		}
	}
	else if (block == 2) { // t block
		if (rotation == 0) {
			maxH = stackHeight[x];
			for (int i = x + 1; i < x + 3; i++) {
				if (stackHeight[i] > maxH)
					maxH = stackHeight[i];
			}
			if (maxH >= 19)
				lost = true;
			else {
				for (int i = 0; i < 3; i++) {
					spaces[x + i][19 - maxH] = true;
					colors[x + i][19 - maxH] = 0xf0f;
					stackHeight[x + i] = maxH + 1;
					if (i == 1) {
						spaces[x + i][19 - maxH - 1] = true;
						colors[x + i][19 - maxH - 1] = 0xf0f;
						stackHeight[x + i]++;
					}
				}
			}
		}
		else if (rotation == 1) {
			bool lower = true; // if our hanging part has a lower max height
			if (stackHeight[x] >= stackHeight[x + 1] + 1)
				maxH = stackHeight[x];
			else {
				maxH = stackHeight[x + 1];
				lower = false;
			}

			if (lower) {
				if (maxH >= 19)
					lost = true;
				else {
					spaces[x][19 - maxH] = true;
					spaces[x + 1][19 - maxH + 1] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 1][19 - maxH - 1] = true;
					colors[x][19 - maxH] = 0xf0f;
					colors[x + 1][19 - maxH + 1] = 0xf0f;
					colors[x + 1][19 - maxH] = 0xf0f;
					colors[x + 1][19 - maxH - 1] = 0xf0f;
					stackHeight[x] = maxH + 1;
					stackHeight[x + 1] = maxH  + 2;
				}
			}
			else {
				if (maxH >= 18)
					lost = true;
				else {
					spaces[x][19 - maxH - 1] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 1][19 - maxH - 1] = true;
					spaces[x + 1][19 - maxH - 2] = true;
					colors[x][19 - maxH - 1] = 0xf0f;
					colors[x + 1][19 - maxH] = 0xf0f;
					colors[x + 1][19 - maxH - 1] = 0xf0f;
					colors[x + 1][19 - maxH - 2] = 0xf0f;
					stackHeight[x] = maxH + 2;
					stackHeight[x + 1] = maxH  + 3;
				}
			}
		}
		else if (rotation == 2) {
			bool lower = true; // if our hanging part has a lower max height
 			maxH = stackHeight[x];
			if (stackHeight[x + 2] > maxH)
				maxH = stackHeight[x + 2];
			if (maxH < stackHeight[x + 1] + 1) {
				maxH = stackHeight[x + 1];
				lower = false;
			}
			if (lower) {
				if (maxH == 20)
					lost = true;
				else {
					spaces[x][19 - maxH] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 1][19 - maxH + 1] = true;
					spaces[x + 2][19 - maxH] = true;
					colors[x][19 - maxH] = 0xf0f;
					colors[x + 1][19 - maxH] = 0xf0f;
					colors[x + 1][19 - maxH + 1] = 0xf0f;
					colors[x + 2][19 - maxH] = 0xf0f;
					stackHeight[x] = maxH + 1;
					stackHeight[x + 1] = maxH + 1;
					stackHeight[x + 2] = maxH + 1;
				}
			}
			else {
				if (maxH >= 19)
					lost = true;
				else {
					spaces[x][19 - maxH - 1] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 1][19 - maxH - 1] = true;
					spaces[x + 2][19 - maxH - 1] = true;
					colors[x][19 - maxH - 1] = 0xf0f;
					colors[x + 1][19 - maxH] = 0xf0f;
					colors[x + 1][19 - maxH - 1] = 0xf0f;
					colors[x + 2][19 - maxH - 1] = 0xf0f;
					stackHeight[x] = maxH + 2;
					stackHeight[x + 1] = maxH + 2;
					stackHeight[x + 2] = maxH + 2;
				}
			}
		}
		else {
			bool lower = false;
			maxH = stackHeight[x];
			if (maxH + 1 < stackHeight[x + 1]) {
				maxH = stackHeight[x + 1];
				lower = true;
			}
			if (lower) {
				if (maxH >= 19)
					lost = true;
				else {
					spaces[x][19 - maxH + 1] = true;
					spaces[x][19 - maxH] = true;
					spaces[x][19 - maxH - 1] = true;
					spaces[x + 1][19 - maxH] = true;
					colors[x][19 - maxH + 1] = 0xf0f;
					colors[x][19 - maxH] = 0xf0f;
					colors[x][19 - maxH - 1] = 0xf0f;
					colors[x + 1][19 - maxH] = 0xf0f;
					stackHeight[x] = maxH + 2;
					stackHeight[x + 1] = maxH + 1;
				}
			}
			else {
				if (maxH >= 18)
					lost = true;
				else {
					spaces[x][19 - maxH] = true;
					spaces[x][19 - maxH - 1] = true;
					spaces[x][19 - maxH - 2] = true;
					spaces[x + 1][19 - maxH - 1] = true;
					colors[x][19 - maxH] = 0xf0f;
					colors[x][19 - maxH - 1] = 0xf0f;
					colors[x][19 - maxH - 2] = 0xf0f;
					colors[x + 1][19 - maxH - 1] = 0xf0f;
					stackHeight[x] = maxH + 3;
					stackHeight[x + 1] = maxH + 2;
				}
			}
		}
	}
	else if (block == 3) {
		if (rotation == 0 || rotation == 2) {
			bool lower = false;
			maxH = stackHeight[x];
			if (stackHeight[x + 1] > maxH)
				maxH = stackHeight[x + 1];
			if (maxH + 1 < stackHeight[x + 2]) {
				maxH = stackHeight[x + 2];
				lower = true;
			}
			if (lower) {
				if (maxH >= 20)
					lost = true;
				else {
					spaces[x][19 - maxH + 1] = true;
					spaces[x + 1][19 - maxH + 1] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 2][19 - maxH] = true;
					colors[x][19 - maxH + 1] = 0x0f0;
					colors[x + 1][19 - maxH + 1] = 0x0f0;
					colors[x + 1][19 - maxH] = 0x0f0;
					colors[x + 2][19 - maxH] = 0x0f0;
					stackHeight[x] = maxH;
					stackHeight[x + 1] = maxH + 1;
					stackHeight[x + 2] = maxH + 1;
				}
			}
			else {
				if (maxH >= 19)
					lost = true;
				else {
					spaces[x][19 - maxH] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 1][19 - maxH - 1] = true;
					spaces[x + 2][19 - maxH - 1] = true;
					colors[x][19 - maxH] = 0x0f0;
					colors[x + 1][19 - maxH] = 0x0f0;
					colors[x + 1][19 - maxH - 1] = 0x0f0;
					colors[x + 2][19 - maxH - 1] = 0x0f0;
					stackHeight[x] = maxH + 1;
					stackHeight[x + 1] = maxH + 2;
					stackHeight[x + 2] = maxH + 2;
				}
			}
		}
		else {
			bool lower = false;
			maxH = stackHeight[x + 1];
			if (maxH + 1 < stackHeight[x]) {
				maxH = stackHeight[x];
				lower = true;
			}
			if (lower) {
				if (maxH >= 19)
					lost = true;
				else {
					spaces[x][19 - maxH - 1] = true;
					spaces[x][19 - maxH] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 1][19 - maxH + 1] = true;
					colors[x][19 - maxH - 1] = 0x0f0;
					colors[x][19 - maxH] = 0x0f0;
					colors[x + 1][19 - maxH] = 0x0f0;
					colors[x + 1][19 - maxH + 1] = 0x0f0;
					stackHeight[x] = maxH + 2;
					stackHeight[x + 1] = maxH + 1;
				}
			}
			else {
				if (maxH >= 18)
					lost = true;
				else {
					spaces[x][19 - maxH - 2] = true;
					spaces[x][19 - maxH - 1] = true;
					spaces[x + 1][19 - maxH - 1] = true;
					spaces[x + 1][19 - maxH] = true;
					colors[x][19 - maxH - 2] = 0x0f0;
					colors[x][19 - maxH - 1] = 0x0f0;
					colors[x + 1][19 - maxH - 1] = 0x0f0;
					colors[x + 1][19 - maxH] = 0x0f0;
					stackHeight[x] = maxH + 3;
					stackHeight[x + 1] = maxH + 2;
				}
			}
		}
	}
	else if (block == 4) { // z block
		if (rotation == 0 || rotation == 2) {
			bool lower = false;
			maxH = stackHeight[x + 1];
			if (stackHeight[x + 2] > maxH)
				maxH = stackHeight[x + 2];
			if (maxH + 1 < stackHeight[x]) {
				maxH = stackHeight[x];
				lower = true;
			}
			if (lower) {
				if (maxH >= 20)
					lost = true;
				else {
					spaces[x][19 - maxH] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 1][19 - maxH + 1] = true;
					spaces[x + 2][19 - maxH + 1] = true;
					colors[x][19 - maxH] = 0xf00;
					colors[x + 1][19 - maxH] = 0xf00;
					colors[x + 1][19 - maxH + 1] = 0xf00;
					colors[x + 2][19 - maxH + 1] = 0xf00;
					stackHeight[x] = maxH + 1;
					stackHeight[x + 1] = maxH + 1;
					stackHeight[x + 2] = maxH;
				}
			}
			else {
				if (maxH >= 19)
					lost = true;
				else {
					spaces[x][19 - maxH - 1] = true;
					spaces[x + 1][19 - maxH - 1] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 2][19 - maxH] = true;
					colors[x][19 - maxH - 1] = 0xf00;
					colors[x + 1][19 - maxH - 1] = 0xf00;
					colors[x + 1][19 - maxH] = 0xf00;
					colors[x + 2][19 - maxH] = 0xf00;
					stackHeight[x] = maxH + 2;
					stackHeight[x + 1] = maxH + 2;
					stackHeight[x + 2] = maxH + 1;
				}
			}
		}
		else {
			bool lower = false;
			maxH = stackHeight[x];
			if (maxH + 1 < stackHeight[x + 1]){
				maxH = stackHeight[x + 1];
				lower = true;
			}
			if (lower) {
				if (maxH >= 19)
					lost = true;
				else {
					spaces[x][19 - maxH  + 1] = true;
					spaces[x][19 - maxH] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 1][19 - maxH - 1] = true;
					colors[x][19 - maxH  + 1] = 0xf00;
					colors[x][19 - maxH] = 0xf00;
					colors[x + 1][19 - maxH] = 0xf00;
					colors[x + 1][19 - maxH - 1] = 0xf00;
					stackHeight[x] = maxH + 1;
					stackHeight[x + 1] = maxH + 2;
				}
			}
			else {
				if (maxH >= 18)
					lost = true;
				else {
					spaces[x][19 - maxH] = true;
					spaces[x][19 - maxH - 1] = true;
					spaces[x + 1][19 - maxH - 1] = true;
					spaces[x + 1][19 - maxH - 2] = true;
					colors[x][19 - maxH] = 0xf00;
					colors[x][19 - maxH - 1] = 0xf00;
					colors[x + 1][19 - maxH - 1] = 0xf00;
					colors[x + 1][19 - maxH - 2] = 0xf00;
					stackHeight[x] = maxH + 2;
					stackHeight[x + 1] = maxH + 3;
				}
			}
		}
	}
	else if (block == 5) { // j block
		if (rotation == 0) {
			maxH = stackHeight[x];
			if (stackHeight[x + 1] > maxH)
				maxH = stackHeight[x + 1];
			if (stackHeight[x + 2] > maxH)
				maxH = stackHeight[x + 2];
			if (maxH >= 19)
				lost = true;
			else {
				spaces[x][19 - maxH] = true;
				spaces[x][19 - maxH - 1] = true;
				spaces[x + 1][19 - maxH] = true;
				spaces[x + 2][19 - maxH] = true;
				colors[x][19 - maxH] = 0x00f;
				colors[x][19 - maxH - 1] = 0x00f;
				colors[x + 1][19 - maxH] = 0x00f;
				colors[x + 2][19 - maxH] = 0x00f;
				stackHeight[x] = maxH + 2;
				stackHeight[x + 1] = maxH + 1;
				stackHeight[x + 2] = maxH + 1;
			}
		}
		else if (rotation == 1) {
			maxH = stackHeight[x];
			if (stackHeight[x + 1] > maxH)
				maxH = stackHeight[x + 1];
			if (maxH >= 18)
				lost = true;
			else {
				spaces[x][19 - maxH] = true;
				spaces[x + 1][19 - maxH] = true;
				spaces[x + 1][19 - maxH - 1] = true;
				spaces[x + 1][19 - maxH - 2] = true;
				colors[x][19 - maxH] = 0x00f;
				colors[x + 1][19 - maxH] = 0x00f;
				colors[x + 1][19 - maxH - 1] = 0x00f;
				colors[x + 1][19 - maxH - 2] = 0x00f;
				stackHeight[x] = maxH + 1;
				stackHeight[x + 1] = maxH + 3;
			}
		}
		else if (rotation == 2) {
			bool lower = true;
			maxH = stackHeight[x];
			if (stackHeight[x + 1] > maxH)
				maxH = stackHeight[x + 1];
			if (maxH < stackHeight[x + 2] + 1) {
				maxH = stackHeight [x + 2];
				lower = false;
			}
			if (lower) {
				if (maxH >= 20)
					lost = true;
				else {
					spaces[x][19 - maxH] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 2][19 - maxH] = true;
					spaces[x + 2][19 - maxH + 1] = true;
					colors[x][19 - maxH] = 0x00f;
					colors[x + 1][19 - maxH] = 0x00f;
					colors[x + 2][19 - maxH] = 0x00f;
					colors[x + 2][19 - maxH + 1] = 0x00f;
					stackHeight[x] = maxH + 1;
					stackHeight[x + 1] = maxH + 1;
					stackHeight[x + 2] = maxH + 1;
				}
			}
			else {
				if (maxH >= 19)
					lost = true;
				else {
					spaces[x][19 - maxH - 1] = true;
					spaces[x + 1][19 - maxH - 1] = true;
					spaces[x + 2][19 - maxH - 1] = true;
					spaces[x + 2][19 - maxH] = true;
					colors[x][19 - maxH - 1] = 0x00f;
					colors[x + 1][19 - maxH - 1] = 0x00f;
					colors[x + 2][19 - maxH - 1] = 0x00f;
					colors[x + 2][19 - maxH] = 0x00f;
					stackHeight[x] = maxH + 2;
					stackHeight[x + 1] = maxH + 2;
					stackHeight[x + 2] = maxH + 2;
				}
			}
		}
		else {
			bool lower = false;
			maxH = stackHeight[x];
			if (maxH + 2 < stackHeight[x + 1]) {
				maxH = stackHeight[x + 1];
				lower = true;
			}
			if (lower) {
				if (maxH >= 20)
					lost = true;
				else {
					spaces[x][19 - maxH] = true;
					spaces[x][19 - maxH + 1] = true;
					spaces[x][19 - maxH + 2] = true;
					spaces[x + 1][19 - maxH] = true;
					colors[x][19 - maxH] = 0x00f;
					colors[x][19 - maxH + 1] = 0x00f;
					colors[x][19 - maxH + 2] = 0x00f;
					colors[x + 1][19 - maxH] = 0x00f;
					stackHeight[x] = maxH + 1;
					stackHeight[x + 1] = maxH + 1;
				}
			}
			else {
				if (maxH >= 18)
					lost = true;
				else {
					spaces[x][19 - maxH] = true;
					spaces[x][19 - maxH - 1] = true;
					spaces[x][19 - maxH - 2] = true;
					spaces[x + 1][19 - maxH - 2] = true;
					colors[x][19 - maxH] = 0x00f;
					colors[x][19 - maxH - 1] = 0x00f;
					colors[x][19 - maxH - 2] = 0x00f;
					colors[x + 1][19 - maxH - 2] = 0x00f;
					stackHeight[x] = maxH + 3;
					stackHeight[x + 1] = maxH + 3;
				}
			}
		}
	}
	else { // l block
		if (rotation == 0) {
			maxH = stackHeight[x];
			if (stackHeight[x + 1] > maxH)
				maxH = stackHeight[x + 1];
			if (maxH >= 18)
				lost = true;
			else {
				spaces[x][19 - maxH] = true;
				spaces[x][19 - maxH - 1] = true;
				spaces[x][19 - maxH - 2] = true;
				spaces[x + 1][19 - maxH] = true;
				colors[x][19 - maxH] = 0xfa0;
				colors[x][19 - maxH - 1] = 0xfa0;
				colors[x][19 - maxH - 2] = 0xfa0;
				colors[x + 1][19 - maxH] = 0xfa0;
				stackHeight[x] = maxH + 3;
				stackHeight[x + 1] = maxH + 1;
			}
		}
		else if (rotation == 1) {
			maxH = stackHeight[x];
			if (stackHeight[x + 1] > maxH)
				maxH = stackHeight[x + 1];
			if (stackHeight[x + 2] > maxH)
				maxH = stackHeight[x + 2];
			if (maxH >= 19)
				lost = true;
			else {
				spaces[x][19 - maxH] = true;
				spaces[x + 1][19 - maxH] = true;
				spaces[x + 2][19 - maxH] = true;
				spaces[x + 2][19 - maxH - 1] = true;
				colors[x][19 - maxH] = 0xfa0;
				colors[x + 1][19 - maxH] = 0xfa0;
				colors[x + 2][19 - maxH] = 0xfa0;
				colors[x + 2][19 - maxH - 1] = 0xfa0;
				stackHeight[x] = maxH + 1;
				stackHeight[x + 1] = maxH + 1;
				stackHeight[x + 2] = maxH + 2;
			}
		}
		else if (rotation == 2) {
			bool lower = true;
			maxH = stackHeight[x];
			if (maxH < stackHeight[x + 1] + 2) {
				maxH = stackHeight[x + 1];
				lower = false;
			}
			if (lower) {
				if (maxH >= 20)
					lost = true;
				else {
					spaces[x][19 - maxH] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 1][19 - maxH + 1] = true;
					spaces[x + 1][19 - maxH + 2] = true;
					colors[x][19 - maxH] = 0xfa0;
					colors[x + 1][19 - maxH] = 0xfa0;
					colors[x + 1][19 - maxH + 1] = 0xfa0;
					colors[x + 1][19 - maxH + 2] = 0xfa0;
					stackHeight[x] = maxH + 1;
					stackHeight[x + 1] = maxH + 1;
				}
			}
			else {
				if (maxH >= 18)
					lost = true;
				else {
					spaces[x][19 - maxH - 2] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 1][19 - maxH - 1] = true;
					spaces[x + 1][19 - maxH - 2] = true;
					colors[x][19 - maxH - 2] = 0xfa0;
					colors[x + 1][19 - maxH] = 0xfa0;
					colors[x + 1][19 - maxH - 1] = 0xfa0;
					colors[x + 1][19 - maxH - 2] = 0xfa0;
					stackHeight[x] = maxH + 3;
					stackHeight[x + 1] = maxH + 3;
				}
			}
		}
		else {
			bool lower = true;
			maxH = stackHeight[x + 2];
			if (stackHeight[x + 1] > maxH)
				maxH = stackHeight[x + 1];
			if (maxH < stackHeight[x] + 1) {
				maxH = stackHeight[x];
				lower = false;
			}
			if (lower) {
				if (maxH >= 20)
					lost = true;
				else {
					spaces[x][19 - maxH] = true;
					spaces[x][19 - maxH + 1] = true;
					spaces[x + 1][19 - maxH] = true;
					spaces[x + 2][19 - maxH] = true;
					colors[x][19 - maxH] = 0xfa0;
					colors[x][19 - maxH + 1] = 0xfa0;
					colors[x + 1][19 - maxH] = 0xfa0;
					colors[x + 2][19 - maxH] = 0xfa0;
					stackHeight[x] = maxH + 1;
					stackHeight[x + 1] = maxH + 1;
					stackHeight[x + 2] = maxH + 1;
				}
			}
			else {
				spaces[x][19 - maxH] = true;
				spaces[x][19 - maxH - 1] = true;
				spaces[x + 1][19 - maxH - 1] = true;
				spaces[x + 2][19 - maxH - 1] = true;
				colors[x][19 - maxH] = 0xfa0;
				colors[x][19 - maxH - 1] = 0xfa0;
				colors[x + 1][19 - maxH - 1] = 0xfa0;
				colors[x + 2][19 - maxH - 1] = 0xfa0;
				stackHeight[x] = maxH + 2;
				stackHeight[x + 1] = maxH + 2;
				stackHeight[x + 2] = maxH + 2;
			}
		}
	}
}

void drawBlocks(FrameCore *frame_p) { // Draws the blocks to the screen
	for (int i = 0; i < 10; i++) {
		for (int j = 0; j < 20; j++) {
			int border; int fill = colors[i][j];
			if (fill == 0x0ff) //i block
				border = 0x07f;
			else if (fill == 0xff0) // o block
				border = 0x770;
			else if (fill == 0xf0f) // t block
				border = 0x707;
			else if (fill == 0x0f0) // s block
				border = 0x070;
			else if (fill == 0xf00) // z block
				border = 0x700;
			else if (fill == 0x00f) // j block
				border = 0x007;
			else if (fill == 0xfa0) // l block
				border = 0x850;
			else // blank space
				border = 0x000;

			frame_p->plot_line(283 + (i * 8), 177 + (j * 8), 283 + ((i * 8) + 8), 177 + (j * 8), border);
			frame_p->plot_line(283 + (i * 8), 177 + (j * 8), 283 + (i * 8), 177 + ((j * 8) + 8), border);
			frame_p->plot_line(283 + ((i * 8) + 8), 177 + (j * 8), 283 + ((i * 8) + 8), 177 + ((j * 8) + 8), border);
			for (int k = 1; k < 8; k++) {
				frame_p->plot_line(283 + (i * 8) + 1, 177 + ((j * 8) + k), 283 + ((i * 8) + 8) - 1, 177 + ((j * 8) + k), fill);
			}
			frame_p->plot_line(283 + (i * 8), 177 + ((j * 8) + 8), 283 + ((i * 8) + 8), 177 + ((j * 8) + 8), border);
		}
	}
}

void removeBlocks(int row) { // used for removing blocks when a row is full
	for (int i = row - 1; i >= 0; i--) { // rows to shift down
		for (int j = 0; j < 10; j++) {
			colors[j][i + 1] = colors[j][i];
			spaces[j][i + 1] = spaces[j][i];
		}
	}

	for (int k = 0; k < 10; k++) {
		colors[k][0] = 0x000; // clear top layer
		spaces[k][0] = false;
		stackHeight[k]--;
	}
}

void clearFlash(GpoCore *led_p, OsdCore *osd_p) { // Flashes LEDs and draws to screen when row is full
	static char niceOne[9] {'N', 'i', 'c', 'e', ' ', 'O', 'n', 'e', '!'};
	static char nextBlock[10] {'N', 'e', 'x', 't', ' ', 'B', 'l', 'o', 'c', 'k'};
	static char haveFun[9] {'H', 'a', 'v', 'e', ' ', 'F', 'u', 'n', '!'};

	osd_p->set_color(0x0f0, 0x001); // dark gray/green
	osd_p->clr_screen();

	for (int i = 0; i < 9; i++) {
		osd_p->wr_char(37 + i, 3, niceOne[i], 0);
	}
	led_p->write(0xffff);
	sleep_ms(500);
	osd_p->clr_screen();
	led_p->write(0x0000);
	sleep_ms(500);

	for (int i = 0; i < 9; i++) {
		osd_p->wr_char(37 + i, 3, niceOne[i], 0);
	}
	led_p->write(0xffff);
	sleep_ms(500);
	osd_p->clr_screen();
	led_p->write(0x0000);
	sleep_ms(500);

	for (int i = 0; i < 10; i++) {
		osd_p->wr_char(68 + i, 3, nextBlock[i], 0);
	}
	for (int i = 0; i < 9; i++) {
		osd_p->wr_char(37 + i, 3, haveFun[i], 0);
	}
}

int rowFull() { // checks to see if any rows are full
	for (int i = 0; i < 20; i++) {
		bool full = true;
		for (int j = 0; j < 10; j++) {
			if (!spaces[j][i])
				full = false;
		}
		if (full)
			return i;
	}
	return -1;
}

int blockAddr(int block) { // Returns the block address when rotating a block
	if (block == 0)
		return 0;
	else if (block == 1)
		return 4;
	else if (block == 2)
		return 8;
	else
		return 12;
}

int blockWidth(int block, int rotation) { // returns how wide a block is in terms of single blocks
	if (block == 0) { // i block
		if (rotation == 0 || rotation == 2)
			return 1;
		else
			return 4;
	}
	else if (block == 1) { // o block
		return 2;
	}
	else if (block == 2 || block == 3 || block == 4 || block == 5) { // t block & s block & z block & j block
		if (rotation == 0 || rotation == 2)
			return 3;
		else
			return 2;
	}
	else { // l block
		if (rotation == 0 || rotation == 2)
			return 2;
		else
			return 3;
	}
}

int blockShiftX(int block, int rotation) { // finds how many pixels we need to shift left (because of empty pixel space)
	if (block == 0) { // i block
		if (rotation == 0 || rotation == 1 || rotation == 3)
			return 0;
		else
			return 22;
	}
	else if (block == 1) { // o block
		if (rotation == 0 || rotation == 3)
			return 0;
		else
			return 15;
	}
	else if (block == 2 || block == 3 || block == 4) { // t block & s block & z block
		if (rotation == 0 || rotation == 3)
			return 0;
		else if (rotation == 1)
			return 15;
		else
			return 8;
	}
	else if (block == 5) { // j block
		if (rotation == 0 || rotation == 3)
			return 0;
		else if (rotation == 1)
			return 15;
		else
			return 7;
	}
	else { // l block
		if (rotation == 0 || rotation == 3)
			return 0;
		else if (rotation == 1)
			return 7;
		else
			return 15;
	}
}

int blockShiftY(int block, int rotation) { // returns how many pixels down we need to move the block (because of empty pixel space)
	if (block == 0) { // i block
		if (rotation == 0 || rotation == 1 || rotation == 2)
			return 0;
		else
			return 22;
	}
	else if (block == 1) { // o block
		if (rotation == 0 || rotation == 1)
			return 0;
		else
			return 15;
	}
	else if (block == 2 || block == 3 || block == 4) { // t block & s block & z block
		if (rotation == 0 || rotation == 1)
			return 0;
		else if (rotation == 2)
			return 15;
		else
			return 8;
	}
	else if (block == 5) { // j block
		if (rotation == 0 || rotation == 1)
			return 0;
		else if (rotation == 2)
			return 15;
		else
			return 7;
	}
	else { // l block
		if (rotation == 0 || rotation == 1)
			return 0;
		else if (rotation == 2)
			return 7;
		else
			return 15;
	}
}

int btnClick(Ps2Core *ps2_p) { // Reads which mouse button the user is pressing
	int lbtn = 0, rbtn = 0, xmov = 0, ymov = 0;
	static bool isPressing = false;
	if (ps2_p->get_mouse_activity(&lbtn, &rbtn, &xmov, &ymov)) {
	}   // end get_mouse_activitiy()
	if (rbtn) {
		if (!isPressing) {
			return 2;
		}
		isPressing = true;
	}
	else if (lbtn) {
		return 1;
	}
	else
		isPressing = false;

	return 0;
}

void setRGB(PwmCore *pwm_p, int blkColor, bool led2) { // Sets the RGB LEDs color based on current and next block
	int red = 0, green = 0, blue = 0;
	if (led2) {
		green = 1; blue = 2;
	}
	else {
		red = 3; green = 4; blue = 5;
	}

	if (blkColor == 0) {  // i block cyan
		pwm_p->set_duty(0.0, red);	//Red = 0
		pwm_p->set_duty(0.25, green);	//Green = 1
		pwm_p->set_duty(0.25, blue);	//Blue = 2
	}
	else if (blkColor == 1) { // o block yellow
		pwm_p->set_duty(0.25, red);	//Red = 0
		pwm_p->set_duty(0.25, green);	//Green = 1
		pwm_p->set_duty(0.0, blue);	//Blue = 2
	}
	else if (blkColor == 2) { // t block purple
		pwm_p->set_duty(0.25, red);	//Red = 0
		pwm_p->set_duty(0.0, green);	//Green = 1
		pwm_p->set_duty(0.25, blue);	//Blue = 2
	}
	else if (blkColor == 3) { // s block green
		pwm_p->set_duty(0.0, red);	//Red = 0
		pwm_p->set_duty(0.25, green);	//Green = 1
		pwm_p->set_duty(0.0, blue);	//Blue = 2
	}
	else if (blkColor == 4) { // z block red
		pwm_p->set_duty(0.25, red);	//Red = 0
		pwm_p->set_duty(0.0, green);	//Green = 1
		pwm_p->set_duty(0.0, blue);	//Blue = 2
	}
	else if (blkColor == 5) { // j block blue
		pwm_p->set_duty(0.0, red);	//Red = 0
		pwm_p->set_duty(0.0, green);	//Green = 1
		pwm_p->set_duty(0.25, blue);	//Blue = 2
	}
	else { // l block orange
		pwm_p->set_duty(0.25, red);	//Red = 0
		pwm_p->set_duty(0.0775, green);	//Green = 1
		pwm_p->set_duty(0.0, blue);	//Blue = 2
	}
}

int moveBlock(XadcCore *adc_p, int blockWidth) { // Uses the XADC and a potentiometer to move a block on screen
	double reading = adc_p->read_adc_in(0);

	// *** Depending on the width of each block, user can only move *** //
	// *******   a certain amount to keep the block in bounds   ******* //

	if (blockWidth == 1) { // 1 block wide
		if (reading < 0.1)
			return 72;
		else if (reading < 0.2)
			return 64;
		else if (reading < 0.3)
			return 56;
		else if (reading < 0.4)
			return 48;
		else if (reading < 0.5)
			return 40;
		else if (reading < 0.6)
			return 32;
		else if (reading < 0.7)
			return 24;
		else if (reading < 0.8)
			return 16;
		else if (reading < 0.9)
			return 8;
		else
			return 0;
	}
	else if (blockWidth == 2) { // 2 blocks wide
		if (reading < 0.2)
			return 64;
		else if (reading < 0.3)
			return 56;
		else if (reading < 0.4)
			return 48;
		else if (reading < 0.5)
			return 40;
		else if (reading < 0.6)
			return 32;
		else if (reading < 0.7)
			return 24;
		else if (reading < 0.8)
			return 16;
		else if (reading < 0.9)
			return 8;
		else
			return 0;
	}
	else if (blockWidth == 3) { // 3 blocks wide
		if (reading < 0.3)
			return 56;
		else if (reading < 0.4)
			return 48;
		else if (reading < 0.5)
			return 40;
		else if (reading < 0.6)
			return 32;
		else if (reading < 0.7)
			return 24;
		else if (reading < 0.8)
			return 16;
		else if (reading < 0.9)
			return 8;
		else
			return 0;
	}
	else { // 4 blocks wide
		if (reading < 0.4)
			return 48;
		else if (reading < 0.5)
			return 40;
		else if (reading < 0.6)
			return 32;
		else if (reading < 0.7)
			return 24;
		else if (reading < 0.8)
			return 16;
		else if (reading < 0.9)
			return 8;
		else
			return 0;
	}
}