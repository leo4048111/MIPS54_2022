`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/07/2022 01:47:41 PM
// Design Name: 
// Module Name: DataExtender
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


module DataExtender(
    input [31:0] data,
    input Y1, 
    input Y2, 
    input Y3,
    output [31:0] out
    );

reg [31:0] reg_data;
always @ *
begin
    case({Y1, Y2, Y3})
    3'b000: reg_data <= data;
    3'b001: reg_data <= {16'b0, data[15:0]};    //LHU
    3'b010: reg_data <= {24'b0, data[7:0]};     //LBU
    3'b011: reg_data <= {{16{data[15]}}, data[15:0]};     //LH
    3'b100: reg_data <= {{24{data[7]}}, data[7:0]};     //LB
    endcase
end

assign out = reg_data;

endmodule
