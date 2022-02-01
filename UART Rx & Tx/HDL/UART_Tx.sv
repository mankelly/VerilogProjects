`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Manuel Kelly
// 
// Create Date: 09/29/2021 09:21:52 PM
// Design Name: Simple UART Tx Module
// Module Name: UART_Tx
// Target Devices: ALL
// Tool Versions: Vivado 2020.2
// Description: THIS IS A SIMPLE UART TX MODULE THAT CAN BE USED IN ANY UART SYSTEM
// 
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////


module UART_Tx
    #(parameter DATA_WIDTH = 8, 
                SAMPLE_AMT = 16) // WE ARE OVERSAMPLING AT 16x
    (
    input  logic clk,
    input  logic resetn,
    input  logic tx_en,
    input  logic baud,
    input  logic [DATA_WIDTH-1: 0] tx_data,
    output logic tx,
    output logic tx_done
    );
    
    // FSM LOGIC SIGNALS
    typedef enum {idle, start, data, stop} fsm_states;
    fsm_states state_reg;
    logic[DATA_WIDTH-1: 0] data_reg;
    integer count_reg;
    integer bit_count;
    
    // FSM LOGIC BLOCK
    always_ff@(posedge clk)
    begin
    
        if(!resetn)
            begin
                state_reg <= idle;
                count_reg <= SAMPLE_AMT-1;
                bit_count <= DATA_WIDTH-1;
            end
            
        else
            begin
                
                case(state_reg)
                    
                    idle : 
                        begin
                            if(tx_en)
                                state_reg <= start;
                            else
                                state_reg <= idle;
                            count_reg <= SAMPLE_AMT-1;
                            bit_count <= DATA_WIDTH-1;
                        end
                    
                    start : 
                        begin
                            if(baud)
                                begin
                                    if(count_reg == 0)
                                        begin
                                            state_reg <= data;
                                            count_reg <= SAMPLE_AMT-1;
                                        end
                                    else
                                        begin
                                            state_reg <= start;
                                            count_reg <= count_reg-1;
                                        end
                                    bit_count <= DATA_WIDTH-1;
                                end
                            else
                                begin
                                    state_reg <= state_reg;
                                    count_reg <= count_reg;
                                    bit_count <= bit_count;
                                end
                        end
                    
                    data :
                        begin
                            if(baud)
                                begin
                                    if(count_reg == 0)
                                        if(bit_count == 0)
                                            begin
                                                state_reg <= stop;
                                                count_reg <= SAMPLE_AMT-1;
                                                bit_count <= DATA_WIDTH-1;
                                            end
                                        else
                                            begin
                                                state_reg <= data;
                                                count_reg <= SAMPLE_AMT-1;
                                                bit_count <= bit_count-1;
                                            end
                                    else
                                        begin
                                            state_reg <= data;
                                            count_reg <= count_reg-1;
                                            bit_count <= bit_count;
                                        end
                                end
                                
                            else
                                begin
                                    state_reg <= state_reg;
                                    count_reg <= count_reg;
                                    bit_count <= bit_count;
                                end
                        end
                    
                    stop : 
                        begin
                            if(baud)
                                begin
                                    if(count_reg == 0)
                                        begin
                                            state_reg <= idle;
                                            count_reg <= SAMPLE_AMT-1;
                                        end
                                    else
                                        begin
                                            state_reg <= stop;
                                            count_reg <= count_reg-1;
                                        end
                                    bit_count <= DATA_WIDTH-1;
                                end
                            else
                                begin
                                    state_reg <= state_reg;
                                    count_reg <= count_reg;
                                    bit_count <= bit_count;
                                end
                        end
                    
                    default : 
                        begin
                            state_reg <= idle;
                            count_reg <= SAMPLE_AMT-1;
                            bit_count <= DATA_WIDTH-1;
                        end
                    
                endcase
                
            end
            
    end
    
    // FSM OUTPUT BLOCK
    always_ff@(posedge clk)
    begin
        
        if(!resetn)
            begin
                tx      <= 1;
                tx_done <= 0;
                data_reg <= 0;
            end
        
        else
            begin
            
                case(state_reg)
            
                    idle : 
                        begin
                            if(tx_en)
                                tx <= 0;
                            else
                                tx <= 1;
                            tx_done <= 0;   
                            data_reg <= tx_data;    
                        end
                    
                    start : 
                        begin
                            if(count_reg == 0)
                                begin
                                    data_reg <= data_reg;
                                end
                            else
                                begin                                    
                                    data_reg <= data_reg;
                                end
                            tx_done <= 0;
                            tx <= 0;
                        end
                    
                    data : 
                        begin
                            if(count_reg == 0)
                                begin
                                    if(baud)
                                        begin
                                            if(bit_count == 0)
                                                tx <= 1;
                                            else
                                                tx <= data_reg[0];
                                            data_reg <= {data_reg[0], data_reg[DATA_WIDTH-1: 1]}; // ROTATE AND SEND LSB FIRST
                                        end
                                    else
                                        begin
                                            tx <= tx;
                                            data_reg <= data_reg;
                                        end
                                end
                            else
                                begin
                                    tx <= data_reg[0];
                                    data_reg <= data_reg;
                                end
                            tx_done <= 0;
                        end
                    
                    stop : 
                        begin
                            tx <= 1;
                            if(count_reg == 0)
                                tx_done <= 1;
                            else
                                tx_done <= 0;
                            data_reg <= data_reg;
                        end
                    
                    default : 
                        begin
                            tx <= 1;
                            tx_done <= 0;
                            data_reg <= 0;
                        end
                    
                endcase
                
            end
        
    end
    
endmodule