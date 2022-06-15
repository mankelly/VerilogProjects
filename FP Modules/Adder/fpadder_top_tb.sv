`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Manuel Kelly
// 
// Design Name: 32-Bit Floating Point Adder Testbench
// Module Name: fpadder_top_tb
// Project Name: RISC-V ISA CPU [Eventually]
// Target Devices: All FPGAs
// Tool Versions: Vivado 2019.2
// Description: Basic FP Adder To Eventually Be Put In An ALU
// 
// Revision 0.10 - Completed And Assumed To Be Working
// Additional Comments: **** NOT A FULL TEST BENCH!!!!! ****.
//                      **** ONLY TESTS A FEW ADDITIONS ****
// 
//////////////////////////////////////////////////////////////////////////////////


module fpadder_top_tb;
    
    logic [31:0] a;
    logic [31:0] b;
    logic [31:0] c;
    logic ov; // Overflow flag
    
    fpadder_top top_inst(.*);
    
    initial begin
        a = 32'h42CDE666; //102.95
        b = 32'hC25909A8; //-54.25943 
        //c=0x4242C324
        #200;
        
        a = 32'h41700000; //15.0
        b = 32'hC1F00000; //-30.0
        //c=0xC1700000
        #200;
        
        a = 32'h41700000; //15.0
        b = 32'hC1700000; //-15.0
        //c=0x00000000
        #200;
        
        a = 32'h3F800000; //1.0
        b = 32'h41F00000; //30.0
        //c=0x41F80000
        #200;
        
        a = 32'hBF800000; //-1.0
        b = 32'h41F00000; //30.0
        //c=0x41E80000
        #200;
        
    end
    
endmodule
