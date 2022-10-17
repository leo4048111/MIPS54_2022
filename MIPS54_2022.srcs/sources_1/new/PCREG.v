`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2022 03:21:03 PM
// Design Name: 
// Module Name: PCREG
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


module PCREG(
    input clk,
    input rst,
    input ena,
    input [31:0] data_in,
    output [31:0] data_out
    );

reg [31:0] data;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // reset
        data <= 32'h00400000;
    end
    else if (ena == 1) begin
        data <= data_in;
    end
    else begin
        data <= data;
    end
end

assign data_out = (data > 32'h004000d8) ? 32'h004000d8 : data;

endmodule
