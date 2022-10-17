`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2022 08:32:34 PM
// Design Name: 
// Module Name: EXT5
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


module EXT5(
    input [4:0] in,
    output [31:0] out
    );

assign out = {27'b0, in};//½«5Î»Êý¾Ý¸ßÎ»Ìî0À©Õ¹³É32Î»

endmodule
