`timescale 1ns/1ps

module Center(rt, rs, sel, display, bits);
    input [3:0] rt, rs;
    input [2:0] sel;
    output [7:0] display;
    output [3:0] bits;
    wire [3:0] rd_display;

    Copy_4bits SelectBit(.out(bits), .in(4'b1110));
    Decode_And_Execute DAE(.rt(rt), .rs(rs), .sel(sel), .rd(rd_display));
    Segment7_Display Display(.in(rd_display), .out(display));

endmodule

module Segment7_Display(in, out);
    input [3:0] in;
    output [7:0] out;
    wire [7:0] tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8, tmp9, tmpa, tmpb, tmpc, tmpd, tmpe, tmpf;

    Mux_16to1 Mux7(
        .out(out[7]),
        .in0(tmp0[7]),
        .in1(tmp1[7]),
        .in2(tmp2[7]),
        .in3(tmp3[7]),
        .in4(tmp4[7]),
        .in5(tmp5[7]),
        .in6(tmp6[7]),
        .in7(tmp7[7]),
        .in8(tmp8[7]),
        .in9(tmp9[7]),
        .ina(tmpa[7]),
        .inb(tmpb[7]),
        .inc(tmpc[7]),
        .ind(tmpd[7]),
        .ine(tmpe[7]),
        .inf(tmpf[7]),
        .sel(in)
    );
    Mux_16to1 Mux6(
        .out(out[6]),
        .in0(tmp0[6]),
        .in1(tmp1[6]),
        .in2(tmp2[6]),
        .in3(tmp3[6]),
        .in4(tmp4[6]),
        .in5(tmp5[6]),
        .in6(tmp6[6]),
        .in7(tmp7[6]),
        .in8(tmp8[6]),
        .in9(tmp9[6]),
        .ina(tmpa[6]),
        .inb(tmpb[6]),
        .inc(tmpc[6]),
        .ind(tmpd[6]),
        .ine(tmpe[6]),
        .inf(tmpf[6]),
        .sel(in)
    );
    Mux_16to1 Mux5(
        .out(out[5]),
        .in0(tmp0[5]),
        .in1(tmp1[5]),
        .in2(tmp2[5]),
        .in3(tmp3[5]),
        .in4(tmp4[5]),
        .in5(tmp5[5]),
        .in6(tmp6[5]),
        .in7(tmp7[5]),
        .in8(tmp8[5]),
        .in9(tmp9[5]),
        .ina(tmpa[5]),
        .inb(tmpb[5]),
        .inc(tmpc[5]),
        .ind(tmpd[5]),
        .ine(tmpe[5]),
        .inf(tmpf[5]),
        .sel(in)
    );
    Mux_16to1 Mux4(
        .out(out[4]),
        .in0(tmp0[4]),
        .in1(tmp1[4]),
        .in2(tmp2[4]),
        .in3(tmp3[4]),
        .in4(tmp4[4]),
        .in5(tmp5[4]),
        .in6(tmp6[4]),
        .in7(tmp7[4]),
        .in8(tmp8[4]),
        .in9(tmp9[4]),
        .ina(tmpa[4]),
        .inb(tmpb[4]),
        .inc(tmpc[4]),
        .ind(tmpd[4]),
        .ine(tmpe[4]),
        .inf(tmpf[4]),
        .sel(in)
    );
    Mux_16to1 Mux3(
        .out(out[3]),
        .in0(tmp0[3]),
        .in1(tmp1[3]),
        .in2(tmp2[3]),
        .in3(tmp3[3]),
        .in4(tmp4[3]),
        .in5(tmp5[3]),
        .in6(tmp6[3]),
        .in7(tmp7[3]),
        .in8(tmp8[3]),
        .in9(tmp9[3]),
        .ina(tmpa[3]),
        .inb(tmpb[3]),
        .inc(tmpc[3]),
        .ind(tmpd[3]),
        .ine(tmpe[3]),
        .inf(tmpf[3]),
        .sel(in)
    );
    Mux_16to1 Mux2(
        .out(out[2]),
        .in0(tmp0[2]),
        .in1(tmp1[2]),
        .in2(tmp2[2]),
        .in3(tmp3[2]),
        .in4(tmp4[2]),
        .in5(tmp5[2]),
        .in6(tmp6[2]),
        .in7(tmp7[2]),
        .in8(tmp8[2]),
        .in9(tmp9[2]),
        .ina(tmpa[2]),
        .inb(tmpb[2]),
        .inc(tmpc[2]),
        .ind(tmpd[2]),
        .ine(tmpe[2]),
        .inf(tmpf[2]),
        .sel(in)
    );
    Mux_16to1 Mux1(
        .out(out[1]),
        .in0(tmp0[1]),
        .in1(tmp1[1]),
        .in2(tmp2[1]),
        .in3(tmp3[1]),
        .in4(tmp4[1]),
        .in5(tmp5[1]),
        .in6(tmp6[1]),
        .in7(tmp7[1]),
        .in8(tmp8[1]),
        .in9(tmp9[1]),
        .ina(tmpa[1]),
        .inb(tmpb[1]),
        .inc(tmpc[1]),
        .ind(tmpd[1]),
        .ine(tmpe[1]),
        .inf(tmpf[1]),
        .sel(in)
    );
    Mux_16to1 Mux0(
        .out(out[0]),
        .in0(tmp0[0]),
        .in1(tmp1[0]),
        .in2(tmp2[0]),
        .in3(tmp3[0]),
        .in4(tmp4[0]),
        .in5(tmp5[0]),
        .in6(tmp6[0]),
        .in7(tmp7[0]),
        .in8(tmp8[0]),
        .in9(tmp9[0]),
        .ina(tmpa[0]),
        .inb(tmpb[0]),
        .inc(tmpc[0]),
        .ind(tmpd[0]),
        .ine(tmpe[0]),
        .inf(tmpf[0]),
        .sel(in)
    );
    
    Copy_8bits C0(.out(tmp0), .in(8'b00000011));
    Copy_8bits C1(.out(tmp1), .in(8'b10011111));
    Copy_8bits C2(.out(tmp2), .in(8'b00100101));
    Copy_8bits C3(.out(tmp3), .in(8'b00001101));
    Copy_8bits C4(.out(tmp4), .in(8'b10011001));
    Copy_8bits C5(.out(tmp5), .in(8'b01001001));
    Copy_8bits C6(.out(tmp6), .in(8'b01000001));
    Copy_8bits C7(.out(tmp7), .in(8'b00011111));
    Copy_8bits C8(.out(tmp8), .in(8'b00000001));
    Copy_8bits C9(.out(tmp9), .in(8'b00001001));
    Copy_8bits CA(.out(tmpa), .in(8'b00010001));
    Copy_8bits CB(.out(tmpb), .in(8'b11000001));
    Copy_8bits CC(.out(tmpc), .in(8'b01100011));
    Copy_8bits CD(.out(tmpd), .in(8'b10000101));
    Copy_8bits CE(.out(tmpe), .in(8'b01100001));
    Copy_8bits CF(.out(tmpf), .in(8'b01110001));

endmodule

module Copy_8bits(out, in);
    input [7:0] in;
    output [7:0] out;

    Copy C7(.out(out[7]), .in(in[7]));
    Copy C6(.out(out[6]), .in(in[6]));
    Copy C5(.out(out[5]), .in(in[5]));
    Copy C4(.out(out[4]), .in(in[4]));
    Copy C3(.out(out[3]), .in(in[3]));
    Copy C2(.out(out[2]), .in(in[2]));
    Copy C1(.out(out[1]), .in(in[1]));
    Copy C0(.out(out[0]), .in(in[0]));

endmodule

module Copy_4bits(out, in);
    input [3:0] in;
    output [3:0] out;

    Copy C3(.out(out[3]), .in(in[3]));
    Copy C2(.out(out[2]), .in(in[2]));
    Copy C1(.out(out[1]), .in(in[1]));
    Copy C0(.out(out[0]), .in(in[0]));

endmodule

module Decode_And_Execute(rs, rt, sel, rd);
    input [4-1:0] rs, rt;
    input [3-1:0] sel;
    output [4-1:0] rd;
    wire [3:0] sub000, add001, or010, and011, rs100, ls101, clt110, ceq111;

    Sub SUB000(.out(sub000), .rs(rs), .rt(rt), .sign());
    Add ADD001(.out(add001), .rs(rs), .rt(rt), .cout());
    BitwiseOr OR010(.out(or010), .rs(rs), .rt(rt));
    BitwiseAnd AND011(.out(and011), .rs(rs), .rt(rt));
    RightShift RS100(.out(rs100), .rt(rt));
    LeftShift LS101(.out(ls101), .rs(rs));
    CompareLT CLT110(.out(clt110), .rs(rs), .rt(rt));
    CompareEQ CEQ111(.out(ceq111), .rs(rs), .rt(rt));

    Mux_8to1 Selector3(
        .out(rd[3]),
        .in0(sub000[3]),
        .in1(add001[3]),
        .in2(or010[3]),
        .in3(and011[3]),
        .in4(rs100[3]),
        .in5(ls101[3]),
        .in6(clt110[3]),
        .in7(ceq111[3]),
        .sel(sel)
    );

    Mux_8to1 Selector2(
        .out(rd[2]),
        .in0(sub000[2]),
        .in1(add001[2]),
        .in2(or010[2]),
        .in3(and011[2]),
        .in4(rs100[2]),
        .in5(ls101[2]),
        .in6(clt110[2]),
        .in7(ceq111[2]),
        .sel(sel)
    );

    Mux_8to1 Selector1(
        .out(rd[1]),
        .in0(sub000[1]),
        .in1(add001[1]),
        .in2(or010[1]),
        .in3(and011[1]),
        .in4(rs100[1]),
        .in5(ls101[1]),
        .in6(clt110[1]),
        .in7(ceq111[1]),
        .sel(sel)
    );

    Mux_8to1 Selector0(
        .out(rd[0]),
        .in0(sub000[0]),
        .in1(add001[0]),
        .in2(or010[0]),
        .in3(and011[0]),
        .in4(rs100[0]),
        .in5(ls101[0]),
        .in6(clt110[0]),
        .in7(ceq111[0]),
        .sel(sel)
    );

endmodule

module Add(out, rs, rt, cout);
    input [3:0] rs, rt;
    output [3:0] out;
    output cout;
    wire carry01, carry12, carry23;

    Half_Adder Add0(.a(rs[0]), .b(rt[0]), .cout(carry01), .sum(out[0]));
    Full_Adder Add1(.a(rs[1]), .b(rt[1]), .cin(carry01), .cout(carry12), .sum(out[1]));
    Full_Adder Add2(.a(rs[2]), .b(rt[2]), .cin(carry12), .cout(carry23), .sum(out[2]));
    Full_Adder Add3(.a(rs[3]), .b(rt[3]), .cin(carry23), .cout(cout), .sum(out[3]));

endmodule

module Sub(out, rs, rt, sign);
    input [3:0] rs, rt;
    output [3:0] out;
    output sign;
    wire [3:0] invt_rt, neg_rt;
    wire tmp_sign1, tmp_sign2;

    BitwiseInvt InvtB(.out(invt_rt), .in(rt));
    Add NegB(.out(neg_rt), .rs(invt_rt), .rt(4'b0001), .cout(tmp_sign1));

    Add ASubB(.out(out), .rs(rs), .rt(neg_rt), .cout(tmp_sign2));

    Xor Xor(.out(sign), .a(tmp_sign1), .b(tmp_sign2));

endmodule

module BitwiseInvt(out, in);
    input [3:0] in;
    output [3:0] out;

    Not Not3(.out(out[3]), .in(in[3]));
    Not Not2(.out(out[2]), .in(in[2]));
    Not Not1(.out(out[1]), .in(in[1]));
    Not Not0(.out(out[0]), .in(in[0]));

endmodule

module BitwiseOr(out, rs, rt);
    input [3:0] rs, rt;
    output [3:0] out;

    Or Or3(.out(out[3]), .a(rs[3]), .b(rt[3]));
    Or Or2(.out(out[2]), .a(rs[2]), .b(rt[2]));
    Or Or1(.out(out[1]), .a(rs[1]), .b(rt[1]));
    Or Or0(.out(out[0]), .a(rs[0]), .b(rt[0]));

endmodule

module BitwiseAnd(out, rs, rt);
    input [3:0] rs, rt;
    output [3:0] out;

    And And3(.out(out[3]), .a(rs[3]), .b(rt[3]));
    And And2(.out(out[2]), .a(rs[2]), .b(rt[2]));
    And And1(.out(out[1]), .a(rs[1]), .b(rt[1]));
    And And0(.out(out[0]), .a(rs[0]), .b(rt[0]));

endmodule

module RightShift(out, rt);
    input [3:0] rt;
    output [3:0] out;

    Copy Copy3(.out(out[3]), .in(rt[3]));
    Copy Copy2(.out(out[2]), .in(rt[3]));
    Copy Copy1(.out(out[1]), .in(rt[2]));
    Copy Copy0(.out(out[0]), .in(rt[1]));

endmodule

module LeftShift(out, rs);
    input [3:0] rs;
    output [3:0] out;

    Copy Copy3(.out(out[3]), .in(rs[2]));
    Copy Copy2(.out(out[2]), .in(rs[1]));
    Copy Copy1(.out(out[1]), .in(rs[0]));
    Copy Copy0(.out(out[0]), .in(rs[3]));

endmodule

module CompareLT(out, rs, rt);
    input [3:0] rs, rt;
    output [3:0] out;
    wire [3:0] result;

    Copy Copy3(.out(out[3]), .in(1'b1));
    Copy Copy2(.out(out[2]), .in(1'b0));
    Copy Copy1(.out(out[1]), .in(1'b1));
    CLT_4bits C4(.out(out[0]), .S(rs), .L(rt));


endmodule

module CLT_4bits(out, S, L);
    input [3:0] S, L;
    output out;
    wire XnorResult3, XnorResult2, XnorResult1;
    wire [3:0] FinalResult;
    wire tmp20, tmp10, tmp11, tmp00, tmp01, tmp02, or01, or23;

    Xnor Xnor3(.out(XnorResult3), .a(S[3]), .b(L[3]));
    Xnor Xnor2(.out(XnorResult2), .a(S[2]), .b(L[2]));
    Xnor Xnor1(.out(XnorResult1), .a(S[1]), .b(L[1]));

    CLT_1bit C3(.out(FinalResult[3]), .S(S[3]), .L(L[3]));

    CLT_1bit C2(.out(tmp20), .S(S[2]), .L(L[2]));
    And A2(.out(FinalResult[2]), .a(XnorResult3), .b(tmp20));

    CLT_1bit C1(.out(tmp10), .S(S[1]), .L(L[1]));
    And A11(.out(tmp11), .a(XnorResult3), .b(XnorResult2));
    And A1(.out(FinalResult[1]), .a(tmp10), .b(tmp11));

    CLT_1bit C0(.out(tmp00), .S(S[0]), .L(L[0]));
    And A01(.out(tmp01), .a(XnorResult3), .b(XnorResult2));
    And A02(.out(tmp02), .a(XnorResult1), .b(tmp00));
    And A0(.out(FinalResult[0]), .a(tmp01), .b(tmp02));

    Or O01(.out(or01), .a(FinalResult[0]), .b(FinalResult[1]));
    Or O23(.out(or23), .a(FinalResult[2]), .b(FinalResult[3]));
    Or OrOut(.out(out), .a(or01), .b(or23));

endmodule

module CLT_1bit(out, S, L);
    input S, L;
    output out;
    wire tmp;

    Xor Xor(.out(tmp), .a(S), .b(L));
    And And(.out(out), .a(tmp), .b(L));

endmodule

module CompareEQ(out, rs, rt);
    input [3:0] rs, rt;
    output [3:0] out;
    wire [3:0] tmp;
    wire tmp01, tmp23;

    Copy Copy3(.out(out[3]), .in(1'b1));
    Copy Copy2(.out(out[2]), .in(1'b1));
    Copy Copy1(.out(out[1]), .in(1'b1));

    Xnor Xnor3(.out(tmp[3]), .a(rs[3]), .b(rt[3]));
    Xnor Xnor2(.out(tmp[2]), .a(rs[2]), .b(rt[2]));
    Xnor Xnor1(.out(tmp[1]), .a(rs[1]), .b(rt[1]));
    Xnor Xnor0(.out(tmp[0]), .a(rs[0]), .b(rt[0]));

    And And01(.out(tmp01), .a(tmp[0]), .b(tmp[1]));
    And And23(.out(tmp23), .a(tmp[2]), .b(tmp[3]));
    And AndOut(.out(out[0]), .a(tmp01), .b(tmp23));

endmodule

module Half_Adder(a, b, cout, sum);
    input a, b;
    output cout, sum;

    Xor Xor(.out(sum), .a(a), .b(b));
    And And(.out(cout), .a(a), .b(b));

endmodule

module Full_Adder (a, b, cin, cout, sum);
    input a, b, cin;
    output cout, sum;
    wire a_xor_b;

    Majority FullCarryOut(.a(a), .b(b), .c(cin), .out(cout));
    Xor AXorB(.out(a_xor_b), .a(a), .b(b));
    Xor FullSum(.out(sum), .a(a_xor_b), .b(cin));

endmodule

module Majority(a, b, c, out);
    input a, b, c;
    output out;
    wire a_and_b, a_and_c, b_and_c, tmp_or;

    And AAndB(.out(a_and_b), .a(a), .b(b));
    And AAndC(.out(a_and_c), .a(a), .b(c));
    And BAndC(.out(b_and_c), .a(b), .b(c));
    Or TmpOr(.out(tmp_or), .a(a_and_b), .b(a_and_c));
    Or Out(.out(out), .a(tmp_or), .b(b_and_c));

endmodule

module Not(out, in);
    input in;
    output out;

    Universal_Gate UG(.out(out), .a(1), .b(in));

endmodule

module Copy(out, in);
    input in;
    output out;

    Universal_Gate UG(.out(out), .a(in), .b(0));

endmodule

module And(out, a, b);
    input a, b;
    output out;
    wire not_b;

    Not Not(.out(not_b), .in(b));
    Universal_Gate UG(.out(out), .a(a), .b(not_b));


endmodule

module Nand(out, a, b);
    input a, b;
    output out;
    wire a_and_b;

    And And(.out(a_and_b), .a(a), .b(b));
    Not Not(.out(out), .in(a_and_b));

endmodule

module Or(out, a, b);
    input a, b;
    output out;
    wire not_a, not_b;

    Not Not_a(.out(not_a), .in(a));
    Not Not_b(.out(not_b), .in(b));
    Nand NandOut(.out(out), .a(not_a), .b(not_b));

endmodule

module Xor(out, a, b);
    input a, b;
    output out;
    wire not_a, not_b, na_and_b, a_and_nb;

    Not Not_a(.out(not_a), .in(a));
    Not Not_b(.out(not_b), .in(b));

    And NA_AND_B(.out(na_and_b), .a(not_a), .b(b));
    And A_AND_NB(.out(a_and_nb), .a(a), .b(not_b));

    Or Or(.out(out), .a(na_and_b), .b(a_and_nb));

endmodule

module Xnor(out, a, b);
    input a, b;
    output out;
    wire a_xor_b;

    Xor Xor(.out(a_xor_b), .a(a), .b(b));
    Not Not(.out(out), .in(a_xor_b));

endmodule

module Mux_2to1(out, in0, in1, sel);
    input in0, in1, sel;
    output out;
    wire not_sel, tmp0, tmp1;

    Not Not(not_sel, sel);

    And And0(tmp0, in0, not_sel);
    And And1(tmp1, in1, sel);

    Or OrOut(out, tmp0, tmp1);

endmodule

module Mux_4to1(out, in0, in1, in2, in3, sel);
    input in0, in1, in2, in3;
    input [1:0] sel;
    output out;
    wire tmp0, tmp1;

    Mux_2to1 Mux0(tmp0, in0, in2, sel[1]);
    Mux_2to1 Mux1(tmp1, in1, in3, sel[1]);

    Mux_2to1 MuxOut(out, tmp0, tmp1, sel[0]);

endmodule

module Mux_8to1(out, in0, in1, in2, in3, in4, in5, in6, in7, sel);
    input in0, in1, in2, in3, in4, in5, in6, in7;
    input [2:0] sel;
    output out;
    wire tmp0, tmp1;

    Mux_4to1 Mux0(tmp0, in0, in2, in4, in6, sel[2:1]);
    Mux_4to1 Mux1(tmp1, in1, in3, in5, in7, sel[2:1]);

    Mux_2to1 MuxOut(out, tmp0, tmp1, sel[0]);

endmodule

module Mux_16to1(out, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, ina, inb, inc, ind, ine, inf, sel);
    input in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, ina, inb, inc, ind, ine, inf;
    input [3:0] sel;
    output out;
    wire tmp0, tmp1;

    Mux_8to1 Mux0(tmp0, in0, in2, in4, in6, in8, ina, inc, ine, sel[3:1]);
    Mux_8to1 Mux1(tmp1, in1, in3, in5, in7, in9, inb, ind, inf, sel[3:1]);

    Mux_2to1 MuxOut(out, tmp0, tmp1, sel[0]);

endmodule