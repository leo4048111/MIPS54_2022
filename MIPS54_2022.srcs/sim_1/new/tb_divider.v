`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2022 02:33:20 PM
// Design Name: 
// Module Name: tb_divider
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


module tb_divider;
reg IS_UNSIGNED = 1;
reg [31:0] dividend = 32'hFFFFFFFB;
reg [31:0] divisor = 32'h2;
wire [31:0] quotient;
wire [31:0] remainder;

Divider uut(IS_UNSIGNED, dividend, divisor, quotient, remainder);
endmodule
