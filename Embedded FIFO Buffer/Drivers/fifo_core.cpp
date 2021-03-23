#include "fifo_core.h"

fifoCore::fifoCore(uint32_t core_base_addr) { // constructor
   base_addr = core_base_addr;
   wr_data = 0;
}

fifoCore::~fifoCore() { // not used
}

void fifoCore::write(uint32_t data) { // write a 8-bit word
	if (fifoFull() != 1) {
		wr_data = data;
		uart.disp("Write: ");
		uart.disp((int)data);
		uart.disp("\n\r");
		io_write(base_addr, WR_FIFO, wr_data);
	}
	//}
}

int fifoCore::read() { // read an 8-bit word
	if (fifoEmpty() != 1) {
		int data = io_read(base_addr, RD_FIFO) & DATA_FIELD;
		uart.disp("Read: ");
		uart.disp(data);
		uart.disp("\n\r");
		return data;
	}
	else
		return 0;
}

int fifoCore::fifoEmpty() { // checks if FIFO is empty
	uint32_t rd_word;
	int empty;

	rd_word = io_read(base_addr, RD_DATA);
	empty = (int) (rd_word & EMPT_FIELD) >> 30;
	return (empty);
}

int fifoCore::fifoFull() { // checks if FIFO is full
	uint32_t rd_word;
	int full;

	rd_word = io_read(base_addr, RD_DATA);
	full = (int) (rd_word & FULL_FIELD) >> 31;
	return (full);
}
