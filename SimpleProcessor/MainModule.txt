module SimpleProcessor(clock, op, A, B, select, AN, c, audioOut, aud_sd, LED, reset);

input clock, reset, select;
input [3:0] op, A, B;
output [7:0] AN;
output [6:0] c;
output audioOut;
output wire aud_sd;
output LED;
wire [4:0] return, return2;
wire [2:0] count1;
wire [3:0] decOut;
wire [3:0] high, low;
wire out;
wire muxOut;
wire [6:0] segHigh, segLow;
wire [6:0] L1, L2, L3; //letters

SecCount stage0(clock, reset, LED);
PlaySong stage9(clock, reset, LED, audioOut, aud_sd);
//MemoryAccess stage9(clock, reset, op, select, B, return2);
DataProcessing stage1(clock, reset, op, A, B, return, select);
converter stage5(clock, return, reset, high, low);
decToC stage6(clock, reset, low, segLow);
decToC stage7(clock, reset, high, segHigh);
_400Clk stage2(clock, reset, out);
Counter2 stage3(out, reset, count1);
toLetter stage8(clock, reset, op, L1, L2, L3);
mux stage4(segHigh, segLow, L1, L2, L3, count1, AN, c);
	endmodule
