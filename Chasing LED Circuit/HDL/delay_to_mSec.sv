`timescale 1ns / 1ps

module delay_to_mSec
    (
        input logic [7:0] sw,
        output logic [8:0] mSec 
    );
    
    logic [25:0] max = 5_000_000 + sw*176_470;
    logic [8:0] convert = max / 100_000;
    assign mSec = convert;
    
endmodule
