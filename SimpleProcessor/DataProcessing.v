`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Manuel Kelly
// 
// Create Date: 11/26/2019 01:18:22 PM
// Design Name: 
// Module Name: DataProcessing
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


module DataProcessing(clk, resetSW, operation, regA, regB, ans, sw1);
input clk, resetSW;
input [3:0] operation, regA, regB;
input sw1;
output reg [4:0] ans;
reg [3:0] mem0, mem1, mem2, mem3;
reg [3:0] mem4, mem5, mem6, mem7;
integer i;

always@(negedge resetSW, posedge clk)
    if (resetSW)
    begin
        ans<=0;
        mem0<=0; mem1<=0; mem2<=0; mem3<=0;
        mem4<=0; mem5<=0; mem6<=0; mem7<=0;
    end
    else
    begin
        case(operation)
        4'b0000: //Load
                    begin
                        case(regB)
                            4'b0000:
                                begin
                                if(sw1)
                                    begin
                                        ans<=mem0;
                                    end
                                end
                            4'b0001:
                                begin
                                if(sw1)
                                    begin
                                        ans<=mem1;
                                    end
                                end
                            4'b0010:
                                begin
                                if(sw1)
                                    begin
                                        ans<=mem2;
                                    end
                                end
                            4'b0011:
                                begin
                                if(sw1)
                                    begin
                                        ans<=mem3;
                                    end
                                end
                            4'b0100:
                                begin
                                if(sw1)
                                    begin
                                        ans<=mem4;
                                    end    
                                end
                            4'b0101:
                                begin
                                if(sw1)
                                    begin
                                        ans<=mem5;
                                    end    
                                end
                            4'b0110:
                                begin
                                if(sw1)
                                    begin
                                        ans<=mem6;
                                    end    
                                end
                            4'b0111:
                                begin
                                if(sw1)
                                    begin
                                        ans<=mem7;
                                    end    
                                end
                          endcase
                    end
                4'b0001:
                    begin //Store
                        begin
                        case(regB)
                            4'b0000:
                                begin
                                if(sw1)
                                    begin
                                        mem0<=ans;
                                    end
                                end
                            4'b0001:
                                begin
                                if(sw1)
                                    begin
                                        mem1<=ans;
                                    end
                                end
                            4'b0010:
                                begin
                                if(sw1)
                                    begin
                                        mem2<=ans;
                                    end
                                end
                            4'b0011:
                                begin
                                if(sw1)
                                    begin
                                        mem3<=ans;
                                    end
                                end
                            4'b0100:
                                begin
                                if(sw1)
                                    begin
                                        mem4<=ans;
                                    end    
                                end
                            4'b0101:
                                begin
                                if(sw1)
                                    begin
                                        mem5<=ans;
                                    end    
                                end
                            4'b0110:
                                begin
                                if(sw1)
                                    begin
                                        mem6<=ans;
                                    end    
                                end
                            4'b0111:
                                begin
                                if(sw1)
                                    begin
                                        mem7<=ans;
                                    end    
                                end
                          endcase
                        end
                    end
        4'b0010:
        begin
            ans <= regA+regB; //addition
        end
        4'b0011:
        begin
            ans <= regA-regB; //subtraction
        end
        4'b0100:
        begin
            ans <= ~regB-'d16; //invert
        end
        4'b0101:
        begin
            ans <= regB<<1; //shift left
        end
        4'b0110:
        begin
            ans <= regB>>1; //shift right
        end
        4'b0111:
        begin
            for(i = 0; i < 4; i = i + 1) //And
                begin
                    if(regA[i]==1 && regB[i]==1)
                        begin
                            ans[i]<=1;
                        end
                    else
                        begin
                            ans[i]<=0;
                        end
                end
        end
        4'b1000:
        begin
            for(i = 0; i < 4; i = i + 1) //Or
                begin
                    if(regA[i]==1 || regB[i]==1)
                        begin
                            ans[i]<=1;
                        end
                    else
                        begin
                            ans[i]<=0;
                        end
                end
        end
        4'b1001:
        begin
            if(regA<regB) //Set on Less than
                begin
                    ans<=1;
                end
            else
                begin
                    ans<=0;
                end
        end
        endcase
    end
endmodule
