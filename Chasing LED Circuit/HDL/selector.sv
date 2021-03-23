`timescale 1ns / 1ps

module selector
    (
        input logic [1:0] select,
        output logic [7:0] out
    );
    always_comb
        begin
            case(select)
                2'b00: out = 8'b11111110;
                2'b01: out = 8'b11111101;
                2'b10: out = 8'b11111011;
                default: out = 8'b11111000;
            endcase
        end
endmodule
