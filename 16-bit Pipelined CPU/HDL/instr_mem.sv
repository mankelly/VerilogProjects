`timescale 1ns / 1ps

module instr_mem
    (
    input logic[15:0] addr,
    input logic wr_en,
    input logic[15:0] wr_data,
    output logic[15:0] rd_data
    );
    
    logic[15:0] mem[0:15]; //logic[DATA_WIDTH] mem[ADDR_WIDTH];
    
    initial begin
        
        // FILL WITH INSTRUCTIONS
        mem[0] = 16'b1111_0000_0000_0000; // JUMP
        mem[1] = 16'b0010_0111_1111_1010;
        mem[2] = 16'b0010_0110_1010_1111;
        mem[3] = 16'b1100_0010_0110_0111;
        mem[4] = 16'b0111_0011_0110_0111;
        mem[5] = 16'b1111_0000_0000_0000; // JUMP
        mem[6] = 16'b0010_0111_1111_1010;
        
        
    end;
    
    always_comb
    begin
        if (wr_en)
            begin
                mem[addr[3:0]] = wr_data;
            end
    end;
    
    assign rd_data = mem[addr[3:0]];
    
endmodule
