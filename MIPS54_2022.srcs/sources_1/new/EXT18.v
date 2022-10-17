`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2022 09:34:35 PM
// Design Name: 
// Module Name: EXT18
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


module EXT18(
    input [15:0] in,
    output [31:0] out
    );

wire [17:0] ext18_in = in << 2; 
assign out = {{14{ext18_in[15]}}, ext18_in};

endmodule
