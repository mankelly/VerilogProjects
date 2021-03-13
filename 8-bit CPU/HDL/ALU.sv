`timescale 1ns / 1ps

module ALU
    #(parameter DATA_WIDTH = 8)
    (   input logic clk, reset,
        input logic[DATA_WIDTH-1: 0] A,
        input logic[DATA_WIDTH-1: 0] B,
        input logic[DATA_WIDTH-1: 0] instr,
        output logic[DATA_WIDTH-1: 0] Y
    );
    
    logic[3:0] opcode;
    logic op; //op has different use cases depending on case statement
    logic c_b; //carry/borrow
    
    always_ff@(posedge clk, posedge reset)
        if(reset)
            begin
                Y <= 0;
            end
        else
            begin
                case(opcode)
                    4'b0000: //add
                        Y <= A + B;   
                    4'b0001: //add w/ carry
                        Y <= A + B + c_b; // c_b is carry
                    4'b0010: //subtract
                        Y <= A - B;
                    4'b0011: //subtract w/ borrow
                        Y <= A - B - c_b; // c_b is borrow
                    4'b0100: //twos compliment
                        Y <= op ? ~(A-1) : ~(B-1); //if op == 1 A, else B
                    4'b0101: //increment
                        Y <= op ? A+1 : B+1; //if op == 1 A, else B
                    4'b0110: //decrement
                        Y <= op ? A-1 : B-1; //if op == 1 A, else B
                    4'b0111: //pass through
                        Y <= op ? A : B; //if op == 1 A, else B
                    4'b1000: //and
                        Y <= A & B;
                    4'b1001: //or
                        Y <= A | B;
                    4'b1010: //xor
                        Y <= A ^ B; 
                    4'b1011: //ones compliment
                        Y <= op ? ~A : ~B; // op = 1 is A, op = 0 is B
                    4'b1100: //arithmetic shift A (sign bit preserved) 
                        // op == true (shift left) else shift right
                        Y <= op ? A <<< 1 : A >>> 1; // <<< / >>> is arithmetic shift
                    4'b1101: //logical shift A
                        // op == true (shift left) else shift right
                        Y <= op ? A << 1 : A >> 1; // << / >> is logical shift
                    4'b1110: //rotate A
                        Y <= op ? {A[6:0], A[7]} : {A[0], A[7:1]}; // if op == 1 rotate left, else rotate right
                    4'b1111: //rotate through carry A
                        Y <= op ? {A[6:0], c_b} : {c_b, A[7:1]}; // if op == 1 rotate left, else rotate right
                    default:
                        Y <= 0;
            endcase
        end    
    assign opcode = instr[3:0];
    assign op = instr[4];
    assign c_b = instr[5];
endmodule
