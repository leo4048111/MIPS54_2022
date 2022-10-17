`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2022 10:32:47 AM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] ALU_A,  //操作数A
    input [31:0] ALU_B,
    input [4:0] ALUC, //控制信号
    output [31:0] ALU_Result, //运算结果
    output ZF,  //结果是否为0
    output CF, //结果是否进位
    output SF, //结果是否为负数
    output OF //结果是否溢出
    );
 
reg [32:0] reg_result;
 
wire signed [31:0] signed_ALU_A;
wire signed [31:0] signed_ALU_B;
wire [63:0] mul_result;
wire IS_MUL = ALUC[4];
assign signed_ALU_A = ALU_A;
assign signed_ALU_B = ALU_B;
assign mul_result = signed_ALU_A * signed_ALU_B;

always @ * 
begin
  casez(ALUC)
    5'b00000: begin reg_result <= ALU_A + ALU_B; end//ADDU
    5'b00010: begin reg_result <= {ALU_A[31], ALU_A} + {ALU_B[31], ALU_B}; end//ADD
    5'b00001: begin reg_result <= ALU_A - ALU_B; end//SUBU
    5'b00011: begin reg_result <= {ALU_A[31], ALU_A} - {ALU_B[31], ALU_B}; end//SUB
    5'b00100: begin reg_result <= ALU_A & ALU_B; end//AND
    5'b00101: begin reg_result <= ALU_A | ALU_B; end//OR
    5'b00110: begin reg_result <= ALU_A ^ ALU_B; end//XOR
    5'b00111: begin reg_result <= ~(ALU_A | ALU_B); end//NOR
    5'b0100?: begin reg_result <= {ALU_B[15:0], 16'b0}; end//LUI
    5'b01011: begin reg_result <= (signed_ALU_A < signed_ALU_B)? 1 : 0; end//SLT
    5'b01010: begin reg_result <= (ALU_A < ALU_B)? 1 : 0; end//SLTU
    5'b01100: begin if (ALU_A==0) {reg_result[31:0], reg_result[32]} <= {ALU_B, 1'b0}; else {reg_result[31:0], reg_result[32]} <= signed_ALU_B >>> (signed_ALU_A - 1); end//SRA
    5'b0111?: begin reg_result <= ALU_B << ALU_A; end//SLL/SLR
    5'b01101: begin if (ALU_A==0) {reg_result[31:0], reg_result[32]} <= {ALU_B, 1'b0}; else {reg_result[31:0], reg_result[32]} <= ALU_B >> (ALU_A - 1); end//SRL
    default:;
  endcase
end

assign ALU_Result = IS_MUL ? mul_result[31:0] : reg_result[31:0];
assign CF = (ALUC == 5'b00000 | ALUC == 5'b00001 | ALUC == 5'b01010 | ALUC == 5'b01100 | ALUC == 5'b01101 | ALUC == 5'b01111 | ALUC == 5'b01110) ? reg_result[32] : 1'b0;
assign ZF = (reg_result == 32'b0) ? 1 : 0;
assign SF = reg_result[31];
assign OF = (ALUC == 5'b00010 | ALUC == 5'b00011) ? (reg_result[32] ^ reg_result[31]) : 1'b0;

endmodule

