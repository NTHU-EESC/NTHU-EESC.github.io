`timescale 1ns / 1ps

module Lab1_111060013_Dmux_1x4_4bit_t;
    reg [3:0] in = 4'b0001;
    reg [1:0] sel = 2'b00;
    wire [3:0] out0, out1, out2, out3;

    Dmux_1x4_4bit Dmux(
        .in(in),
        .sel(sel),
        .a(out0),
        .b(out1),
        .c(out2),
        .d(out3)
    );

    initial begin
        #1 sel = 2'b01;
        #1 sel = 2'b10;
        #1 sel = 2'b11;
        #1 sel = 2'b00;
           in = 4'b1111;
        #1 sel = 2'b01;
        #1 sel = 2'b10;
        #1 sel = 2'b11;
        #1 $finish;
    end


endmodule