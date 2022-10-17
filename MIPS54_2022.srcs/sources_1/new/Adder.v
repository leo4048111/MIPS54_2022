`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2022 09:37:59 PM
// Design Name: 
// Module Name: Adder
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


module Adder(
    input [31:0] A,
    input [31:0] B,
    output [31:0] out,
    output OF
    );

wire [32:0] d_sign_result;
assign d_sign_result = {A[31], A} + {B[31], B};
assign out = A + B;
assign OF = ~(d_sign_result[32] == d_sign_result[31]);
endmodule
