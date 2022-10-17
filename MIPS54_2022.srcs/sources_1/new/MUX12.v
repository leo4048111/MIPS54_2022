`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2022 11:08:13 AM
// Design Name: 
// Module Name: MUX12
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


module MUX12(
    input [31:0] A1,
    input [31:0] A2,
    input Y,
    output [31:0] out
    );

reg [31:0] reg_out;

always @ *
begin
    case(Y)
    1'b0: reg_out <= A1;
    1'b1: reg_out <= A2;
    endcase
end

assign out = reg_out;
endmodule
