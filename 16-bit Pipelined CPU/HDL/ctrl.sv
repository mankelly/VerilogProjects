`timescale 1ns / 1ps

module ctrl
    (
    input logic[3:0] instr,
    output logic reg_to_reg,
    output logic reg_to_mem,
    output logic mem_to_reg,
    output logic r,
    output logic i,
    output logic j,
    output logic[1:0] alu_op
    );
    
    always_comb
    begin
        
        case(instr)
            
            4'h0: // No Op
            begin
                reg_to_reg = 0;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 0;
                i = 0;
                j = 0;
                alu_op = "11"; // DO NOTHING
            end 
            
            4'h1: // LOAD
            begin
                reg_to_reg = 0;
                reg_to_mem = 0;
                mem_to_reg = 1;
                r = 1;
                i = 0;
                j = 0;
                alu_op = "10"; // PASS THROUGH
            end 
            
            4'h2: // LOAD IMMEDIATE
            begin
                reg_to_reg = 1;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 0;
                i = 1;
                j = 0;
                alu_op = "10"; // PASS THROUGH
            end 
            
            4'h3: // STORE
            begin
                reg_to_reg = 0;
                reg_to_mem = 1;
                mem_to_reg = 0;
                r = 1;
                i = 0;
                j = 0;
                alu_op = "10"; // PASS THROUGH
            end 
            
            4'h4: // MOVE
            begin
                reg_to_reg = 1;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 1;
                i = 0;
                j = 0;
                alu_op = "10"; // PASS THROUGH
            end 
            
            4'h5: // AND
            begin
                reg_to_reg = 1;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 1;
                i = 0;
                j = 0;
                alu_op = "01"; // USE ALU
            end 
            
            4'h6: // OR
            begin
                reg_to_reg = 1;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 1;
                i = 0;
                j = 0;
                alu_op = "01"; // USE ALU
            end 
            
            4'h7: // XOR
            begin
                reg_to_reg = 1;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 1;
                i = 0;
                j = 0;
                alu_op = "01"; // USE ALU
            end 
            
            4'h8: // ONE'S COMPLIMENT
            begin
                reg_to_reg = 1;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 1;
                i = 0;
                j = 0;
                alu_op = "01"; // USE ALU
            end 
            
            4'h9: // TWO'S COMPLIMENT
            begin
                reg_to_reg = 1;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 1;
                i = 0;
                j = 0;
                alu_op = "01"; // USE ALU
            end 
            
            4'ha: // SL
            begin
                reg_to_reg = 1;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 1;
                i = 0;
                j = 0;
                alu_op = "01"; // USE ALU
            end 
            
            4'hb: // SR
            begin
                reg_to_reg = 1;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 1;
                i = 0;
                j = 0;
                alu_op = "01"; // USE ALU
            end 
            
            4'hc: // ADD
            begin
                reg_to_reg = 1;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 1;
                i = 0;
                j = 0;
                alu_op = "01"; // USE ALU
            end 
            
            4'hd: // SUB
            begin
                reg_to_reg = 1;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 1;
                i = 0;
                j = 0;
                alu_op = "01"; // USE ALU
            end 
            
            4'he: // MUL
            begin
                reg_to_reg = 1;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 1;
                i = 0;
                j = 0;
                alu_op = "01"; // USE ALU
            end 
            
            4'hf: // J
            begin
                reg_to_reg = 0;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 0;
                i = 0;
                j = 1;
                alu_op = "00"; // JUMP
            end 
            
            default: 
            begin
                reg_to_reg = 0;
                reg_to_mem = 0;
                mem_to_reg = 0;
                r = 0;
                i = 0;
                j = 0;
            end
            
        endcase;
        
    end;
    
    
endmodule
