`timescale 1ns / 1ps

module data_mem
    (
    input logic[7:0] addr,
    input logic wr_en,
    input logic[15:0] wr_data,
    output logic[15:0] rd_data,
    output logic[15:0] DATA_OUT // MMIO
    );
    
    //logic[15:0] mem[0:(2**8)-1];
    logic[15:0] mem[0:15];
    
    // WRITE LOGIC
    always_comb
    begin
        if (wr_en)
        begin
            mem[addr] = wr_data;
        end
    end;
    
    assign rd_data = mem[addr];
    
    //MMIO
    assign DATA_OUT = mem[0];
    
endmodule
