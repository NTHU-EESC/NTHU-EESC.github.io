`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 19:10:21
// Design Name: 
// Module Name: digitadder
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


module digitadder(a, b, cin ,s ,cout);
input [3:0]a,b;
input cin;
output reg[3:0]s;
output cout;
reg [4:0]c;
integer i;

assign cout = c[4];
always @* begin
    c[0] = cin;
end
always @*  begin
    for (i = 0; i < 4; i = i + 1)
        {c[i + 1], s[i]} = a[i] + b[i] +c[i];
    if ({c[4], s[3:0]} >= 4'd10) begin
        {c[4], s[3:0]} = {c[4], s[3:0]} + 3'd6;
    end
end 
endmodule
