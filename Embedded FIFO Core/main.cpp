// #define _DEBUG
#include "functions.h" // all other .h files are included in the functions.h file to make main file cleaner

GpoCore led(get_slot_addr(BRIDGE_BASE, S2_LED));
GpiCore sw(get_slot_addr(BRIDGE_BASE, S3_SW));
XadcCore adc(get_slot_addr(BRIDGE_BASE, S5_XDAC));
PwmCore pwm(get_slot_addr(BRIDGE_BASE, S6_PWM));
DebounceCore btn(get_slot_addr(BRIDGE_BASE, S7_BTN));
SsegCore sseg(get_slot_addr(BRIDGE_BASE, S8_SSEG));
SpiCore spi(get_slot_addr(BRIDGE_BASE, S9_SPI));
I2cCore adt7420(get_slot_addr(BRIDGE_BASE, S10_I2C));
Ps2Core ps2(get_slot_addr(BRIDGE_BASE, S11_PS2));
DdfsCore ddfs(get_slot_addr(BRIDGE_BASE, S12_DDFS));
AdsrCore adsr(get_slot_addr(BRIDGE_BASE, S13_ADSR), &ddfs);
fifoCore fifo(get_slot_addr(BRIDGE_BASE, S4_FIFO));

int main() {
	int temp = 0; // stores the value of the XADC voltage reading
	while (1) {
	   temp = voltageRead(&adc, &sseg); // reads voltage and also writes the conversion to the lower 4 7segs
	   writeVal(&btn, &fifo, temp, &led); // converts/writes the voltage reading to FIFO buffer
	   calcRead(&btn, &fifo, &led, &sseg); // used for summing FIFO and displaying to the upper 4 7segs
	   ledCheck(&led, fifo.fifoEmpty(), fifo.fifoFull()); // checks/outputs the full/empty flags
   } //while
} //main
