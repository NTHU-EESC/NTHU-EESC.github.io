`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 18:11:51
// Design Name: 
// Module Name: hw3a_2
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
//////////////////////////////////////////////////////////////////////////////



module test_hw3a_2;

wire F;
reg  X, Y, Z;
hw3a_2b_2 U0(.f(F),.x(X),.y(Y),.z(Z));

initial
begin
X=0;Y=0;Z=0;
#10 X=0;Y=0;Z=1;
#10 X=0;Y=1;Z=0;
#10 X=0;Y=1;Z=1;
#10 X=1;Y=0;Z=0;
#10 X=1;Y=0;Z=1;
#10 X=1;Y=1;Z=0;
#10 X=1;Y=1;Z=1;

end
endmodule