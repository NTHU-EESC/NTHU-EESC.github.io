`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/27 14:21:47
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
    input clk_100mhz,
    input rst_n,
    output reg clk_25mdiv128hz,
    output reg clk_25mdiv4hz,
    output reg clk_25mhz
    );
    reg clk_cnt0;
    reg clk_cnt1;
    reg [3:0]clk_cnt2;
    reg [8:0]cnt_tmp;
    
    always @*  
        if ({clk_25mdiv128hz,clk_cnt2,clk_25mdiv4hz,clk_cnt1,clk_25mhz,clk_cnt0} >= 9'b111111111) 
            cnt_tmp = 9'b0;
        else cnt_tmp = {clk_25mdiv128hz,clk_cnt2,clk_25mdiv4hz,clk_cnt1,clk_25mhz,clk_cnt0} + 9'b1;
    
    always @(posedge clk_100mhz or negedge rst_n)
        if (~rst_n) 
            {clk_25mdiv128hz,clk_cnt2,clk_25mdiv4hz,clk_cnt1,clk_25mhz,clk_cnt0} <= 9'b111111111; 
        else {clk_25mdiv128hz,clk_cnt2,clk_25mdiv4hz,clk_cnt1,clk_25mhz,clk_cnt0} <= cnt_tmp;
        
endmodule
