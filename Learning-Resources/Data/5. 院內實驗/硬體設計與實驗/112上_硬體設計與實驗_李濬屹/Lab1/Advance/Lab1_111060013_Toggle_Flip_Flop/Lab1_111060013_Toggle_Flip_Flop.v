`timescale 1ns/1ps

module Toggle_Flip_Flop(clk, q, t, rst_n);
    input clk;
    input t;
    input rst_n;
    output q;
    wire xor_and, and_d;

    XOR TxorQ(
        .out(xor_and),
        .in0(q),
        .in1(t)
    );

    and(and_d, xor_and, rst_n);

    D_Flip_Flop DFF(
        .clk(clk),
        .d(and_d),
        .q(q)
    );

endmodule

module XOR(out, in0, in1);
    input in0, in1;
    output out;
    wire not_in0, not_in1, tmp0, tmp1;

    not(not_in0, in0);
    not(not_in1, in1);

    and(tmp0, in0, not_in1);
    and(tmp1, in1, not_in0);
    or(out, tmp0, tmp1);

endmodule

module D_Flip_Flop(clk, d, q);
    input clk;
    input d;
    output q;

    wire clk_not, q_tmp;

    not(clk_not, clk);

    D_Latch master(.e(clk_not), .d(d), .q(q_tmp));
    D_Latch slave(.e(clk), .d(q_tmp), .q(q));

endmodule

module D_Latch(e, d, q);
    input e;
    input d;
    output q;

    wire d_not, d_e, d_not_e, q_not;

    not(d_not, d);

    nand(d_e, d, e);
    nand(d_not_e, d_not, e);

    nand(q, d_e, q_not);
    nand(q_not, d_not_e, q);

endmodule