`timescale 1ns / 1ps

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
