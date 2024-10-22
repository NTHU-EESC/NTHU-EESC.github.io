  `timescale 1ns/1ps

module Crossbar_4x4_4bit(in1, in2, in3, in4, out1, out2, out3, out4, control);
    input [4-1:0] in1, in2, in3, in4;
    input [5-1:0] control;
    output [4-1:0] out1, out2, out3, out4;

    wire [3:0] CB0_CB1, CB0_CB2, CB2_CB1, CB3_CB2, CB2_CB4, CB3_CB4;

    Crossbar_2x2_4bit CB0(
        .in1(in1),
        .in2(in2),
        .control(control[0]),
        .out1(CB0_CB1),
        .out2(CB0_CB2)
    );
    Crossbar_2x2_4bit CB1(
        .in1(CB0_CB1),
        .in2(CB2_CB1),
        .control(control[1]),
        .out1(out1),
        .out2(out2)
    );
    Crossbar_2x2_4bit CB2(
        .in1(CB0_CB2),
        .in2(CB3_CB2),
        .control(control[2]),
        .out1(CB2_CB1),
        .out2(CB2_CB4)
    );
    Crossbar_2x2_4bit CB3(
        .in1(in3),
        .in2(in4),
        .control(control[3]),
        .out1(CB3_CB2),
        .out2(CB3_CB4)
    );
    Crossbar_2x2_4bit CB4(
        .in1(CB2_CB4),
        .in2(CB3_CB4),
        .control(control[4]),
        .out1(out3),
        .out2(out4)
    );

endmodule

module Crossbar_2x2_4bit(in1, in2, control, out1, out2);
    input [4-1:0] in1, in2;
    input control;
    output [4-1:0] out1, out2;

    wire not_control;
    wire [3:0] in1_out1, in1_out2, in2_out1, in2_out2;

    not(not_control, control);

    DMux_1to2_4bits DMux1(in1, control, in1_out1, in1_out2);
    DMux_1to2_4bits DMux2(in2, not_control, in2_out1, in2_out2);
    Mux_2to1_4bits Mux1(in1_out1, in2_out1, control, out1);
    Mux_2to1_4bits Mux2(in1_out2, in2_out2, not_control, out2);

endmodule

module Mux_2to1_4bits(in0, in1, sel, out);
    input [3:0] in0, in1;
    input sel;
    output [3:0] out;
    wire not_sel;
    wire [3:0] tmp1, tmp2;

    not(not_sel, sel);
    
    and(tmp1[3], in0[3], not_sel);
    and(tmp1[2], in0[2], not_sel);
    and(tmp1[1], in0[1], not_sel);
    and(tmp1[0], in0[0], not_sel);
    
    and(tmp2[3], in1[3], sel);
    and(tmp2[2], in1[2], sel);
    and(tmp2[1], in1[1], sel);
    and(tmp2[0], in1[0], sel);
    
    or(out[3], tmp1[3], tmp2[3]);
    or(out[2], tmp1[2], tmp2[2]);
    or(out[1], tmp1[1], tmp2[1]);
    or(out[0], tmp1[0], tmp2[0]);
endmodule

module DMux_1to2_4bits(in, sel, out0, out1);
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