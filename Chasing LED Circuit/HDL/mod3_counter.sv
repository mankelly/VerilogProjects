`timescale 1ns / 1ps

module mod3_counter
    (
        input logic clk, reset,
        output logic [1:0] count
    );
    logic [1:0] r_next, r_reg;
    
    //register segment
    always_ff @(posedge clk, posedge reset)
        begin
            if(reset)
                r_reg<=0;
            else
                r_reg<=r_next;
        end
    
    //next state logic segment
    always_comb
        begin
            if(r_reg == 2'b10)  
                r_next = 0;
            else
                r_next = r_reg+1;
        end
    
    //output logic segment
    assign count = r_reg;
endmodule
