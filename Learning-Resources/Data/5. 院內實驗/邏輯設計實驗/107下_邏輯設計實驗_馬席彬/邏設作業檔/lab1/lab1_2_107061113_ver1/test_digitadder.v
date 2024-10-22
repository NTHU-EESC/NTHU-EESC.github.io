`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/19 20:46:46
// Design Name: 
// Module Name: test_digitadder
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


module test_digitadder();
reg [3:0]A,B;
reg CIN;
wire [3:0]S;
wire COUT;
digitadder U0 (.a(A),.b(B),.cin(CIN),.s(S),.cout(COUT));

initial
begin
    CIN = 1'b0;
    repeat(2) begin
        A = 4'b0;
        repeat(10)  begin
            B = 4'b0;
            repeat(10)  begin
                #5 B = B + 1'b1;
            end
        A = A + 1'b1;
        end
    CIN = CIN + 1'b1;
    end
end
    
endmodule
