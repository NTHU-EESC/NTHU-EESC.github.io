`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/08 14:21:18
// Design Name: 
// Module Name: ringcounter
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


module ringshifter(
    input load,
    input in,
    input clk,
    input rst,
    output reg [7:0]s
    );
    reg s_tmp;
    integer i;
always @*
    if (load) s_tmp <= in;
    else s_tmp <= s[7];
always @(posedge clk)  begin
    if (~rst) begin
        for (i = 0; i<= 6; i = i + 2) begin
            s[i] <= 0;
            s[i + 1] <= 1;
        end
    end
    else begin
        s[0] <= s_tmp; 
        for  (i = 0 ; i <= 6 ; i = i + 1) begin
            s[i + 1] <= s[i];
        end
    end
end
endmodule
