`timescale 1s / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/20 21:56:07
// Design Name: 
// Module Name: comparesim
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


module comparesim;
    reg [2:0] A;
    reg [2:0] B;
    reg [2:0] C;
    wire OUT;
    compare U0(.out(OUT),.a(A),.b(B),.c(C));
    
    initial
    begin
    A = 3'd0;
    B = 3'd0;
    C = 3'd0; 
        repeat (8)
        begin
        repeat (8)
        begin
        repeat (8)
        begin
        #100
        C = C + 1;
        end
        B = B + 1;
        end
        A = A + 1;
        end
    end
endmodule
