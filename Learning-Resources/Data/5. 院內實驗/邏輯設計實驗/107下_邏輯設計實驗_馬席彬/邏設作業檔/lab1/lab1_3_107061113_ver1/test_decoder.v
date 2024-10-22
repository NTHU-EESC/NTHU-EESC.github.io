`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/22 21:47:13
// Design Name: 
// Module Name: test_decoder
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


module test_decoder;
reg [2:0]IN;
reg EN;
wire [7:0]D;

decoder U0 (.in(IN),.en(EN),.d(D));

initial
begin
    EN = 1'd0;
    IN[2:0] = 3'd0;
#10 IN[2:0] = 3'd1;
#10 IN[2:0] = 3'd2;
#10 IN[2:0] = 3'd3;
#10 IN[2:0] = 3'd4;
#10 IN[2:0] = 3'd5;
#10 IN[2:0] = 3'd6;
#10 IN[2:0] = 3'd7;
#10 EN = 1'd1;
    IN[2:0] = 3'd0;
#10 IN[2:0] = 3'd1;
#10 IN[2:0] = 3'd2;
#10 IN[2:0] = 3'd3;
#10 IN[2:0] = 3'd4;
#10 IN[2:0] = 3'd5;
#10 IN[2:0] = 3'd6;
#10 IN[2:0] = 3'd7;
end

endmodule
