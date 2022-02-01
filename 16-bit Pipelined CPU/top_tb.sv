`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/29/2021 08:54:32 PM
// Design Name: 
// Module Name: top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_tb;

logic clk = 1;
logic resetn = 0;
logic[7:0] led;

data_path tb(.*, .DATA_OUT(led));
initial begin
    #20 resetn = 1;
end

always
    #10 clk = ~clk;

endmodule
