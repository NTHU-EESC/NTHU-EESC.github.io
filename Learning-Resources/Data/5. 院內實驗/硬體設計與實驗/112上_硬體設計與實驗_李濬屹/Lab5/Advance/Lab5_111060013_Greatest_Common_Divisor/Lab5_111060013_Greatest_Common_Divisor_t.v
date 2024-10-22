`timescale 1ns / 1ps

module Lab5_111060013_Greatest_Common_Divisor_t;
    reg clk = 1'b1;
    reg rst_n = 1'b1;
    reg start = 1'b0;
    reg [15:0] a = 16'd0;
    reg [15:0] b = 16'd0;
    wire done;
    wire [15:0] gcd;

    always # (1) clk <= ~clk;

    Greatest_Common_Divisor GCD(clk, rst_n, start, a, b, done, gcd);

    initial begin

        @ (negedge clk)
            rst_n <= 1'b0;

        @ (negedge clk)
            rst_n <= 1'b1;

        @ (negedge clk)
            a <= 16'd6;
            b <= 16'd12;
            start <= 1'b1;

        while (!done) begin
            @ (negedge clk) start <= 1'b0;
        end

        @ (negedge clk);
        @ (negedge clk);

        @ (negedge clk)
            a <= 16'd75;
            b <= 16'd90;
            start <= 1'b1;

        while (!done) begin
            @ (negedge clk) start <= 1'b0;
        end

        @ (negedge clk);
        @ (negedge clk);

        @ (negedge clk)
            a <= 16'd12;
            b <= 16'd6;
            start <= 1'b1;

        while (!done) begin
            @ (negedge clk) start <= 1'b0;
        end

        @ (negedge clk);
        @ (negedge clk);

        @ (negedge clk)
            a <= 16'd90;
            b <= 16'd75;
            start <= 1'b1;

        while (!done) begin
            @ (negedge clk) start <= 1'b0;
        end

        @ (negedge clk);
        @ (negedge clk);

        @ (negedge clk)
            $finish;
        
    end

endmodule
