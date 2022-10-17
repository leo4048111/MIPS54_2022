`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2022 04:25:59 PM
// Design Name: 
// Module Name: RegFile
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

module RegFile(
    input RF_clk,
    input RF_ena,
    input RF_rst,
    input [4:0] RF_RAddr1,  
    input [4:0] RF_RAddr2,
    input [4:0] RF_WAddr,
    input [31:0] RF_WData,
    input RF_W,
    input RF_R,
    output [31:0] RF_RData1,
    output [31:0] RF_RData2
    );

    reg [31:0] array_reg[31:0];  //寄存器堆，32个32位寄存器

    always @(posedge RF_clk or posedge RF_rst) begin
        if (RF_rst) begin
            array_reg[0] <= 32'b0;
            array_reg[1] <= 32'b0;
            array_reg[2] <= 32'b0;
            array_reg[3] <= 32'b0;
            array_reg[4] <= 32'b0;
            array_reg[5] <= 32'b0;
            array_reg[6] <= 32'b0;
            array_reg[7] <= 32'b0;
            array_reg[8] <= 32'b0;
            array_reg[9] <= 32'b0;
            array_reg[10] <= 32'b0;
            array_reg[11] <= 32'b0;
            array_reg[12] <= 32'b0;
            array_reg[13] <= 32'b0;
            array_reg[14] <= 32'b0;
            array_reg[15] <= 32'b0;
            array_reg[16] <= 32'b0;
            array_reg[17] <= 32'b0;
            array_reg[18] <= 32'b0;
            array_reg[19] <= 32'b0;
            array_reg[20] <= 32'b0;
            array_reg[21] <= 32'b0;
            array_reg[22] <= 32'b0;
            array_reg[23] <= 32'b0;
            array_reg[24] <= 32'b0;
            array_reg[25] <= 32'b0;
            array_reg[26] <= 32'b0;
            array_reg[27] <= 32'b0;
            array_reg[28] <= 32'b0;
            array_reg[29] <= 32'b0;
            array_reg[30] <= 32'b0;
            array_reg[31] <= 32'b0;
        end
        else if (RF_W == 1'b1 && RF_ena && RF_WAddr != 0) begin
            array_reg[RF_WAddr] <= RF_WData;
        end
    end
    
    assign RF_RData1 = (RF_ena && RF_R) ? array_reg[RF_RAddr1] : 32'bz;
    assign RF_RData2 = (RF_ena && RF_R) ? array_reg[RF_RAddr2] : 32'bz;
endmodule
