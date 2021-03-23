`timescale 1ns / 1ps

module top
    (
        input logic clk, reset, stop,
        input logic [7:0] sw,
        output logic [15:0] led,
        output logic [6:0] seg,
        output logic [7:0] an
    );
    logic shiftClk, segClk;
    logic [3:0] d0, d1, d2;
    logic [6:0] seg0, seg1, seg2;
    logic [1:0] segCount;
    
    //circuit for led output
    shift_delay stage0(clk, reset, sw, shiftClk);
    shift stage1(shiftClk, reset, stop, led);
    
    //circuit for 7seg output
    delay_digits stage3(sw, d0, d1, d2);
    delay_to_7seg stage4(d0, seg0); //7seg output for seg0
    delay_to_7seg stage5(d1, seg1); //7seg output for seg1
    delay_to_7seg stage6(d2, seg2); //7seg output for seg2
    
    //slow clock used for 7seg
    slwClk_160Hz stage7(clk, reset, segClk); //used 160Hz clk for simple and clean math
    mod3_counter stage8(segClk, reset, segCount); //counts up to 3 for the 3 7seg's
    mux3to1 stage9(segCount, seg0, seg1, seg2, seg);
    selector stage10(segCount, an); //determines which 7seg to turn on
    
endmodule
