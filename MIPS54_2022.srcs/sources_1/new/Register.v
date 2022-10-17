`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/15/2022 10:58:35 AM
// Design Name: 
// Module Name: Register
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


module Register(
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
        data <= 32'b0;
    end
    else if (ena == 1) begin
        data <= data_in;
    end
    else begin
        data <= data;
    end
end

assign data_out = data;

endmodule
