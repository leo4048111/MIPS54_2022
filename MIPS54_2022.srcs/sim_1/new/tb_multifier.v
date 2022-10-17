`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2022 06:16:43 PM
// Design Name: 
// Module Name: tb_multifier
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


module tb_multifier;
reg MU = 0;
reg [31:0] a = 32'hFFFFFFFB;
reg [31:0] b = 32'h10;
wire [31:0] high;
wire [31:0] low;
Multifier uut(MU, a, b, high, low);
endmodule
