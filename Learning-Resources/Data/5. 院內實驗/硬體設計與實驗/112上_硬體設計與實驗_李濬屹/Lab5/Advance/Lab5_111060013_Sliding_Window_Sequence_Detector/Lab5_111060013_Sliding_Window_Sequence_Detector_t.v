`timescale 1ns / 1ps

module Lab5_111060013_Sliding_Window_Sequence_Detector_t;
    reg clk = 1'b1;
    reg rst_n = 1'b1;
    reg in = 1'b0;
    wire dec;

    always # (1) clk = ~clk;

    Sliding_Window_Sequence_Detector SWSD(clk, rst_n, in, dec);

    initial begin

        @ (negedge clk)
            rst_n = 1'b0;

        @ (negedge clk)
            rst_n = 1'b1;
            in = 1'b1;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b0;

        @ (negedge clk)
            in = 1'b0;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b0;

        @ (negedge clk)
            in = 1'b0;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b0;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b0;


        @ (negedge clk)
            rst_n = 1'b0;

        @ (negedge clk)
            rst_n = 1'b1;
            in = 1'b0;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b0;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b0;

        @ (negedge clk)
            in = 1'b0;

        @ (negedge clk)
            in = 1'b1;

        @ (negedge clk)
            in = 1'b0;

        @ (negedge clk)
            in = 1'b0;

        @ (negedge clk)
            in = 1'b0;
            
        @ (negedge clk)
            in = 1'b0;

        @ (negedge clk)
            in = 1'b0;

        @ (negedge clk)
            $finish;

    end

endmodule
