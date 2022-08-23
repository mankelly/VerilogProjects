`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Manuel Kelly
// 
// Module Name: pwm_n_tb
// Project Name: Eclypse Z7 Test 1
// Description: This is a n-bit PWM module testbench. Is dynamic so you can use
//              as many cycles as needed.
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pwm_n_tb;
	
	localparam n  = 4; // n-bit Resolution PWM
	localparam pw = 25; // %
	reg          clk_i;
	reg          resetn_i;
	reg  [n-1:0] pw_i;
	wire         pwm_o;
	
	//assign pw_i = (pw*(2**n))/100;
	
	// Clock Gen
	always #5 clk_i=~clk_i;
	
	// Testbench
	initial begin
		clk_i    = 0;
		resetn_i = 0;
		pw_i     = 0;
		#50;
		resetn_i = 1;
		
		for(int i=0; i<=100; i+=1) begin
		  #500 pw_i = (i*(2**n))/100; // Let i = pw
		end
		
		$display("DONE.");
		$stop;
		
	end
	
	// PWM Instantiation
	pwm_n #(.n(n)) pwm_inst(.*);
	
endmodule
