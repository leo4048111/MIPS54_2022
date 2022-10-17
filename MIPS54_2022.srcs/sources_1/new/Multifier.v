`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2022 05:16:01 PM
// Design Name: 
// Module Name: Multifier
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


module Multifier(
    input IS_UNSIGNED,
    input [31:0] a,
    input [31:0] b,
    output [31:0] high,
    output [31:0] low
);

wire [63:0] unsigned_a1={32'b00000000000000000000000000000000,a};
wire [63:0] signed_a1  =(a[31]==0)?{32'b00000000000000000000000000000000,a}:{32'b11111111111111111111111111111111,a};

wire [63:0] unsigned_z =((b[0]?unsigned_a1:64'b0)+((b[1]==1)?(unsigned_a1<<1):64'b0)+((b[2]==1)?(unsigned_a1<<2):64'b0)+((b[3]==1)?(unsigned_a1<<3):64'b0)+((b[4]==1)?(unsigned_a1<<4):64'b0)+((b[5]==1)?(unsigned_a1<<5):64'b0)+((b[6]==1)?(unsigned_a1<<6):64'b0)+((b[7]==1)?(unsigned_a1<<7):64'b0)+((b[8]==1)?(unsigned_a1<<8):64'b0)+((b[9]==1)?(unsigned_a1<<9):64'b0)+((b[10]==1)?(unsigned_a1<<10):64'b0)+((b[11]==1)?(unsigned_a1<<11):64'b0)+((b[12]==1)?(unsigned_a1<<12):64'b0)+((b[13]==1)?(unsigned_a1<<13):64'b0)+((b[14]==1)?(unsigned_a1<<14):64'b0)+((b[15]==1)?(unsigned_a1<<15):64'b0)+((b[16]==1)?(unsigned_a1<<16):64'b0)+((b[17]==1)?(unsigned_a1<<17):64'b0)+((b[18]==1)?(unsigned_a1<<18):64'b0)+((b[19]==1)?(unsigned_a1<<19):64'b0)+((b[20]==1)?(unsigned_a1<<20):64'b0)+((b[21]==1)?(unsigned_a1<<21):64'b0)+((b[22]==1)?(unsigned_a1<<22):64'b0)+((b[23]==1)?(unsigned_a1<<23):64'b0)+((b[24]==1)?(unsigned_a1<<24):64'b0)+((b[25]==1)?(unsigned_a1<<25):64'b0)+((b[26]==1)?(unsigned_a1<<26):64'b0)+((b[27]==1)?(unsigned_a1<<27):64'b0)+((b[28]==1)?(unsigned_a1<<28):64'b0)+((b[29]==1)?(unsigned_a1<<29):64'b0)+((b[30]==1)?(unsigned_a1<<30):64'b0)+((b[31]==1)?(unsigned_a1<<31):64'b0));
wire [64:0] signed_z = ((b[0]?signed_a1:65'b0)+((b[1]==1)?(signed_a1<<1):65'b0)+((b[2]==1)?(signed_a1<<2):65'b0)+((b[3]==1)?(signed_a1<<3):65'b0)+((b[4]==1)?(signed_a1<<4):65'b0)+((b[5]==1)?(signed_a1<<5):65'b0)+((b[6]==1)?(signed_a1<<6):65'b0)+((b[7]==1)?(signed_a1<<7):65'b0)+((b[8]==1)?(signed_a1<<8):65'b0)+((b[9]==1)?(signed_a1<<9):65'b0)+((b[10]==1)?(signed_a1<<10):65'b0)+((b[11]==1)?(signed_a1<<11):65'b0)+((b[12]==1)?(signed_a1<<12):65'b0)+((b[13]==1)?(signed_a1<<13):65'b0)+((b[14]==1)?(signed_a1<<14):65'b0)+((b[15]==1)?(signed_a1<<15):65'b0)+((b[16]==1)?(signed_a1<<16):65'b0)+((b[17]==1)?(signed_a1<<17):65'b0)+((b[18]==1)?(signed_a1<<18):65'b0)+((b[19]==1)?(signed_a1<<19):65'b0)+((b[20]==1)?(signed_a1<<20):65'b0)+((b[21]==1)?(signed_a1<<21):65'b0)+((b[22]==1)?(signed_a1<<22):65'b0)+((b[23]==1)?(signed_a1<<23):65'b0)+((b[24]==1)?(signed_a1<<24):65'b0)+((b[25]==1)?(signed_a1<<25):65'b0)+((b[26]==1)?(signed_a1<<26):65'b0)+((b[27]==1)?(signed_a1<<27):65'b0)+((b[28]==1)?(signed_a1<<28):65'b0)+((b[29]==1)?(signed_a1<<29):65'b0)+((b[30]==1)?(signed_a1<<30):65'b0)-((b[31]==1)?signed_a1<<31:65'b0));

assign {high, low} = IS_UNSIGNED ? unsigned_z : signed_z[63:0];

endmodule
