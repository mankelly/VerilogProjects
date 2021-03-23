#ifndef _FIFO_H_INCLUDED
#define _FIFO_H_INCLUDED

#include "chu_init.h"

class fifoCore {
public:
   /**
    * register map
    *
    */
	enum {
		RD_DATA = 0, // addr = 0 so we can read rd_data without reading from the FIFO
		WR_FIFO = 1, // addr = 1 for writing to FIFO
		RD_FIFO = 2, // addr = 2 for reading from FIFO

	     };
	enum {
		FULL_FIELD = 0x80000000, /**< bit 31 of rd_data_reg; full bit  */
		EMPT_FIELD = 0x40000000, /**< bit 30 of rd_data_reg; empty bit */
		DATA_FIELD = 0x000000ff  /**< bits 7..0 rd_data_reg; read data */
		 };

   // constructor
   fifoCore(uint32_t core_base_addr);
   ~fifoCore();                  // not used

   // write a 8-bit word
   void write(uint32_t data);

   // read an 8-bit word
   int read();

   // checks if FIFO is empty
   int fifoEmpty();

   // checks if FIFO is full
   int fifoFull();

private:
   uint32_t base_addr;
   uint32_t wr_data;      // same as GPO core data reg
};

#endif
