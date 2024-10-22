`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/06 16:29:08
// Design Name: 
// Module Name: top
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


module top(
	inout wire PS2_DATA,
    inout wire PS2_CLK,
    input wire rst_n,
    input wire clk_100mhz,
    output [7:0]segs,
    output [3:0]dis
    );
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    wire rst_p;
    wire [3:0]dis_bin;
    
    assign rst_p = ~rst_n;
    KeyboardDecoder U0 (.PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),.rst(rst_p),.clk(clk_100mhz)
                        ,.key_down(key_down),.last_change(last_change),.key_valid(key_valid));
    pb_decoder U1 (.sig_keyboard(last_change),.bin(dis_bin));
    monitor_ctl U2 (.clk(clk_100mhz),.rst_n(rst_n),.dot(1'd0)
                    ,.digit3(4'd15),.digit2(4'd15),.digit1(4'd15),.digit0(dis_bin)
                    ,.segs(segs),.dis(dis));
    
endmodule
