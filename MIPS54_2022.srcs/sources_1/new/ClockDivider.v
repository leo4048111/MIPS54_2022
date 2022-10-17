`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2022 05:38:09 PM
// Design Name: 
// Module Name: ClockDivider
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


module ClockDivider(
    input clk_in,
    input rst,
    output clk_out
    );
reg [10:0] counter = 0;
parameter count = 1000;
always @ (posedge clk_in or posedge rst)
begin
    if(rst) begin
        counter <= 0;
    end
    else begin
        if(counter >= count) begin
            counter <= 0;
        end
        else begin
            counter <= counter + 1;
        end
    end
end    
assign clk_out = (counter >= count / 2) ? 1 : 0;
endmodule
