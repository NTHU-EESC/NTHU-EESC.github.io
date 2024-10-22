`timescale 1ns / 1ps

module Lab5_111060013_Booth_Multiplier_4bit_t;
    reg clk = 1'b1;
    reg rst_n = 1'b1;
    reg start = 1'b0;
    reg signed [3:0] a = 4'd0, b = 4'd0;
    wire signed [7:0] p;
    reg [7:0] count = 8'd0;

    always # (1) clk <= ~clk;

    Booth_Multiplier_4bit BM4(clk, rst_n, start, a, b, p);

    initial begin

        @ (negedge clk)
            rst_n <= 1'b0;

        @ (negedge clk)
            rst_n <= 1'b1;
        repeat (256) begin
            @ (negedge clk)
                a <= count[7:4];
                b <= count[3:0];
                start <= 1'b1;
                count <= count + 1;

            repeat (6) begin
                @ (negedge clk)
                    start = 1'b0;
            end

            @ (negedge clk);

        end

        @ (negedge clk)
            $finish;
        
    end

endmodule
