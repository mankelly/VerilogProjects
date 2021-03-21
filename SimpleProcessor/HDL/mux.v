`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2019 03:35:32 PM
// Design Name: 
// Module Name: mux
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


module mux(H, L, l1, l2, l3, S, f, C);
	input [6:0] H, L, l1, l2, l3;
	input [2:0] S;
	output reg [7:0] f;
	output reg [6:0] C;
	always @(H, L, S)
		case (S)
			0:
			begin 
			    f <= 8'b11111110;
			    C <= L;
			end
	   		1: 
	   		begin
	   		    f <= 8'b11111101;
	   		    C <= H;
	   		end
		 	2: 
		 	begin
		 	    f <= 8'b11111011;
		 	    C <= 7'b1111111;
		 	end
			3: 
			begin
			    f <= 8'b11110111;
			    C <= 7'b1111111;
			end
			4: //always off
			begin
			    f <= 8'b11101111;
			    C <= 7'b1111111;
			end
			5: 
			begin
			    f <= 8'b11011111;
			    C <= l3;
			end
			6: 
			begin
			    f <= 8'b10111111;
			    C <= l2;
			end
			7: 
			begin
			    f <= 8'b01111111;
			    C <= l1;
			end
		endcase
endmodule
