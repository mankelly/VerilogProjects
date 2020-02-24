`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2019 03:30:55 PM
// Design Name: 
// Module Name: _400Clk
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


module _400Clk(clk, resetSW, outsignal);
    input clk;
    input resetSW;
    output  outsignal;
reg [26:0] counter;  
reg outsignal;
    always @ (posedge clk)
    begin
	if (resetSW)
	  begin
		counter=0;
		outsignal=0;
	  end
	else
  begin
	  counter = counter +1;
	  if (counter == 62_500) //actually 800Hz
		begin
			outsignal=~outsignal;
			counter =0;
		end
 end
   end
endmodule
