`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////
// Engineer: Manuel Kelly
// 
// Create Date: 10/01/2021 10:23:41 PM
// Design Name: Simple UART Rx Module
// Module Name: UART_Rx
// Target Devices: ALL
// Tool Versions: Vivado 2020.2
// Description: THIS IS A SIMPLE UART RX MODULE THAT CAN BE USED IN ANY UART SYSTEM
// 
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////


module UART_Rx
    #(parameter DATA_WIDTH = 8,
                SAMPLE_AMT = 16)
    (
    input  logic clk,
    input  logic resetn,
    input  logic baud,
    input  logic rx,
    output logic rx_done,
    output logic [DATA_WIDTH-1: 0] rx_data
    );
    
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
                            if(!rx)
                                state_reg <= start;
                            else
                                state_reg <= idle;
                            count_reg <= SAMPLE_AMT/2-1;
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
                                                count_reg <= SAMPLE_AMT/2-1;
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
                                            count_reg <= SAMPLE_AMT/2-1;
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
                            count_reg <= SAMPLE_AMT/2-1;
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
                rx_done  <= 0;
                data_reg <= 0;
                rx_data  <= 0;
            end
        
        else
            begin
            
                case(state_reg)
                    
                    data : 
                        begin
                            rx_done <= 0;
                            if(baud)
                                if(count_reg == 0)
                                    data_reg <= {rx, data_reg[DATA_WIDTH-1:0]}; // LSB FIRST
                                else
                                    data_reg <= data_reg;
                        end
                    
                    stop : 
                        begin
                            rx_done  <= 1;
                            data_reg <= data_reg;
                            // RX READ DATA REGISTER OUTPUT
                            rx_data  <= data_reg;
                        end
                    
                    default : 
                        begin
                            rx_done <= 0;   
                            data_reg <= data_reg;  
                        end
                    
                endcase
                
            end
        
    end
    
endmodule
