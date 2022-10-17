`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2022 07:06:05 PM
// Design Name: 
// Module Name: tb_controller
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


module tb_controller;
reg clk = 0;
reg ena = 1;
reg rst = 0;
reg [31:0] IM_Inst;  //从IMEM读出的指令
wire [31:0] PC;  //PC寄存器，储存下一条指令在IM中的地址
//DMEM操作控制信号
wire DM_W; 
wire DM_R;
reg [31:0] DM_ReadData;
wire [31:0] DM_WriteData;
wire [10:0] DM_Addr;

Controller uut(
    .clk(clk),
    .ena(ena),
    .rst(rst),
    .IM_Inst(IM_Inst),
    .PC(PC),
    .DM_W(DM_W),
    .DM_R(DM_R),
    .DM_ReadData(DM_ReadData),
    .DM_WriteData(DM_WriteData),
    .DM_Addr(DM_Addr)
    );

always #5 clk = ~clk;

integer file_output;

initial begin
    file_output = $fopen("D:/Projects/Vivado/MIPS54_2022/result.txt");
    #5 rst = 1;   //重置控制器
    #5 rst = 0;
    //-------------------------R型指令-------------------------------
    #10 IM_Inst = 32'b000000_00000_00001_00010_00000_100000;          //测试add指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "ADD:%b", tb_controller.uut.ADD);
    #10 IM_Inst = 32'b000000_00000_00001_00010_00000_100001;          //测试addu指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "ADDU:%b", tb_controller.uut.ADDU);
    #10 IM_Inst = 32'b000000_00000_00001_00010_00000_100010;          //测试sub指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SUB:%b", tb_controller.uut.SUB);
    #10 IM_Inst = 32'b000000_00000_00001_00010_00000_100011;          //测试subu指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SUBU:%b", tb_controller.uut.SUBU);
    #10 IM_Inst = 32'b000000_00000_00001_00010_00000_100100;          //测试and指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "AND:%b", tb_controller.uut.AND);
    #10 IM_Inst = 32'b000000_00000_00001_00010_00000_100101;          //测试or指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "OR:%b", tb_controller.uut.OR);
    #10 IM_Inst = 32'b000000_00000_00001_00010_00000_100110;          //测试xor指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "XOR:%b", tb_controller.uut.XOR);
    #10 IM_Inst = 32'b000000_00000_00001_00010_00000_100111;          //测试nor指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "NOR:%b", tb_controller.uut.NOR);
    #10 IM_Inst = 32'b000000_00000_00001_00010_00000_101010;          //测试slt指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SLT:%b", tb_controller.uut.SLT);
    #10 IM_Inst = 32'b000000_00000_00001_00010_00000_101011;          //测试sltu指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SLTU:%b", tb_controller.uut.SLTU);
    #10 IM_Inst = 32'b000000_00000_00001_00010_00100_000000;          //测试sll指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SLL:%b", tb_controller.uut.SLL);
    #10 IM_Inst = 32'b000000_00000_00001_00010_00011_000010;          //测试srl指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SRL:%b", tb_controller.uut.SRL);
    #10 IM_Inst = 32'b000000_00000_00001_00010_00110_000011;          //测试sra指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SRA:%b", tb_controller.uut.SRA);
    #10 IM_Inst = 32'b000000_00010_00001_00011_00000_000100;          //测试sllv指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SLLV:%b", tb_controller.uut.SLLV);
    #10 IM_Inst = 32'b000000_00010_00001_00011_00000_000110;          //测试srlv指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SRLV:%b", tb_controller.uut.SRLV);
    #10 IM_Inst = 32'b000000_00010_00001_00011_00000_000111;          //测试srav指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SRAV:%b", tb_controller.uut.SRAV);
    #10 IM_Inst = 32'b000000_00100_00000_00000_00000_001000;          //测试jr指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "JR:%b", tb_controller.uut.JR);
    //-------------------------I型指令-------------------------------
    #10 IM_Inst = 32'b001000_00101_00110_1111111111111111;          //测试ADDI指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "ADDI:%b", tb_controller.uut.ADDI);
    #10 IM_Inst = 32'b001001_00101_00110_1111111111111111;          //测试ADDIU指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "ADDIU:%b", tb_controller.uut.ADDIU);
    #10 IM_Inst = 32'b001100_00101_00110_1111111111111111;          //测试ANDI指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "ANDIU:%b", tb_controller.uut.ANDI);
    #10 IM_Inst = 32'b001101_00101_00110_1111111111111111;          //测试ORI指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "ORI:%b", tb_controller.uut.ORI);
    #10 IM_Inst = 32'b001110_00101_00110_1111111111111111;          //测试XORI指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "XORI:%b", tb_controller.uut.XORI);
    #10 IM_Inst = 32'h1020ffd6;          //测试BEQ指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "BEQ:%b", tb_controller.uut.BEQ);
    #10 IM_Inst = 32'b000101_00111_01000_1111111111111101;          //测试BNE指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "BNE:%b", tb_controller.uut.BNE);
    #10 IM_Inst = 32'b001010_00111_01000_1111111111111101;          //测试SLTI指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SLTI:%b", tb_controller.uut.SLTI);
    #10 IM_Inst = 32'b001011_00111_01000_1111111111111101;          //测试SLTIU指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SLTIU:%b", tb_controller.uut.SLTIU);
    #10 IM_Inst = 32'b001111_00000_01001_1011001110101001;          //测试lui指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "LUI:%b", tb_controller.uut.LUI);
    //-------------------------J型指令-------------------------------
    #10 IM_Inst = 32'b000010_11111111111111111111111111;          //测试j指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "J:%b", tb_controller.uut.J);
    #10 IM_Inst = 32'b000011_11111111111111111111111111;          //测试jal指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "JAL:%b", tb_controller.uut.JAL);
    //-------------------------LW SW--------------------------------
    #10 IM_Inst = 32'b100011_00000_00001_0000000000000000;          //测试LW指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "LW:%b", tb_controller.uut.LW);
    #10 IM_Inst = 32'b101011_00000_00001_0000000000000000;          //测试SW指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SW:%b", tb_controller.uut.SW);
    //------------------------23条扩展指令--------------------------
    #10 IM_Inst = 32'b011100_00001_00000_00010_00000_100000;          //测试CLZ指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "CLZ:%b", tb_controller.uut.CLZ);
    #10 IM_Inst = 32'b000000_00010_00001_00000_00000_011011;          //测试DIVU指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "DIVU:%b", tb_controller.uut.DIVU);
    #10 IM_Inst = 32'b010000_10000_00001_00000_00000_011000;          //测试ERET指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "ERET:%b", tb_controller.uut.ERET);
    #10 IM_Inst = 32'b000000_00010_00000_00000_00000_001001;          //测试JALR指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "JALR:%b", tb_controller.uut.JALR);
    #10 IM_Inst = 32'b100000_00011_00100_00000_00000_000000;          //测试LB指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "LB:%b", tb_controller.uut.LB);
    #10 IM_Inst = 32'b100100_00000_00000_00000_00000_001001;          //测试LBU指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "LBU:%b", tb_controller.uut.LBU);
    #10 IM_Inst = 32'b100101_00000_00000_00000_00000_001001;          //测试LHU指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "LHU:%b", tb_controller.uut.LHU);
    #10 IM_Inst = 32'b101000_00010_00001_00000_00000_001001;          //测试SB指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SB:%b", tb_controller.uut.SB);
    #10 IM_Inst = 32'b101001_00010_00001_00000_00000_001001;          //测试SH指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SH:%b", tb_controller.uut.SH);
    #10 IM_Inst = 32'b100001_00000_00000_00000_00000_001001;          //测试LH指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "LH:%b", tb_controller.uut.LH);
    #10 IM_Inst = 32'b010000_00000_00101_01100_00000_000000;          //测试MFC0指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "MFC0:%b", tb_controller.uut.MFC0);
    #10 IM_Inst = 32'b000000_00000_00000_00101_00000_010000;          //测试MFHI指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "MFHI:%b", tb_controller.uut.MFHI);
    #10 IM_Inst = 32'b000000_00000_00000_00101_00000_010010;          //测试MFLO指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "MFLO:%b", tb_controller.uut.MFLO);
    #10 IM_Inst = 32'b010000_00100_00001_01100_00000_000000;          //测试MTC0指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "MTC0:%b", tb_controller.uut.MTC0);
    #10 IM_Inst = 32'b000000_00001_00000_00000_00000_010001;          //测试MTHI指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "MTHI:%b", tb_controller.uut.MTHI);
    #10 IM_Inst = 32'b000000_00001_00000_00000_00000_010011;          //测试MTLO指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "MTLO:%b", tb_controller.uut.MTLO);
    #10 IM_Inst = 32'b011100_00001_00010_00100_00000_000010;          //测试MUL指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "MUL:%b", tb_controller.uut.MUL);
    #10 IM_Inst = 32'b000000_00001_00010_00000_00000_011001;          //测试MULTU指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "MULTU:%b", tb_controller.uut.MULTU);
    #10 IM_Inst = 32'b000000_00000_00000_00000_00000_001100;          //测试SYSCALL指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "SYSCALL:%b", tb_controller.uut.SYSCALL);
    #10 IM_Inst = 32'b000000_00011_00100_00000_00000_110100;          //测试TEQ指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "TEQ:%b", tb_controller.uut.TEQ);
    #10 IM_Inst = 32'b000001_00010_00001_00000_00000_111111;          //测试BGEZ指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "BGEZ:%b", tb_controller.uut.BGEZ);
    #10 IM_Inst = 32'b000000_00000_00001_00000_00000_001101;          //测试BREAK指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "BREAK:%b", tb_controller.uut.BREAK);
    #10 IM_Inst = 32'b000000_00001_00010_00000_00000_011010;          //测试DIV指令
    #5 rst = 1; #5 rst = 0;
    $fdisplay(file_output, "DIV:%b", tb_controller.uut.DIV);
end

endmodule
