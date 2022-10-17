`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2022 11:14:50 AM
// Design Name: 
// Module Name: MUX24
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


module MUX24(
	input [31:0] A1,
    input [31:0] A2,
    input [31:0] A3,
    input [31:0] A4,
    input [1:0] Y,
    output [31:0] out
    );

reg [31:0] reg_out;
always @ *
begin
	case(Y)
	2'b00: reg_out <= A1;
	2'b01: reg_out <= A2;
	2'b10: reg_out <= A3;
	2'b11: reg_out <= A4;
	endcase
end

assign out = reg_out;

endmodule
