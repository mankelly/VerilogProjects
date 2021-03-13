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
    A = 8'b00001000; //8
    B = 8'b00000100; //4
    opcode = 8'b00000000; //add
    #10 opcode = 8'b00000010; //sub
    #10 opcode = 8'b00010100; //two's comp of A
    #10 opcode = 8'b00001000; //and
    #10 opcode = 8'b00001001; //or
    #10 opcode = 8'b00001010; //xor
    #10 opcode = 8'b00011011; //one's comp of A
    #10 opcode = 8'b00001110; //rotate A right 
    #10 opcode = 8'b00011110; //rotate A left
    #10 wr = 0;
end
always #5 clk = !clk;

endmodule
