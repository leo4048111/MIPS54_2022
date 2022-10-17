`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2022 09:38:15 AM
// Design Name: 
// Module Name: Divider
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


module Divider(
    input IS_UNSIGNED,
    input [31:0] dividend,
    input [31:0] divisor,
    output [31:0] quotient,
    output [31:0] remainder
    );

wire [31:0] abs_dividend = IS_UNSIGNED ? dividend : (dividend[31] ? -dividend : dividend);
wire [31:0] abs_divisor = IS_UNSIGNED ? divisor : (divisor[31] ? -divisor : divisor);
wire [31:0] tmp_quotient = (divisor == 0) ? 0 : abs_dividend / abs_divisor;
wire [31:0] tmp_remainder = (divisor == 0) ? 0 : abs_dividend % abs_divisor;

assign quotient = IS_UNSIGNED ? tmp_quotient : ((dividend[31] ^ divisor[31]) ? -tmp_quotient : tmp_quotient);
assign remainder = IS_UNSIGNED ? tmp_remainder : (dividend[31] ? -tmp_remainder : tmp_remainder);

endmodule
