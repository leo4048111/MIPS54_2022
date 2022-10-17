`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/15/2022 10:24:12 AM
// Design Name: 
// Module Name: CP0
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


module CP0(
    input clk,
    input rst,
    input mfc0,             //CPU instruction is Mfc0
    input mtc0,             //CPU instruction is Mtc0
    input [31:0] pc,
    input [4:0] Rd,         //Specifies Cp0 register
    input [31:0] wdata,     //Data from GP register to replace CP0 register
    input exception,
    input eret,             //Instruction is ERET(Exception Return)
    input [4:0] cause,
    //input intr,
    output [31:0] rdata,    //Data from CP0 register for GP register
    output [31:0] status,
    //output reg timer_int,
    output [31:0] exc_addr  //Address for PC at the beginning of an exception
    );
wire status_ena, cause_ena, epc_ena;    //实现的三个寄存器的使能信�?
wire [31:0] status_in, cause_in, epc_in;  //寄存器输入数�?
wire [31:0] status_out, cause_out, epc_out;  //寄存器输出数�?

Register Reg_status(clk, rst, status_ena, status_in, status_out);  //12号寄存器
Register Reg_cause(clk, rst, cause_ena, cause_in, cause_out);  //13号寄存器
Register Reg_epc(clk, rst, epc_ena, epc_in, epc_out);  //14号寄存器

wire IE, IM_SYSCALL, IM_BREAK, IM_TEQ;   //中断屏蔽�?
assign IE = status[0];
assign IM_SYSCALL = IE & status[8];
assign IM_BREAK = IE & status[9];
assign IM_TEQ = IE & status[10];

wire SYSCALL, BREAK, TEQ;               //中断类型
assign SYSCALL = cause == 5'b01000;
assign BREAK = cause == 5'b01001;
assign TEQ = cause == 5'b01101;

wire is_status, is_cause, is_epc;       //访问的寄存器�?
assign is_status = Rd == 5'd12;
assign is_cause = Rd == 5'd13;
assign is_epc = Rd == 5'd14;

assign status_ena = (mtc0 & is_status) || eret || (exception & IE & ((IM_SYSCALL & SYSCALL) || (IM_BREAK & BREAK) || (IM_TEQ & TEQ)));
assign cause_ena = (mtc0 & is_cause) || (exception & IE & ((IM_SYSCALL & SYSCALL) || (IM_BREAK & BREAK) || (IM_TEQ & TEQ))) ;
assign epc_ena = (mtc0 & is_epc) || (exception & IE & ((IM_SYSCALL & SYSCALL) || (IM_BREAK & BREAK) || (IM_TEQ & TEQ)));

assign status_in = mtc0 ? wdata : (eret ? {5'b0, status_out[31:5]} : {status_out[26:0], 5'b0});
assign cause_in = mtc0 ? wdata : {25'b0, cause, 2'b0};
assign epc_in = mtc0 ? wdata : pc;

//outputs
assign rdata = mfc0 ? (is_status ? status_out : (is_cause ? cause_out : (is_epc ? epc_out : 32'bz))) : 32'bz;
assign status = status_out;
assign exc_addr = eret ? epc_out : (((IM_SYSCALL & SYSCALL) || (IM_BREAK & BREAK) || (IM_TEQ & TEQ)) ? 32'h00000004 : pc + 4);

endmodule
