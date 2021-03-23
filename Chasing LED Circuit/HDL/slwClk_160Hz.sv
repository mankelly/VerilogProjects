`timescale 1ns / 1ps

module slwClk_160Hz
    (
        input logic clk, reset,
        output logic slwClk
    );
    logic [18:0] r_next, r_reg;
    logic clk_next, clk_reg;
    
    //register segment
    always_ff @(posedge clk, posedge reset)
        begin
            if(reset)
                begin
                    r_reg<=0;
                    clk_reg<=0;
                end
            else
                begin
                    r_reg<=r_next;
                    clk_reg<=clk_next;
                end
        end
        
    //next state logic segment
    always_comb
        begin
            if(r_reg == 312_500)
                begin
                    r_next = 0;
                    clk_next = ~clk_reg;
                end
            else
                begin
                    r_next = r_reg+1;
                    clk_next = clk_reg;
                end
        end
    
    //output logic segment
    assign slwClk = clk_reg;
endmodule
