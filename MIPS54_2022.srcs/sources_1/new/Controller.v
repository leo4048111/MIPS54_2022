`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2022 05:51:07 PM
// Design Name: 
// Module Name: Controller
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


module Controller(
    input clk,
    input ena,
    input rst,
    input [31:0] IM_Inst,  //从IMEM读出的指??
    input [31:0] DM_ReadData,  //从DMEM读出的数??
    input btn_break,
    output [31:0] PC,  //PC寄存器，储存下一条指令在IM中的地址
    //DMEM操作控制信号
    output DM_W, 
    output DM_R,
    output [31:0] DM_WriteData,
    output [10:0] DM_Addr,
    output SB,
    output SH
    );

//指令译码器部??
wire [53:0] inst_type;
InstDecoder decoder_inst(IM_Inst, inst_type);
//R型指令译??
wire ADD, ADDU, SUB, SUBU, AND, OR, XOR, NOR, SLT, SLTU, SLL, SRL, SRA, SLLV, SRLV, SRAV, JR;
assign ADD = inst_type[0];
assign ADDU = inst_type[1];
assign SUB = inst_type[2];
assign SUBU = inst_type[3];
assign AND = inst_type[4];
assign OR = inst_type[5];
assign XOR = inst_type[6];
assign NOR = inst_type[7];
assign SLT = inst_type[8];
assign SLTU = inst_type[9];
assign SLL = inst_type[10];
assign SRL = inst_type[11];
assign SRA = inst_type[12];
assign SLLV = inst_type[13];
assign SRLV = inst_type[14];
assign SRAV = inst_type[15];
assign JR = inst_type[16];

//I型指令译??
wire ADDI, ADDIU, ANDI, ORI, XORI, LW, SW, BEQ, BNE, SLTI, SLTIU, LUI;
assign ADDI = inst_type[17];
assign ADDIU = inst_type[18];
assign ANDI = inst_type[19];
assign ORI = inst_type[20];
assign XORI = inst_type[21];
assign LUI = inst_type[22];
assign LW = inst_type[23];
assign SW = inst_type[24];
assign BEQ = inst_type[25];
assign BNE = inst_type[26];
assign SLTI = inst_type[27];
assign SLTIU = inst_type[28];

//J型指令译??
wire J,JAL;
assign J = inst_type[29];
assign JAL = inst_type[30];

//23条扩展指??
wire CLZ, DIVU, ERET, JALR, LB, LBU, LHU, LH, MFC0, MFHI, MFLO;
wire MTC0, MTHI, MTLO, MUL, MULTU, SYSCALL, TEQ, BGEZ, BREAK, DIV;
assign DIV = inst_type[31];
assign DIVU = inst_type[32];
assign MUL = inst_type[33];
assign MULTU = inst_type[34];
assign BGEZ = inst_type[35];
assign JALR = inst_type[36];
assign LBU = inst_type[37];
assign LHU = inst_type[38];
assign LB = inst_type[39];
assign LH = inst_type[40];
assign SB = inst_type[41];
assign SH = inst_type[42];
assign BREAK = inst_type[43] | btn_break;
assign SYSCALL = inst_type[44];
assign ERET = inst_type[45];
assign MFHI = inst_type[46];
assign MFLO = inst_type[47];
assign MTHI = inst_type[48];
assign MTLO = inst_type[49];
assign MFC0 = inst_type[50];
assign MTC0 = inst_type[51];
assign CLZ = inst_type[52];
assign TEQ = inst_type[53];

//控制信号
wire IM_R = 1;//IM_R=1
wire M1 = ~(JR | J | JAL | JALR);//M1=~(jr+j+jal+jalr)
wire M2 = ~(LW | LBU | LHU | LB | LH);//M2=~(lw+lbu+lhu+lb+lh)
wire M3 = ~(SLL | SRL | SRA);//M3=~(sll+srl+sra)
wire [1:0] M4;
assign M4[0] = ADDI | ADDIU | SLTI | SLTIU | LW | SW | LBU | LHU | LB | LH | SB | SH;//M4_1=addiu+addi+slti+sltiu+lw+sw+lbu+lhu+lb+lh+sb+sh
assign M4[1] = ANDI | ORI | XORI | LUI;//M4_2=ori+xori+andi+lui
wire [1:0] M6;
assign M6[0] = ~(ADDI | ADDIU | ANDI | ORI | XORI | LUI | LW | SLTI | SLTIU | LBU | LHU | LB | LH | MFC0 | JAL | JALR);//M6_1=~(addi+addiu+andi+ori+xori+lw+slti+sltiu+lui+lbu+lhu+lb+lh+mfc0+jal+jalr)
assign M6[1]= JAL | JALR;//M6_2=jal + jalr
wire M7 = JAL | JALR;//M7=jal+jalr
wire M8 = JR | JALR;//M8=jr+jalr
wire RF_W = ~(JR | SW | BEQ | BNE | J | DIV | DIVU | MULTU | BGEZ | SB | SH | BREAK | SYSCALL | ERET | MTHI | MTLO | MTC0 | TEQ | (ADD && OF) | (SUB && OF));//RF_W=~(jr+sw+beq+bne+bgez+j+mtc0+mthi+mtlo+multu+div+divu+syscall+eret+break+teq+sh+sb)
//wire RF_CLK = clk;
wire [4:0] ALUC;   
assign ALUC[0] = SUB | SUBU | OR | NOR | SLT | SRL | SRLV | ORI | BEQ | BNE | SLTI | BGEZ | TEQ;//ALUC0=sub+subu+or+nor+slt+srl+srlv+ori+beq+bne+slti+bgez+teq
assign ALUC[1] = ADD | SUB | XOR | NOR | SLT | SLTU | SLL | SLLV | ADDI | XORI | SLTI | SLTIU;//ALUC1=add+sub+xor+nor+slt+sltu+sll+sllv+addi+slti+sltiu+xori
assign ALUC[2] = AND | OR | XOR | NOR | SLL | SRL | SRA | SLLV | SRLV | SRAV | ANDI | ORI | XORI;//ALUC2=and+or+xor+nor+sll+srl+sra+sllv+srlv+srav+andi+ori+xori
assign ALUC[3] = SLT | SLTU | SLL | SRL | SRA | SLLV | SRLV | SRAV | LUI | SLTI | SLTIU;//ALUC3=slt+sltu+sll+srl+sra+sllv+srlv+srav+slti+sltiu+lui
assign ALUC[4] = MUL; //ALUC4=MUL

assign DM_W = SW | SB | SH;//DM_w=sw+sb+sh
assign DM_R = LW | LBU | LHU | LB | LH;//DM_r=lw+lbu+lhu+lb+lh
wire DM_Ena = LW | SW | LBU | LHU | LB | LH | SB | SH;//DM_cs=lw+lbu+lhu+lb+lh+sw+sb+sh
wire [4:0] Rsc = IM_Inst[25:21];
wire [4:0] Rtc = IM_Inst[20:16];
wire [4:0] Rdc = (ADDI | ADDIU | ANDI | ORI | XORI | LUI | SLTI | SLTIU )? IM_Inst[20:16] : IM_Inst[15:11];
wire M5 = (BEQ & (~BNE) & (~BGEZ) & ZF) | ((~BEQ) & BNE & (~BGEZ) & (~ZF)) | ((~BEQ) & (~BNE) & BGEZ & ((~SF) | ZF));
wire cin1 = ~(SYSCALL | BREAK);//cin1=~(syscall+break)
wire cin2 = ~(SYSCALL | TEQ);//cin2=~(syscall+teq)
wire [1:0] HL_W;
assign HL_W[1] = MTHI | DIV | DIVU | MULTU;//HL_W[1]=mthi+multu+divu+div
assign HL_W[0] = MTLO | DIV | DIVU | MULTU;//HL_W[0]=mtlo+multu+divu+div
wire HL_R = MFHI;//HL_R=mfhi
wire S1 = LB;//S1=sb
wire S2 = LBU | LH;//S2=lbu+lh
wire S3 = LHU | LH;//S3=lhu+lh
wire [1:0] M9;
assign M9[1] = ~(MUL | MULTU | MTHI);//M9_1=~(multu+mul+mthi)
assign M9[0] = ~(DIV | DIVU | MUL | MULTU);//M9_0=~(multu+mul+divu+div)
wire [1:0] M12;
assign M12[1] = ~(MULTU | MTLO);//M12_1=~(multu+mtlo)
assign M12[0] = ~(DIV | DIVU | MULTU);//M12_0=~(multu+divu+div)
wire [1:0] M13;
assign M13[1] = BREAK | SYSCALL | TEQ;//M13_1=syscall+break+teq
assign M13[0] = ERET;//M13_0=eret
wire [1:0] M11;
assign M11[1] = ~(CLZ | MFHI | MFLO);//M11_1=~(clz+mfhi+mflo)
assign M11[0] = ~(CLZ | MFC0);//M11_0=~(clz+mfc0)
wire M10 = BGEZ;//M10=bgez

//通过控制信号控制，进行数据???路模块连接
wire [31:0] PC_out;
wire [31:0] Rt_out;
wire [31:0] Rs_out;
wire [31:0] MUX1_out;
wire [31:0] MUX2_out;
wire [31:0] MUX3_out;
wire [31:0] MUX4_out;
wire [31:0] MUX5_out;
wire [4:0] MUX6_out;
wire [31:0] MUX7_out;
wire [31:0] MUX8_out;
wire [31:0] MUX9_out;
wire [31:0] MUX10_out;
wire [31:0] MUX11_out;
wire [31:0] MUX12_out;
wire [31:0] MUX13_out;
//扩展输出
wire [31:0] EXT5_out;
wire [31:0] SIGN_EXT16_out;
wire [31:0] EXT16_out;
wire [31:0] EXT18_out;
//加法器输??
wire [31:0] ADDER_out;
//乘法器输??
wire [31:0] high_out;
wire [31:0] low_out;
//除法器输??
wire [31:0] quotient;
wire [31:0] remainder;
//LB, LH, LBU, LHU扩展器输??
wire [31:0] DataExtender_out;
//Hi, Lo寄存器输??
wire [31:0] HL_out;
//ALUC标志位与控制信号
wire ZF, SF, CF, OF;
wire [31:0] ALU_out;
//CLZ前导0
wire [31:0] CLZ_out;
//中断原因输出和中断信??
wire [4:0] cause_out;
wire exception = ~(cause_out == 5'b0);
//CP0输出
wire [31:0] CP0_out;
wire [31:0] status_out;
wire [31:0] EPC_out;

//PC更新引脚
wire [31:0] NPC;
assign NPC = PC + 4;
//其它信号
wire [4:0] shamt;
wire [31:0] jump_addr;
assign shamt = IM_Inst[10:6];
assign jump_addr = {PC_out[31:28], IM_Inst[25:0], 2'b00};
assign PC = PC_out;
assign DM_WriteData = Rt_out;
assign DM_Addr = (ALU_out - 32'h10010000)/4;

PCREG pc_reg(.clk(clk), .rst(rst), .ena(ena), .data_in(MUX13_out), .data_out(PC_out));
ALU alu_inst(.ALU_A(MUX3_out), .ALU_B(MUX10_out), .ALUC(ALUC), .ALU_Result(ALU_out), .ZF(ZF), .CF(CF), .SF(SF), .OF(OF));
RegFile rf_inst(
    .RF_clk(clk), .RF_ena(ena), .RF_rst(rst), .RF_RAddr1(Rtc), .RF_RAddr2(Rsc), 
    .RF_WAddr(MUX6_out), .RF_WData(MUX11_out), .RF_W(RF_W), .RF_R(1'b1), .RF_RData1(Rt_out), .RF_RData2(Rs_out));
MUX12 mux1(.A1(MUX8_out), .A2(MUX5_out), .Y(M1), .out(MUX1_out));
MUX12 mux2(.A1(DM_ReadData), .A2(ALU_out), .Y(M2), .out(MUX2_out));
MUX12 mux3(.A1(EXT5_out), .A2(Rs_out), .Y(M3), .out(MUX3_out));
MUX24 mux4(.A1(Rt_out), .A2(SIGN_EXT16_out), .A3(EXT16_out), .A4(32'bz), .Y(M4), .out(MUX4_out));
MUX12 mux5(.A1(NPC), .A2(ADDER_out), .Y(M5), .out(MUX5_out));
MUX24 mux6(.A1(Rtc), .A2(Rdc), .A3(32'd31), .A4(32'bz), .Y(M6), .out(MUX6_out));
MUX12 mux7(.A1(MUX2_out), .A2(NPC), .Y(M7), .out(MUX7_out));
MUX12 mux8(.A1(jump_addr), .A2(Rs_out), .Y(M8), .out(MUX8_out));
MUX24 mux9(.A1(high_out), .A2(Rs_out), .A3(remainder), .A4(32'bz), .Y(M9), .out(MUX9_out));
MUX12 mux10(.A1(MUX4_out), .A2(32'b0), .Y(M10), .out(MUX10_out));
MUX24 mux11(.A1(CLZ_out), .A2(HL_out), .A3(CP0_out), .A4(DataExtender_out), .Y(M11), .out(MUX11_out));
MUX24 mux12(.A1(low_out), .A2(Rs_out), .A3(quotient), .A4(32'b0), .Y(M12), .out(MUX12_out));
MUX24 mux13(.A1(MUX1_out), .A2(EPC_out), .A3(32'h4), .A4(32'b0), .Y(M13), .out(MUX13_out));

EXT5 ext5_inst(.in(shamt), .out(EXT5_out));
EXT16 ext16_inst(.in(IM_Inst[15:0]), .out(EXT16_out));
SIGN_EXT16 sign_ext16_inst(.in(IM_Inst[15:0]), .out(SIGN_EXT16_out));
EXT18 ext18_inst(.in(IM_Inst[15:0]), .out(EXT18_out));
Adder adder_inst(.A(EXT18_out), .B(NPC), .out(ADDER_out), .OF(ADDER_OF));
CountZero clz_inst(.in(Rs_out), .out(CLZ_out));
Divider divider_inst(.IS_UNSIGNED(DIVU), .dividend(Rs_out), .divisor(Rt_out), .quotient(quotient), .remainder(remainder));
Multifier multifier(.IS_UNSIGNED(MULTU), .a(Rs_out), .b(Rt_out), .high(high_out), .low(low_out));
DataExtender de_inst(.data(MUX7_out), .Y1(LB), .Y2(LBU | LH), .Y3(LHU | LH), .out(DataExtender_out));
RegHiLo regHiLo_inst(.clk(clk), .rst(rst), .Hi_in(MUX9_out), .Lo_in(MUX12_out), .HL_W(HL_W), .HL_R(HL_R), .HL_out(HL_out));
CauseGenerator cg_inst(.cin1(cin1), .cin2(cin2), .cause(cause_out));
CP0 cp0_inst(.clk(clk), .rst(rst), .mfc0(MFC0), .mtc0(MTC0), .pc(PC), .Rd(Rdc), .wdata(Rt_out), .exception(exception), 
.eret(ERET), .cause(cause_out), .rdata(CP0_out), .status(status_out), .exc_addr(EPC_out));

endmodule
