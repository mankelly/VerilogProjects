#include "functions.h"

void calcRead(DebounceCore *btn_p, fifoCore *fifo_p, GpoCore *gpo_p, SsegCore *sseg_p) { // calculate the sum of everything in the FIFO and writes it to the upper 4 7segs
	static int temp = 0;
	static bool pressing = false; // Static bool used as false only in the first cycle of pressing the read button
	if (btn_p->read_db(2) == 1) {
		if(!pressing) { // initially false but changes to true after the first cycle of holding the button
			if (!fifo_p->fifoEmpty()) {
				temp = 0;
				for (int i = 0; i < 4; i++){ // reads 4 times and calculates the sum
					temp += fifo_p->read();
				}
				pressing = true; // sets it to true so it doesn't continue to read in the next cycle
				sseg_disp7_4(sseg_p, temp);
				uart.disp("FIFO Read (Add All): ");
				uart.disp(temp, 3);
				uart.disp("\n\r");
			}
			else { // flash LEDs
				gpo_p->write(0xFFFFFFFF); // LEDs on
				sleep_ms(250);
				gpo_p->write(0x00000000); // LEDs off
				sleep_ms(250);
			}
		}
	}
	else
		pressing = false;
}

void writeVal(DebounceCore *btn_p, fifoCore *fifo_p, int wr_data, GpoCore *gpo_p) { // used for the button to write to the FIFO
	static bool pressing = false; // Static bool used as false only in the first cycle of pressing the read button
	if (btn_p->read_db(0) == 1) {
		if (!pressing) { // initially false but changes to true after the first cycle of holding the button
			if(!fifo_p->fifoFull()) {
				pressing = true; // sets it to true so it doesn't continue to write in the next cycle
				fifo_p->write(wr_data);
			}
			else { // flash LEDs
				gpo_p->write(0xFFFFFFFF); // LEDs on
				sleep_ms(250);
				gpo_p->write(0x00000000); // LEDs off
				sleep_ms(250);
			}
		}
	}
	else
		pressing = false;
}

void sseg_disp3_0(SsegCore *sseg_p, int reading) // for turning on lower 4 7seg displays
{
	int ones = reading % 10;
	int tens = (reading % 100) / 10;
	int hundreds = reading / 100;

	sseg_p->set_dp(0x00);							//Set first dp on
	sseg_p->write_1ptn(sseg_p->h2s(ones), 0);
	if(reading >= 10)
		sseg_p->write_1ptn(sseg_p->h2s(tens), 1);
	else
		sseg_p->write_1ptn(0xff, 1);
	if(reading >= 100)
		sseg_p->write_1ptn(sseg_p->h2s(hundreds), 2);
	else
		sseg_p->write_1ptn(0xff, 2);

	sseg_p->write_1ptn(0xff, 3);
}

void sseg_disp7_4(SsegCore *sseg_p, int reading) // for turning on upper 4 7seg displays
{
	int ones = reading % 10;
	int tens = (reading / 10) % 10;
	int hundreds = (reading % 1000) / 100;
	int thousands = reading / 1000;

	sseg_p->set_dp(0x00);							//Set fifth dp on
	sseg_p->write_1ptn(sseg_p->h2s(ones), 4);
	if(reading >= 10)
		sseg_p->write_1ptn(sseg_p->h2s(tens), 5);
	else
		sseg_p->write_1ptn(0xff, 5);
	if(reading >= 100)
		sseg_p->write_1ptn(sseg_p->h2s(hundreds), 6);
	else
		sseg_p->write_1ptn(0xff, 6);
	if(reading >= 1000)
		sseg_p->write_1ptn(sseg_p->h2s(thousands), 7);
	else
		sseg_p->write_1ptn(0xff, 7);
}


int calculate_value(double read) { // used to convert the voltage reading from 0->255
	    if(read > 1) // just so it reaches 255 with my current potentiometer
	        return 255;
	    return read * 256; // Calculate between 0 -> 255 for out number read from the pot
	    // read * 256 because the voltage never reaches 1 (goes to 0.999)
}

int voltageRead(XadcCore *adc_p, SsegCore *sseg_p) { // reads the voltage of the XADC and writes it to the lower 4 7segs
		double reading = 0.0;
		reading = calculate_value(adc_p->read_adc_in(0));
		sseg_disp3_0(sseg_p, (int) reading);

		return (int) reading;
}

void ledCheck(GpoCore *gpo_p, int empty, int full) {  // checks to turn to on the empty/full flags
	gpo_p->write(full, 1);
	gpo_p->write(empty, 0);
}
