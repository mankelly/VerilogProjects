# Final Project: Nexys Tetris [Manuel Kelly]
### YouTube Link: https://www.youtube.com/watch?v=3EtIybUcsiU&t=5s&ab_channel=Mvnkelly
### ** NOT SHOWN IN VIDEO ** When the player loses, the game will return to the main menu. I cut that part of the video out to save time on the video length.
### Tetris using the Nexys4
* This project is a level of the video game Tetris. 
* For video output, we will be using the VGA interface.
* Game menu allows the user to start or end the game with mouse input.
* To control the movement of the blocks, the user will:
  * Use a potentiometer (implementing the XADC) to move the block left and right.
  * Use a mouse left click to drop the block.
  * Use a mouse right click to rotate the block.
* If the player completely fills a row, (from left to right with blocks), all LEDs will flash.
* RGB LED1 will show the color of the current block.
* RGB LED2 will show the color of the next block.

### ** THINGS ADDED/CHANGED TO HDL CODE **
* Both user sprite cores were used to implement all of the block sprites.
* Each block (7 of them) have 4 unique sprites for each rotation.
* User core 4 was changed to block_core which stored 4 different blocks.
  * Each of the 4 blocks have a total of four sprites for their rotations.
  * block_core stored 16 unique sprites.
* User core 5 was changed to block_core2 which stored another 3 blocks.
  * Each of the 3 blocks have a total of four sprites for their rotations.
  * block_core stored 12 unique sprites.
* 28 unique sprites were created and combined with 2 new cores for use in my game.

|Video|
|:--:|
|[![VIDEO](https://i.ytimg.com/vi/3EtIybUcsiU/maxresdefault.jpg)](https://www.youtube.com/watch?v=3EtIybUcsiU&t=204s&ab_channel=Mvnkelly)|
