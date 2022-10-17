`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2022 09:09:56 AM
// Design Name: 
// Module Name: IMEM_Exception
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


module IMEM_Exception(
    input [10:0] IM_Addr,
    output [31:0] IM_Inst
    );

dist_mem_gen_1 dmg_inst_1(
.a(IM_Addr),
.spo(IM_Inst)
);

endmodule
