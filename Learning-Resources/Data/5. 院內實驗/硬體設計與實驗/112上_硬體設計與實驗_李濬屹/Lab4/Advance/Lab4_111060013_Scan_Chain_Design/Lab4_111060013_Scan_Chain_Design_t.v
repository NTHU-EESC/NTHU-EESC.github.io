`timescale 1ns / 1ps

module Lab4_111060013_Scan_Chain_Design_t;
    reg clk = 1'b1;
    reg rst_n = 1'b1;
    reg scan_in, scan_en;
    reg [7:0] input_arr, multi_ans;
    reg err;
    wire scan_out;

    Scan_Chain_Design SCD(clk, rst_n, scan_in, scan_en, scan_out);

    always # (1) clk = ~clk;

    initial begin

        // reset
        @ (negedge clk)
            rst_n <= 1'b0;
            scan_in <= 1'b0;
            scan_en <= 1'b0;
            err <= 1'b0;
            input_arr <= 8'b10100101;

        // input
        for (integer i = 0; i < 8; i = i + 1) begin
            @ (negedge clk)
                rst_n <= 1'b1;
                scan_in <= input_arr[i];
                scan_en <= 1'b1;
                err <= 1'b0;
        end

        // capture
        @ (negedge clk)
            rst_n <= 1'b1;
            scan_in <= 1'b0;
            scan_en <= 1'b0;
            err <= 1'b0;
            input_arr <= input_arr * 3 - 1;
            multi_ans <= input_arr[7:4] * input_arr[3:0];

        // cycle
        repeat (8) begin

            for (integer i = 0; i < 8; i = i + 1) begin
                @ (negedge clk)
                    rst_n <= 1'b1;
                    scan_in <= input_arr[i];
                    scan_en <= 1'b1;
                    err <= scan_out != multi_ans[i];
            end

            @ (negedge clk)
                rst_n <= 1'b1;
                scan_in <= 1'b0;
                scan_en <= 1'b0;
                err <= 1'b0;
                input_arr <= input_arr * 3 - 1;
                multi_ans <= input_arr[7:4] * input_arr[3:0];
            
        end

        @ (negedge clk)
            $finish;

    end

endmodule
