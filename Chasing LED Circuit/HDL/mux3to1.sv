`timescale 1ns / 1ps

module mux3to1
    (
        input logic [1:0] select,
        input logic [6:0] seg0,
        input logic [6:0] seg1,
        input logic [6:0] seg2,
        output logic [6:0] out
    );
    always_comb
        begin
            case(select)
                2'b00: out = seg0;
                2'b01: out = seg1;
                2'b10: out = seg2;
                default: out = 0;
            endcase
        end
endmodule
