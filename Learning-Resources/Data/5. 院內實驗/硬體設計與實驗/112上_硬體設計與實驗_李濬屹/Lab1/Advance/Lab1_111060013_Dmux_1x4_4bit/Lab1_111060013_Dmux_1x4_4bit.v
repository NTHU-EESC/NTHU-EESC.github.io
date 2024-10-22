`timescale 1ns/1ps

module Dmux_1x4_4bit(in, a, b, c, d, sel);
    input [4-1:0] in;
    input [2-1:0] sel;
    output [4-1:0] a, b, c, d;
    wire [3:0] tmp_MSB0, tmp_MSB1;

    Dmux_1x2_4bit Dmux_MSB(in, tmp_MSB0, tmp_MSB1, sel[1]);
    Dmux_1x2_4bit Dmux_LSB0(tmp_MSB0, a, b, sel[0]);
    Dmux_1x2_4bit Dmux_LSB1(tmp_MSB1, c, d, sel[0]);

endmodule

module Dmux_1x2_4bit(in, out0, out1, sel);
    input [3:0] in;
    input sel;
    output [3:0] out0, out1;
    wire not_sel;

    not(not_sel, sel);

    and(out0[3], not_sel, in[3]);
    and(out0[2], not_sel, in[2]);
    and(out0[1], not_sel, in[1]);
    and(out0[0], not_sel, in[0]);

    and(out1[3], sel, in[3]);
    and(out1[2], sel, in[2]);
    and(out1[1], sel, in[1]);
    and(out1[0], sel, in[0]);

endmodule