`timescale 1ns / 1ps

module cpu_tb #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 4);
logic clk, reset;
logic wr;
logic [DATA_WIDTH-1: 0] A, B;
logic [DATA_WIDTH-1: 0] opcode;
logic [DATA_WIDTH-1: 0] Y;

top uut(.clk(clk), .reset(reset), .wr(wr), .A(A), .B(B), .opcode(opcode), .Y(Y));
initial begin
    clk = 1;
    reset = 1;
    #10 reset = 0;
    wr = 1;
    A = 8'b00001000;
    B = 8'b00000100;
    opcode = 8'b00000000;
    #10 opcode = 8'b00000010;
    #10 opcode = 8'b00010100;
    #10 wr = 0;
end
always #5 clk = !clk;

endmodule
