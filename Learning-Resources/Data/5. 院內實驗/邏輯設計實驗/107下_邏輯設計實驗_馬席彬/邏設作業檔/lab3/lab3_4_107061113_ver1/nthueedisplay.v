`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/09 16:14:06
// Design Name: 
// Module Name: nthueedisplay
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


module nthueedisplay(
    input globalclk,
    input rst_n,
    output reg [3:0]dis,
    output [7:0]seg
    );
    reg [2:0]bin;
    reg [1:0]cnt;
    reg [2:0]s[5:0];
    wire clk_out;
    wire clk_ctl;
    integer i;
freq_div27 U0 (.clk(globalclk),.rst_n(rst_n),.clk_out(clk_out),.clk_ctl(clk_ctl));
display U1 (.bin(bin),.seg(seg));
    always @( posedge clk_ctl or negedge rst_n)  begin
        if (~rst_n) begin
            cnt <= 2'd0;
            dis <= 4'd0;
            bin <= 8'd0;
        end
        else  begin
        case (cnt)
            2'd0:  begin
                dis <= 4'b0111;
                bin <= s[0];
            end
            2'd1:  begin
                dis <= 4'b1011;
                bin <= s[1];
            end
            2'd2:  begin
                dis <= 4'b1101;
                bin <= s[2];
            end
            2'd3:  begin
                dis <= 4'b1110;
                bin <= s[3];
            end
        endcase
        cnt = cnt + 1'd1;
        end
    end
    always @( posedge clk_out or negedge rst_n)  begin
        if (~rst_n) begin
            for (i = 0; i<= 5; i = i + 1) begin
                s[i] <= i + 1;
            end
        end
        else begin
            s[0] <= s[5]; 
            for  (i = 0 ; i <= 4 ; i = i + 1) begin
                s[i + 1] <= s[i];
            end
        end
    end
endmodule
