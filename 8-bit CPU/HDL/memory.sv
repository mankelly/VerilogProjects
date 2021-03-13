`timescale 1ns / 1ps

module memory
    #(parameter ADDR_WIDTH = 4, DATA_WIDTH = 8)
    (
        input logic clk, 
        input logic wr_en,
        input logic [ADDR_WIDTH-1: 0] rd_addr,
        input logic [ADDR_WIDTH-1: 0] wr_addr,
        input logic [DATA_WIDTH-1: 0] wr_data,
        output logic [DATA_WIDTH-1:0] rd_data
    );
    logic [DATA_WIDTH-1: 0] mem [0: 2**ADDR_WIDTH-1];
    
    always_ff@(posedge clk)
        begin
            if(wr_en)
                mem[wr_addr] <= wr_data[DATA_WIDTH-1: 0];
        end
    assign rd_data = mem[rd_addr];
endmodule
