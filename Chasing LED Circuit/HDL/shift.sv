`timescale 1ns / 1ps

module shift
    (
        input logic clk, reset, stop,
        output logic [15:0] out
    );
    logic [15:0] out_next, out_reg;
    logic [3:0] r_next, r_reg;
    logic right_next, right;
    
    //register segment
    always_ff @(posedge clk, posedge reset)
        begin
            if(reset)
                begin
                    r_reg<=0;
                    right<=0;
                    out_reg<=16'b0000000000000001;
                end
            else
                begin
                    r_reg<=r_next;
                    right<=right_next;
                    out_reg<=out_next;
                end
        end
        
    //next-state logic segment
    always_comb
        begin
            if(stop)
                begin
                    out_next = out_reg;
                    r_next = r_reg;
                    right_next = right;
                end
            else
                begin    
                    if(right)
                        begin
                            out_next<=out_reg>>1;
                            if(r_reg == 4'b1110)
                                begin
                                    r_next = 0;
                                    right_next = ~right;
                                end
                            else
                                begin
                                    r_next = r_reg+1;
                                    right_next = right;
                                end
                        end
                    else
                        begin
                            out_next<=out_reg<<1;
                            if(r_reg == 4'b1110)
                                begin
                                    r_next = 0;
                                    right_next = ~right;
                                end
                            else
                                begin
                                    r_next = r_reg+1;
                                    right_next = right;
                                end
                        end
                  end
        end
        
        //output logic segment
        assign out = out_reg;
endmodule
