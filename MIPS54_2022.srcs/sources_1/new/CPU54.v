`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2022 10:14:40 PM
// Design Name: 
// Module Name: CPU54
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


module CPU54(
    input clk,
    input rst,
    input ena,
    input btn_break,
    output led
    );

wire [31:0] PC;
wire DM_W;
wire DM_R;
wire [31:0] DM_RData;
wire [31:0] DM_WData;
wire [10:0] DM_Addr;
wire [31:0] IM_Inst;
wire SB;
wire SH;

wire clk_out;
ClockDivider cd_inst(
    .clk_in(clk),
    .rst(rst),
    .clk_out(clk_out)
);

Controller controller(
    .clk(clk_out),
    .ena(ena),
    .rst(rst),
    .btn_break(btn_break),
    .IM_Inst(IM_Inst),
    .PC(PC),
    .DM_W(DM_W),
    .DM_R(DM_R),
    .DM_ReadData(DM_RData),
    .DM_WriteData(DM_WData),
    .DM_Addr(DM_Addr),
    .SB(SB),
    .SH(SH)
    );

DMEM dmem(
    .clk(clk),
    .ena(ena),
    .rst(rst),
    .DM_Addr(DM_Addr),
    .DM_WData(DM_WData),
    .DM_RData(DM_RData),
    .DM_W(DM_W),
    .DM_R(DM_R),
    .SB(SB),
    .SH(SH)
    );
    
//wire [10:0] IM_Addr = (PC > 32'h004000d4) ? (32'h004000d8 - 32'h00400000) >> 2 : (PC - 32'h00400000) >> 2;
wire [10:0] IM_Addr = (PC - 32'h00400000) >> 2;
wire [10:0] Exception_Addr = PC >> 2;
wire [31:0] Inst;
wire [31:0] Exp_Inst;
assign led = rst;
assign IM_Inst = (PC >= 32'h00400000) ? Inst : Exp_Inst;
IMEM imem(
    .IM_Addr(IM_Addr),
    .IM_Inst(Inst)
    );

IMEM_Exception imem_exp(
    .IM_Addr(Exception_Addr),
    .IM_Inst(Exp_Inst)
    );



endmodule
