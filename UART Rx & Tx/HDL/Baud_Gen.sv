`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Manuel Kelly
// 
// Create Date: 09/29/2021 09:21:34 PM
// Design Name: 
// Module Name: Baud_Gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Baud_Gen
    (
    input logic clk,
    input logic resetn,
    input logic[11:0] divisor,
    output logic baud_tick // WILL BE 16 TIMES THE BAUD RATE
    ); // I WILL USE A SAMPLING FREQ OF 16*BAUD
    
    logic[11:0] tick_count;
    logic[11:0] count_reg;
    
    // DECODER LOGIC
    always_comb
    begin
        
       case(divisor)
       
            12'h28B: //9600
                tick_count = 12'h28B; //100M/(16[SAMPLES/BIT]*9600)
            
            12'h036: //115200
                tick_count = 12'h036;
            
            default: //9600
                tick_count = 12'h28B;
            
        endcase; 
        
    end;
    
    // COUNTER LOGIC
    always_ff @(posedge clk) // WILL BE RUNNING SYSTEM AT 100MHz
    begin
        if(!resetn)
            begin
                count_reg <= 0;
                baud_tick <= 0;
            end
        else
            begin
                if(count_reg == tick_count-1)
                    begin
                        count_reg <= 0;
                        baud_tick <= 1;
                    end
                else
                    begin
                        count_reg <= count_reg+1;
                        baud_tick <= 0;
                    end
            end
    end;
    
endmodule
