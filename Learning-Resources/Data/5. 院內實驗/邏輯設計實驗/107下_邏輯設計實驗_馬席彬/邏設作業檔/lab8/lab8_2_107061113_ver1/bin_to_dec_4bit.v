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


module bin_to_dec_5bit(
    input [4:0]bin,
    output reg [3:0]digit1,
    output reg [3:0]digit0
    );
always @*
    if (bin <= 5'd9) begin
        digit1 = 4'd0;
        digit0 = bin;
    end
    else if (bin <= 5'd19) begin
        digit1 = 4'd1;
        digit0 = bin - 4'd10;
    end
    else if (bin <= 5'd29) begin
        digit1 = 4'd2;
        digit0 = bin - 5'd20;
    end
    else begin
        digit1 = 4'd3;
        digit0 = bin - 5'd30;
    end 
endmodule
