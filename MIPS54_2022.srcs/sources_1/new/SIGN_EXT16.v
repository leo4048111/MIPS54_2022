`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2022 09:16:21 PM
// Design Name: 
// Module Name: SIGN_EXT16
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


module SIGN_EXT16(
    input [15:0] in,
    output [31:0] out
    );

assign out = {{16{in[15]}}, in};//½«16Î»Êý¾Ý¸ßÎ»Ìî·ûºÅÎ»À©Õ¹³É32Î»

endmodule
