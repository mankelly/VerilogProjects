`timescale 1ns / 1ps

module delay_digits
    (
        input logic [7:0] sw,
        output logic [3:0] d0, d1, d2
    );
    assign d0 = sw % 10;
    assign d1 = sw / 10 % 10;
    assign d2 = sw / 100; 
endmodule
