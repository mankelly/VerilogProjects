`timescale 1ns / 1ps

module fifo_buffer
  #( parameter DATA_WIDTH = 8, // Indicates the size of values to be stored into the FIFO buffer in Core 4
               ADDR_WIDTH = 2 // Indicates the amount of values to be stored into the FIFO buffer in Core 4
   )  
   (
    input  logic clk,
    input  logic reset,
    // slot interface
    input  logic cs,
    input  logic read,
    input  logic write,
    input  logic [4:0] addr,
    input  logic [31:0] wr_data,
    output logic [31:0] rd_data
   );
   
   logic wr, rd;
   
   fifo #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) fifo_buff
      (.clk(clk), .reset(reset), .rd(rd), .wr(wr), .w_data(wr_data[7:0]),
       .empty(rd_data[30]), .full(rd_data[31]), .r_data(rd_data[7:0])); // I use bit 30 and 31 for the empty/full flags
  
   assign wr = (write && cs && (addr[1:0]==2'b01));
   assign rd = (read && cs && (addr[1:0]==2'b10));
       
endmodule
