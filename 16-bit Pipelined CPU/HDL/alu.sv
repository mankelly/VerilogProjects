`timescale 1ns / 1ps

module alu
    (
    input logic[1:0] alu_op,
    input logic[3:0] ctrl,
    input logic[15:0] A,
    input logic[15:0] B,
    output logic[15:0] C
    );
    
    always_comb
    begin
        
        if (alu_op == "10")
        begin
            C = A; //PASS THROGUH
        end 
        
        else if(alu_op == "01")
            begin
                case(ctrl)
                    
                    4'h0: C = A & B; //AND
                    4'h1: C = A | B; //OR
                    4'h2: C = A ^ B; //XOR
                    4'h3: C = ~A; //ONE'S COMP
                    4'h4: C = ~(A-1); //TWO'S COMP
                    4'h5: C = A << 1; //SL
                    4'h6: C = A >> 1; //SR
                    4'h7: C = A + B; //ADD
                    4'h8: C = A - B; //SUB
                    4'h9: C = A * B; //MUL
                    
                    default: C = 0;
                    
                endcase;
            end
        else
            begin
                C = 0;
            end
    end;
    
endmodule
