`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/09 15:18:41
// Design Name: 
// Module Name: ringcouner1hz
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


module ringcounter(
    input globalclk,
    input rst,
    output reg [7:0]s
    );
    reg s_tmp;
    wire clk;
    integer i;
    freq_div_1hz U0 (.clk(globalclk),.rst_n(rst),.clk_out(clk));
always @*
    s_tmp <= s[7];
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
