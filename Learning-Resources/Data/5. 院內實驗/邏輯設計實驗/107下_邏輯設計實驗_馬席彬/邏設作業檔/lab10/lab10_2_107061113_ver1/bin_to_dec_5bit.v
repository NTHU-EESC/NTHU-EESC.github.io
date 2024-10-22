`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/29 09:02:10
// Design Name: 
// Module Name: bin_to_dec_4bit
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


module bin_to_dec(
    input [15:0]bin,
    output reg [3:0]thousand,
    output reg [3:0]hundred,
    output reg [3:0]tenth,
    output reg [3:0]oneth
    );
always @* begin
    thousand = bin / 1000;
    hundred = (bin % 1000) / 100;
    tenth = (bin % 100) / 10;
    oneth = bin % 10;
end 
endmodule
