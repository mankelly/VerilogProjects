`timescale 1ns / 1ps

module midterm_tb;
logic clk_tb, reset_tb, stop_tb;
logic [7:0] sw_tb;
logic [15:0] led_tb;
logic [6:0] seg_tb;
logic [7:0] an_tb;

top uut(.clk(clk_tb), .reset(reset_tb), .stop(stop_tb), .sw(sw_tb), .led(led_tb), .seg(seg_tb), .an(an_tb));
initial begin
    clk_tb = 1;
    reset_tb = 1;
    stop_tb = 0;
    sw_tb = 8'b01111111;
    #10 reset_tb = 0;
end
always #5 clk_tb = ~clk_tb;
endmodule
