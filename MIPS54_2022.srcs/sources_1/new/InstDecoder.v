`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2022 05:08:36 PM
// Design Name: 
// Module Name: InstDecoder
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


module InstDecoder(
    input [31:0] IM_Inst,
    output [53:0] inst_type
    );

//指令译码器部分
wire [5:0]OP,func;
assign OP = IM_Inst[31:26];//RIJ指令类型
assign func = IM_Inst[5:0];//R指令类型

//R型指令译码
wire ADD, ADDU, SUB, SUBU, AND, OR, XOR, NOR, SLT, SLTU, SLL, SRL, SRA, SLLV, SRLV, SRAV, JR;
assign ADD = (OP == 0 && func == 6'b100000);
assign inst_type[0] = ADD;
assign ADDU = (OP == 0 && func == 6'b100001);
assign inst_type[1] = ADDU;
assign SUB = (OP == 0 && func == 6'b100010);
assign inst_type[2] = SUB;
assign SUBU = (OP == 0 && func == 6'b100011);
assign inst_type[3] = SUBU;
assign AND = (OP == 0 && func == 6'b100100);
assign inst_type[4] = AND;
assign OR = (OP == 0 && func == 6'b100101);
assign inst_type[5] = OR;
assign XOR = (OP == 0 && func == 6'b100110);
assign inst_type[6] = XOR;
assign NOR = (OP == 0 && func == 6'b100111);
assign inst_type[7] = NOR;
assign SLT = (OP == 0 && func == 6'b101010);
assign inst_type[8] = SLT;
assign SLTU = (OP == 0 && func == 6'b101011);
assign inst_type[9] = SLTU;
assign SLL = (OP == 0 && func == 6'b000000);
assign inst_type[10] = SLL;
assign SRL = (OP == 0 && func == 6'b000010);
assign inst_type[11] = SRL;
assign SRA = (OP == 0 && func == 6'b000011);
assign inst_type[12] = SRA;
assign SLLV = (OP == 0 && func == 6'b000100);
assign inst_type[13] = SLLV;
assign SRLV = (OP == 0 && func == 6'b000110);
assign inst_type[14] = SRLV;
assign SRAV = (OP == 0 && func == 6'b000111);
assign inst_type[15] = SRAV;
assign JR = (OP == 0 && func == 6'b001000);
assign inst_type[16] = JR;

//I型指令译码
wire ADDI, ADDIU, ANDI, ORI, XORI, LW, SW, BEQ, BNE, SLTI, SLTIU, LUI;
assign ADDI = (OP == 6'b001000);
assign inst_type[17] = ADDI;
assign ADDIU = (OP == 6'b001001);
assign inst_type[18] = ADDIU;
assign ANDI = (OP == 6'b001100);
assign inst_type[19] = ANDI;
assign ORI = (OP == 6'b001101);
assign inst_type[20] = ORI;
assign XORI = (OP == 6'b001110);
assign inst_type[21] = XORI;
assign LUI = (OP == 6'b001111);
assign inst_type[22] = LUI;
assign LW = (OP == 6'b100011);
assign inst_type[23] = LW;
assign SW = (OP == 6'b101011);
assign inst_type[24] = SW;
assign BEQ = (OP == 6'b000100);
assign inst_type[25] = BEQ;
assign BNE = (OP == 6'b000101);
assign inst_type[26] = BNE;
assign SLTI = (OP == 6'b001010);
assign inst_type[27] = SLTI;
assign SLTIU = (OP == 6'b001011);
assign inst_type[28] = SLTIU;


//J型指令译码
wire J,JAL;
assign J = (OP == 6'b000010);
assign inst_type[29] = J;
assign JAL = (OP==6'b000011);
assign inst_type[30] = JAL;

//23条扩展指令
wire CLZ, DIVU, ERET, JALR, LB, LBU, LHU, SB, SH, LH, MFC0, MFHI, MFLO;
wire MTC0, MTHI, MTLO, MUL, MULTU, SYSCALL, TEQ, BGEZ, BREAK, DIV;
assign DIV = (OP == 0 && func == 6'b011010);
assign inst_type[31] = DIV;
assign DIVU = (OP == 0 && func == 6'b011011);
assign inst_type[32] = DIVU;
assign MUL = (OP == 6'b011100 && func == 6'b000010);
assign inst_type[33] = MUL;
assign MULTU = (OP == 0 && func == 6'b011001);
assign inst_type[34] = MULTU;
assign BGEZ = (OP == 6'b000001);
assign inst_type[35] = BGEZ;
assign JALR = (OP == 0 && func == 6'b001001);
assign inst_type[36] = JALR;
assign LBU = (OP == 6'b100100);
assign inst_type[37] = LBU;
assign LHU = (OP == 6'b100101);
assign inst_type[38] = LHU;
assign LB = (OP == 6'b100000);
assign inst_type[39] = LB;
assign LH = (OP == 6'b100001);
assign inst_type[40] = LH;
assign SB = (OP == 6'b101000);
assign inst_type[41] = SB;
assign SH = (OP == 6'b101001);
assign inst_type[42] = SH;
assign BREAK = (OP == 0 && func == 6'b001101);
assign inst_type[43] = BREAK;
assign SYSCALL = (OP == 0 && func == 6'b001100);
assign inst_type[44] = SYSCALL;
assign ERET = (OP == 6'b010000 && func == 6'b011000);
assign inst_type[45] = ERET;
assign MFHI = (OP == 0 && func == 6'b010000);
assign inst_type[46] = MFHI;
assign MFLO = (OP == 0 && func == 6'b010010);
assign inst_type[47] = MFLO;
assign MTHI = (OP == 0 && func == 6'b010001);
assign inst_type[48] = MTHI;
assign MTLO = (OP == 0 && func == 6'b010011);
assign inst_type[49] = MTLO;
assign MFC0 = (OP == 6'b010000 && func == 6'b000000 && IM_Inst[23] == 0);
assign inst_type[50] = MFC0;
assign MTC0 = (OP == 6'b010000 && func == 6'b000000 && IM_Inst[23] == 1);
assign inst_type[51] = MTC0;
assign CLZ = (OP == 6'b011100 && func == 6'b100000);
assign inst_type[52] = CLZ;
assign TEQ = (OP == 0 && func == 6'b110100);
assign inst_type[53] = TEQ;

endmodule
