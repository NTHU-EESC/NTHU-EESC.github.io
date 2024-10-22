`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/18 21:41:00
// Design Name: 
// Module Name: test_fulladder
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


module test_fulladder;
wire COUT,S;
reg X,Y,CIN;

fulladder U0(.x(X),.y(Y),.cin(CIN),.cout(COUT),.s(S));

initial
begin
    X = 0; Y = 0; CIN = 0;
    #10 X = 0; Y = 0; CIN = 1;
    #10 X = 0; Y = 1; CIN = 0; 
    #10 X = 0; Y = 1; CIN = 1; 
    #10 X = 1; Y = 0; CIN = 0; 
    #10 X = 1; Y = 0; CIN = 1; 
    #10 X = 1; Y = 1; CIN = 0; 
    #10 X = 1; Y = 1; CIN = 1; 
end

endmodule
