`timescale 1ns / 1ps

module fifo_ctrl
    #(parameter ADDR_WIDTH = 4)
    (
        input logic clk, reset,
        input logic wr, rd,
        output logic full, empty,
        output logic [ADDR_WIDTH - 1: 0] wr_addr,
        output logic [ADDR_WIDTH - 1: 0] rd_addr
    );
    
    logic [ADDR_WIDTH - 1: 0] wr_ptr, wr_ptr_next;
    logic [ADDR_WIDTH - 1: 0] rd_ptr, rd_ptr_next;
    logic full_next, empty_next;
    
    // Register Segment
    always_ff @(posedge clk, posedge reset)
        begin
            if (reset)
                begin
                    full <= 0;
                    empty <= 1;
                    wr_ptr <= 0;
                    rd_ptr <= 0;
                end
            else
                begin
                    full <= full_next;
                    empty <= empty_next;
                    wr_ptr <= wr_ptr_next;
                    rd_ptr <= rd_ptr_next;
                end
        end
    // Next State Logic
    always_comb
        begin
            full_next = full;
            empty_next = empty;
            wr_ptr_next = wr_ptr;
            rd_ptr_next = rd_ptr;
            
            unique case({wr, rd})
                2'b01: //read
                    begin
                        if(~empty)
                            begin
                                rd_ptr_next = rd_ptr+1;
                                full_next = 0;
                                if (rd_ptr_next == wr_ptr)
                                    empty_next = 1'b1;
                            end
                    end
                2'b10: //write
                    begin
                        if (~full)
                            begin
                                wr_ptr_next = wr_ptr+1;
                                empty_next = 0;
                                if (wr_ptr_next == rd_ptr)
                                    full_next = 1'b1;
                            end
                    end
                2'b11: //read and write
                    begin
                        if (~empty)
                            begin
                                wr_ptr_next = wr_ptr+1;
                                rd_ptr_next = rd_ptr+1;
                            end
                    end
                default: ;// no read/write DO NOTHING
            endcase
        end
    
    // Output Logic
    assign wr_addr = wr_ptr;    
    assign rd_addr = rd_ptr;
endmodule
