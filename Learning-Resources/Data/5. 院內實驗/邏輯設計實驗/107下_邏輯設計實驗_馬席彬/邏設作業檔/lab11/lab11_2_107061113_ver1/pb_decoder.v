`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/08 09:38:19
// Design Name: 
// Module Name: pb_decoder
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


module pb_decoder(
    input [8:0]sig_keyboard,
    output reg [3:0]bin
    );
    always @*
        case (sig_keyboard)
            9'h70: bin = 4'd0;
            9'h69: bin = 4'd1;
            9'h72: bin = 4'd2;
            9'h7A: bin = 4'd3;
            9'h6B: bin = 4'd4;
            9'h73: bin = 4'd5;
            9'h74: bin = 4'd6;
            9'h6C: bin = 4'd7;
            9'h75: bin = 4'd8;
            9'h7D: bin = 4'd9;
            9'h79: bin = 4'd10;  // +
            9'h7B: bin = 4'd11;  // -
            9'h7C: bin = 4'd12;  // *
            9'h5A: bin = 4'd14;  // Enter
            default : bin = 4'd15;
        endcase
                
endmodule
