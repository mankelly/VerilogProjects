`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Manuel Kelly
// 
// Design Name: 32-Bit Floating Point Adder
// Module Name: fpadder_top
// Project Name: RISC-V ISA CPU [Eventually]
// Target Devices: All FPGAs
// Tool Versions: Vivado 2019.2
// Description: Basic FP Adder To Eventually Be Put In An ALU
// 
// Revision 0.10 - Completed And Assumed To Be Working
// Additional Comments: Thanks For Being Interested.
//                      OV Flag Has Not Been Tested And May Not Work.
// 
//////////////////////////////////////////////////////////////////////////////////


module fpadder_top
    (
    input  logic [31:0] a,
    input  logic [31:0] b,
    output logic [31:0] c,
    output logic ov // Overflow [OV] flag
    );
    
    // Register Instantiations
    logic       signC;
    logic[7:0]  expA;  // 8-bits 
    logic[7:0]  expB;  // 8-bits 
    logic[7:0]  expC;  // 8-bits 
    logic[22:0] mantA; // 23-bits
    logic[22:0] mantB; // 23-bits
    logic[22:0] mantC; // 23-bits
    logic[31:0] regC;  
    
    logic[7:0]  shiftCnt;
    logic[23:0] mantReg; // 22-bits + 1 OV
    logic[8:0]  expReg;  // 8-bits  + 1 OV
    
    
    // Register Assignment
    assign expA        = a[30:23]; // 8-bits
    assign expB        = b[30:23]; // 8-bits
    assign expC        = expReg[7:0];
    assign mantA       = a[22:0];  // 23-bits
    assign mantB       = b[22:0];  // 23-bits
    assign mantC       = (mantReg[23]) ? mantReg[22:0] : mantReg[22:0] << 1;
    assign shiftCnt    = (expA > expB) ? expA-expB : expB-expA;
    assign regC[22:0]  = mantC;
    assign regC[30:23] = expC;
    assign regC[31]    = signC;
    
    // Sign Logic
    always_comb 
    begin
        if (a[31] ^ b[31])
            if (expA > expB)
                signC = a[31];
            else if (expA == expB)
                if (mantA > mantB)
                    signC = a[31];
                else if (mantA == mantB)
                    signC = 0;
                else
                    signC = b[31];
            else
                signC = b[31];
        else
            signC = a[31];
    end
    
    // Exponent Logic
    logic mantMSB;
    assign mantMSB = ~mantReg[23];
    assign expReg = (a[31] ^ b[31]) ? ((expA > expB)  ? ({"0",expA} - mantMSB)  : 
                                       (expA == expB) ? (9'h000 - mantMSB)      : 
                                                        ({"0",expB} - mantMSB) ) :
                                      ((expA >= expB)  ? ({"0",expA} + mantMSB) : 
                                                         ({"0",expB} + mantMSB)) ;
    
    // Mantissa Logic
    logic[23:0] mregA;
    logic[23:0] mregB;
    logic[23:0] shiftA;
    logic[23:0] shiftB;
    assign mregA   = {"1", mantA};
    assign mregB   = {"1", mantB};
    assign shiftA = mregA >> shiftCnt;
    assign shiftB = mregB >> shiftCnt;
    always_comb
    begin
        if (a[31] ^ b[31])
        begin
            if (expA > expB) 
                mantReg = mregA - shiftB;
            else if (expA == expB)
                mantReg = (mregA - mregB) + 24'h800000; // Because MSB Will Cancel Each Other
            else
                mantReg = mregB - shiftA;
        end
        else
        begin
            if (expA > expB) 
                mantReg = mregA + shiftB;
            else if (expA == expB)
                mantReg = mregA + mregB + 24'h800000; // Because MSB Will Cancel Each Other
            else
                mantReg = shiftA + mregB;
        end
    end
    
    // Output Logic
    assign c  = regC;
    assign ov = expReg[8];
    
endmodule
