`timescale 1ns / 1ps

module shift_delay
    (
        input logic clk, reset,
        input logic [7:0] sw,
        output logic slwClk
    );
    logic [24:0] r_next, r_reg; //used to count to the max delay (500ms)
    logic out_reg, out_next;
    
    //register segment
    always_ff @(posedge clk, posedge reset)
        begin
            if(reset)
                begin
                    r_reg<=0;
                    out_reg<=1;
                end
            else
                begin
                    r_reg<=r_next;
                    out_reg<=out_next;
                end
        end
    
    //next state logic segment
    always_comb
        begin
            if (r_reg == (2_500_000 + sw*88_235)) //2_500_000 is the minimum half cycle and 176_470 
                begin                              //is roughly each step for the 8-bit input
                    r_next = 0;
                    out_next=~out_reg;                        
                end
            else
                begin
                    r_next = r_reg+1;
                    out_next=out_reg;
                end
        end
    
    //output logic segment
    assign slwClk = out_reg;
endmodule
