`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/07/2022 02:22:47 PM
// Design Name: 
// Module Name: RegHiLo
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


module RegHiLo(
    input clk,
    input rst,
    input [31:0] Hi_in,
    input [31:0] Lo_in,
    input [1:0] HL_W,
    input HL_R,
    output [31:0] HL_out
    );

wire [31:0] Hi_out;
wire [31:0] Lo_out;

Register reg_hi(.clk(clk), .rst(rst), .ena(HL_W[1]), .data_in(Hi_in), .data_out(Hi_out));
Register reg_lo(.clk(clk), .rst(rst), .ena(HL_W[0]), .data_in(Lo_in), .data_out(Lo_out));

assign HL_out = (HL_R) ? Hi_out : Lo_out;

endmodule
