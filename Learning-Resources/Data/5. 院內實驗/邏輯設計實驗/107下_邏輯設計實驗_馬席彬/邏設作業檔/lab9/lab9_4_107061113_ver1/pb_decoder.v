`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/20 09:28:31
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
    output reg [7:0]key_in
);
always @*
    case (sig_keyboard)
        9'h1C : key_in = 8'd65;  // A
        9'h32 : key_in = 8'd66;
        9'h21 : key_in = 8'd67;
        9'h23 : key_in = 8'd68;
        9'h24 : key_in = 8'd69;
        9'h2B : key_in = 8'd70;
        9'h34 : key_in = 8'd71;
        9'h33 : key_in = 8'd72;  // H
        9'h43 : key_in = 8'd73;
        9'h3B : key_in = 8'd74;
        9'h42 : key_in = 8'd75;
        9'h4B : key_in = 8'd76;
        9'h3A : key_in = 8'd77;
        9'h31 : key_in = 8'd78;
        9'h44 : key_in = 8'd79;  //O
        9'h4D : key_in = 8'd80;
        9'h15 : key_in = 8'd81;
        9'h2D : key_in = 8'd82;
        9'h1B : key_in = 8'd83;
        9'h2C : key_in = 8'd84;
        9'h3C : key_in = 8'd85;  //U
        9'h2A : key_in = 8'd86;
        9'h1D : key_in = 8'd87;
        9'h22 : key_in = 8'd88;
        9'h35 : key_in = 8'd89;
        9'h1A : key_in = 8'd90;
        9'h58 : key_in = 8'd1;    // Caps
        9'h12 : key_in = 8'd2;    // Shift
        default : key_in = 8'd0;
    endcase
            
endmodule

