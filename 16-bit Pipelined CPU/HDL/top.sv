`timescale 1ns / 1ps

module top
    (
    input logic clk,
    input logic resetn
    );
    
    logic[15:0] IR;
    logic[1:0] alu_op;
    logic[5:0] ctrl_bus, ctrl_bus_next;
    
    
    data_path cpu_path(.*);
    
endmodule
