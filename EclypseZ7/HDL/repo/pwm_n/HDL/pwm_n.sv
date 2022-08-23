`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Manuel Kelly
// 
// Module Name: pwm_n
// Project Name: Eclypse Z7 Test 1
// Description: This is a n-bit PWM module. Is dynamic so you can use
//              as many cycles as needed.
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pwm_n
    #(parameter n = 16)
    (
    input  wire         clk_i,
    input  wire         resetn_i,
    input  wire [n-1:0] pw_i, // Pulse width in number of cycles
    output wire         pwm_o
    );
    
    reg [n-1:0] r_cntr;
    reg         r_pwm;
    
    ///////////////////////////////
    // Combinational Logic
    
    // Output Assignment
    assign pwm_o = r_pwm;
    
    ///////////////////////////////
    // Synchronous Logic
    
    // Counter Logic
    always_ff @ (posedge clk_i)
        r_cntr <= (!resetn_i) ? 0 : (r_cntr == 2**n-1) ? 0 : r_cntr+1;
    // PWM Logic
    always_ff @ (posedge clk_i)
        r_pwm  <= (!resetn_i) ? 0 : (r_cntr >= pw_i)    ? 0 : 1;
      
endmodule
