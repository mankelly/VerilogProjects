`timescale 1ns / 1ps

module data_path
    (
    input logic clk,
    input logic resetn,
    output logic[7:0] led // DATA_OUT
    );
    
    logic[15:0] IR, IR2, IR3, IR4, IR5, PC, PC_next; // PASS IR THROUGH PIPELINE
    logic[15:0] GPR[0:15];
    logic[15:0] reg_A;
    logic[5:0] ctrl_bus, ctrl_bus2, ctrl_bus3, ctrl_bus4; // Pass ctrl through the pipeline
    logic[1:0] alu_op, alu_op_next;
    logic[15:0] exec_reg;
    logic[15:0] reg_C, reg_C2, reg_C3;
    logic[3:0] alu_ctrl_reg;
    logic[15:0] mem_rd_data, mem_rd_next, wr_back_data;
    logic mem_wr_en;
    logic wr_back;
    logic[15:0] DATA_OUT_REG;
    
    initial begin
        for(integer i=0; i<16; i=i+1) begin
            GPR[i] = 0;
        end
    end
    
    // Instruction Fetch
    instr_mem instr_mem_unit(.addr(PC), .wr_en(0),
                             .wr_data(16'h0000), .rd_data(IR));
    
    // Decode
    ctrl ctrl_unit(.instr(IR2[15:12]), .reg_to_reg(ctrl_bus[5]), .reg_to_mem(ctrl_bus[4]), .mem_to_reg(ctrl_bus[3]),
                   .r(ctrl_bus[2]), .i(ctrl_bus[1]), .j(ctrl_bus[0]), .alu_op(alu_op_next));
    
    // Execute
    assign reg_A = ctrl_bus2[1] ? {8'h00, IR3[7:0]} : GPR[IR3[3:0]];
    alu_ctrl alu_ctrl_unit(.instr(IR3[15:12]), .ctrl(alu_ctrl_reg));
    alu alu_unit(.alu_op(alu_op), .ctrl(alu_ctrl_reg), .A(reg_A), .B(GPR[IR3[7:4]]), .C(reg_C));
    
    // Memory
    assign mem_wr_en = ctrl_bus3[4];
    data_mem data_mem_unit(.addr(IR4[11:4]), .wr_en(mem_wr_en), .wr_data(reg_C2), .rd_data(mem_rd_next), .DATA_OUT(DATA_OUT_REG));
    
    // Write Back
    assign wr_back = (ctrl_bus4[5] || ctrl_bus4[3]) ? 1 : 0;
    assign wr_back_data = ctrl_bus4[5] ? reg_C3 : ctrl_bus4[3] ? mem_rd_data : 0;
    always_comb
    begin
        if(wr_back)
            GPR[IR[11:8]] = wr_back_data;
    end
    assign PC_next = ctrl_bus4[0] ? {4'h0, IR5[11:0]} : PC + 1;
    
    // Next State Logic
    always_ff@(posedge clk)
    begin
        
        if (!resetn) begin
            PC <= 0;
            IR2 <= 0;
            IR3 <= 0;
            IR4 <= 0;
            IR5 <= 0;
            alu_op <= 0;
            ctrl_bus2 <= 0;
            ctrl_bus3 <= 0;
            ctrl_bus4 <= 0;
            reg_C2 <= 0;
            reg_C3 <= 0;
            mem_rd_data <= 0;
        
        end
        
        else begin
            PC <= PC_next;
            IR2 <= IR;
            IR3 <= IR2;
            IR4 <= IR3;
            IR5 <= IR4;
            alu_op <= alu_op_next;
            ctrl_bus2 <= ctrl_bus;
            ctrl_bus3 <= ctrl_bus2;
            ctrl_bus4 <= ctrl_bus3;
            reg_C2 <= reg_C;
            reg_C3 <= reg_C2;
            mem_rd_data <= mem_rd_next;
            
        end
        
    end;
    
    assign IR_OUT = IR;
    // MMIO
    assign led = DATA_OUT_REG[7:0];

endmodule
