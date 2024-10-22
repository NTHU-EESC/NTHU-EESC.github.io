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
            9'h45: bin = 4'd0;
            9'h16: bin = 4'd1;
            9'h1E: bin = 4'd2;
            9'h26: bin = 4'd3;
            9'h25: bin = 4'd4;
            9'h2E: bin = 4'd5;
            9'h36: bin = 4'd6;
            9'h3D: bin = 4'd7;
            9'h3E: bin = 4'd8;
            9'h46: bin = 4'd9;
            9'h1C: bin = 4'd10;  // A
            9'h1B: bin = 4'd11;  // S
            9'h3A: bin = 4'd12;  // M
            9'h5A: bin = 4'd15;  // Enter
            default : bin = 4'd15;
        endcase
                
endmodule
