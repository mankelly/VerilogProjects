`timescale 1ns / 1ps
module alu_ctrl
    (
    input logic[3:0] instr,
    output logic[3:0] ctrl
    );
    
    always_comb
    begin
        
        case(instr)
            
            4'h5: ctrl = 4'h0; //AND
            4'h6: ctrl = 4'h1; //OR
            4'h7: ctrl = 4'h2; //XOR
            4'h8: ctrl = 4'h3; //ONES COMP
            4'h9: ctrl = 4'h4; //TWOS COMP
            4'ha: ctrl = 4'h5; //SL
            4'hb: ctrl = 4'h6; //SR
            4'hc: ctrl = 4'h7; //ADD
            4'hd: ctrl = 4'h8; //SUB
            4'he: ctrl = 4'h9; //MUL
            
            
            default: ctrl = 4'hf;
            
        endcase;
        
    end;
    
endmodule
