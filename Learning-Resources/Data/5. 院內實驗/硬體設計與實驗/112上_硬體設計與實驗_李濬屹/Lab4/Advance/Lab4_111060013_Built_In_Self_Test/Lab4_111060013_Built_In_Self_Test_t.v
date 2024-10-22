`timescale 1ns / 1ps

module Lab4_111060013_Built_In_Self_Test_t;
    reg clk = 1'b1;
    reg rst_n = 1'b1;
    reg scan_en = 1'b0;
    wire scan_in, scan_out;

    Built_In_Self_Test BIST(clk, rst_n, scan_en, scan_in, scan_out);

    always # (1) clk = ~clk;

    initial begin
        
        @ (negedge clk)
            rst_n <= 1'b0;
            scan_en <= 1'b0;

        repeat (8) begin
            repeat (8) begin
                @ (negedge clk)
                    rst_n <= 1'b1;
                    scan_en <= 1'b1;
            end

            @ (negedge clk)
                rst_n <= 1'b1;
                scan_en <= 1'b0;

            repeat (8) begin
                @ (negedge clk)
                    rst_n <= 1'b1;
                    scan_en <= 1'b1;
            end

            @ (negedge clk)
                rst_n <= 1'b1;
                scan_en <= 1'b0;
        end

        @ (negedge clk)
            $finish;

    end

endmodule
