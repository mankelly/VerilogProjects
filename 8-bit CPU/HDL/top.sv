`timescale 1ns / 1ps

module top
    #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 4)
    (
        input logic clk, reset,
        input logic wr,
        input logic [DATA_WIDTH-1: 0] A, B,
        input logic [DATA_WIDTH-1: 0] opcode,
        output logic [DATA_WIDTH-1: 0] Y
    );
    
    logic [DATA_WIDTH-1: 0] instr, instr_next, pc, pc_next; //instruction register and program counter
    logic full, empty;
    logic [ADDR_WIDTH - 1: 0] wr_addr;
    
    always_ff@(posedge clk, posedge reset)
        begin
            if (reset)
                begin
                    Y <= 0;
                    instr <= 0;
                    pc <= 0;
                    wr_addr <= 0;
                end
        end
    //fifo_ctrl for instr mem
    fifo_ctrl instr_ctrl(clk, reset, wr, ~empty, full, empty, wr_addr, pc); // always read when not empty
    memory instr_mem(clk, wr, pc, wr_addr, opcode, instr);
    ALU alu_8_bit(clk, reset, A, B, instr, Y);                                                                                                                                            

endmodule
