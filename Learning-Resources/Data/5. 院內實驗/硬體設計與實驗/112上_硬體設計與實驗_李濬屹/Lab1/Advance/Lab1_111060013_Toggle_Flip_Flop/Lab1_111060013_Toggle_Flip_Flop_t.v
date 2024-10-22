`timescale 1ns / 1ps

module Lab1_111060013_Toggle_Flip_Flop_t;
    reg t = 1'b0;
    reg rst_n = 1'b0;
    reg clk = 1'b0;
    wire q;

    Toggle_Flip_Flop TFF(
        .t(t),
        .rst_n(rst_n),
        .clk(clk),
        .q(q)
    );

    always#(1) clk = ~clk;

    initial begin
        @(negedge clk) rst_n = 1'b1;
        @(negedge clk) t <= ~t;
        @(negedge clk) t <= ~t;
        @(negedge clk) t <= ~t;
        @(negedge clk) t <= ~t;
        @(negedge clk) $finish;
    end

endmodule