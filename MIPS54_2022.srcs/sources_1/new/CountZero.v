`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2022 09:06:21 AM
// Design Name: 
// Module Name: CountZero
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


module CountZero(
    input [31:0] in,
    output [31:0] out
    );

reg [31:0] reg_out;
always @ *
begin
  casex(in)
    32'b1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx:reg_out <= 32'd0;
    32'b01xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx:reg_out <= 32'd1;
    32'b001xxxxxxxxxxxxxxxxxxxxxxxxxxxxx:reg_out <= 32'd2;
    32'b0001xxxxxxxxxxxxxxxxxxxxxxxxxxxx:reg_out <= 32'd3;
    32'b00001xxxxxxxxxxxxxxxxxxxxxxxxxxx:reg_out <= 32'd4;
    32'b000001xxxxxxxxxxxxxxxxxxxxxxxxxx:reg_out <= 32'd5;
    32'b0000001xxxxxxxxxxxxxxxxxxxxxxxxx:reg_out <= 32'd6;
    32'b00000001xxxxxxxxxxxxxxxxxxxxxxxx:reg_out <= 32'd7;
    32'b000000001xxxxxxxxxxxxxxxxxxxxxxx:reg_out <= 32'd8;
    32'b0000000001xxxxxxxxxxxxxxxxxxxxxx:reg_out <= 32'd9;
    32'b00000000001xxxxxxxxxxxxxxxxxxxxx:reg_out <= 32'd10;
    32'b000000000001xxxxxxxxxxxxxxxxxxxx:reg_out <= 32'd11;
    32'b0000000000001xxxxxxxxxxxxxxxxxxx:reg_out <= 32'd12;
    32'b00000000000001xxxxxxxxxxxxxxxxxx:reg_out <= 32'd13;
    32'b000000000000001xxxxxxxxxxxxxxxxx:reg_out <= 32'd14;
    32'b0000000000000001xxxxxxxxxxxxxxxx:reg_out <= 32'd15;
    32'b00000000000000001xxxxxxxxxxxxxxx:reg_out <= 32'd16;
    32'b000000000000000001xxxxxxxxxxxxxx:reg_out <= 32'd17;
    32'b0000000000000000001xxxxxxxxxxxxx:reg_out <= 32'd18;
    32'b00000000000000000001xxxxxxxxxxxx:reg_out <= 32'd19;
    32'b000000000000000000001xxxxxxxxxxx:reg_out <= 32'd20;
    32'b0000000000000000000001xxxxxxxxxx:reg_out <= 32'd21;
    32'b00000000000000000000001xxxxxxxxx:reg_out <= 32'd22;
    32'b000000000000000000000001xxxxxxxx:reg_out <= 32'd23;
    32'b0000000000000000000000001xxxxxxx:reg_out <= 32'd24;
    32'b00000000000000000000000001xxxxxx:reg_out <= 32'd25;
    32'b000000000000000000000000001xxxxx:reg_out <= 32'd26;
    32'b0000000000000000000000000001xxxx:reg_out <= 32'd27;
    32'b00000000000000000000000000001xxx:reg_out <= 32'd28;
    32'b000000000000000000000000000001xx:reg_out <= 32'd29;
    32'b0000000000000000000000000000001x:reg_out <= 32'd30;
    32'b00000000000000000000000000000001:reg_out <= 32'd31;
    32'b00000000000000000000000000000000:reg_out <= 32'd32;
  endcase
end

assign out = reg_out;
endmodule
