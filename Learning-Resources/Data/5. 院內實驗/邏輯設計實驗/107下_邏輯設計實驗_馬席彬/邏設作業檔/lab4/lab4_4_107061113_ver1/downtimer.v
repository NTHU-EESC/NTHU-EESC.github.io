`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/15 09:21:52
// Design Name: 
// Module Name: downtimer
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


module downtimer(
    input globalclk,
    input rst_n,
    output reg [3:0]dis,
    output [7:0]seg
    );
    wire clk_ctl;
    wire clk_out;
    wire [3:0]digit[1:0];
    wire br;
    reg [3:0]bin;
    reg cnt;
    wire decrease_enable;
freq_div U0 (.clk(globalclk),.rst_n(rst_n),.clk_ctl(clk_ctl),.clk_out(clk_out));
downcounter D1 (.clk(clk_out),.rst_n(rst_n),.limit(4'd9),.decrease(decrease_enable),.inivalue(4'd0),.value(digit[0]),.borrow(br));
downcounter D2 (.clk(clk_out),.rst_n(rst_n),.limit(4'd2),.decrease(br),.inivalue(4'd3),.value(digit[1]));
display S0 (.bin(bin),.segs(seg));

assign decrease_enable = ~(rst_n && (digit[1] == 0) && (digit[0] == 0));
always @(posedge clk_ctl)  begin
    cnt <= ~cnt;
end
always @*
    if (cnt == 0) begin
        dis <= 4'b1101;
        bin <= digit[1];
    end
    else begin
        dis <= 4'b1110;
        bin <= digit[0];
    end 




endmodule
