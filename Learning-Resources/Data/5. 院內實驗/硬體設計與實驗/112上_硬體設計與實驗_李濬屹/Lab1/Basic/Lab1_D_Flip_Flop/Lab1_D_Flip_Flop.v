`timescale 1ns/1ps

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