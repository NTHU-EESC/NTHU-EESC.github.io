`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/13 09:00:01
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
    input sw_rst,
    input sw_dis,
    input sw_freq,
    input clk_10mhz,
    output [3:0]dis,
    output [7:0]seg
    );
    wire mode_display;
    wire clk_1hz;
    wire clk_100hz;
    wire [3:0]value[5:0];
    reg [3:0]value_dis_next[3:0];
    wire [3:0]value_dis[3:0];
    wire [3:0]bin;

    wire mode_debounced;
    wire mode_pulse;

    freq_div_1 clk1 (.clk(clk_10mhz),.rst_n(sw_rst),.clk_out(clk_1hz));
    freq_div_100 clk100 (.clk(clk_10mhz),.rst_n(sw_rst),.clk_out(clk_100hz));
    datecounter C0 (.rst_n(sw_rst),.clk(clk_1hz),.value0(value[0]),.value1(value[1]),.value2(value[2])
                     ,.value3(value[3]),.value4(value[4]),.value5(value[5]));
     always@*
         case (sw_dis) //mode_display 12hr is 0,24hr is 1
             1'b0:  begin
                 value_dis_next[3] <= value[3];
                 value_dis_next[2] <= value[2];
                 value_dis_next[1] <= value[1];
                 value_dis_next[0] <= value[0];
              end
              1'b1: begin
                 value_dis_next[3] <= 4'd2;
                 value_dis_next[2] <= 4'd0;
                 value_dis_next[1] <= value[5];
                 value_dis_next[0] <= value[4];
              end
              default:;
          endcase
      assign value_dis[0] = value_dis_next[0];
      assign value_dis[1] = value_dis_next[1];
      assign value_dis[2] = value_dis_next[2];
      assign value_dis[3] = value_dis_next[3];
      monitor_ctl C3 (.digit3(value_dis[3]),.digit2(value_dis[2]),.digit1(value_dis[1]),.digit0(value_dis[0])
                       ,.clk(clk_10mhz),.rst_n(sw_rst),.dis(dis),.bin_out(bin)); 
      display P5 (.bin(bin),.dot(1'd0),.segs(seg));

endmodule
