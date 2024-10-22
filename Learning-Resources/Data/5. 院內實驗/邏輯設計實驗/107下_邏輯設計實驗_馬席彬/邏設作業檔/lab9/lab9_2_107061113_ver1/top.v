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
    wire [3:0]key_in;
    wire [4:0]sum;
    wire [3:0]sum_digit1;
    wire [3:0]sum_digit0;
    wire [3:0]oneth;
    wire [3:0]tenth;
    wire shift_valid_pulse;
    
    assign rst_p = ~rst_n;
    KeyboardDecoder U0 (.PS2_DATA(PS2_DATA),.PS2_CLK(PS2_CLK),.rst(rst_p),.clk(clk_100mhz)
                        ,.key_down(key_down),.last_change(last_change),.key_valid(key_valid));  
    numvalid_pulse (.clk(clk_100mhz),.rst_n(rst_n),.keys({key_down[69],key_down[22],key_down[30],key_down[38], 
                    key_down[37],key_down[46],key_down[54],key_down[61],key_down[62],key_down[70]}),.one_pulse(shift_valid_pulse));
    pb_decoder U1 (.sig_keyboard(last_change),.bin(key_in));
    sum_1digit U2 (.clk_100mhz(clk_100mhz),.rst_n(rst_n),.key_in(key_in),.shift_valid(shift_valid_pulse)
                   ,.sum(sum),.oneth(oneth),.tenth(tenth));
    bin_to_dec5bit U3 (.bin(sum),.digit1(sum_digit1),.digit0(sum_digit0));
    monitor_ctl U4 (.clk(clk_100mhz),.rst_n(rst_n),.dot(1'd0)
                    ,.digit3(oneth),.digit2(tenth),.digit1(sum_digit1),.digit0(sum_digit0)
                    ,.segs(segs),.dis(dis));
    
endmodule
