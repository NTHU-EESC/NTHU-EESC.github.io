`timescale 1ns / 1ps

module Lab5_111060013_Traffic_Light_Controller_t;
    reg clk = 1'b1;
    reg rst_n = 1'b1;
    reg lr_has_car = 1'b0;
    wire [2:0] hw_light, lr_light;

    always # (1) clk <= ~clk;

    Traffic_Light_Controller TLC(clk, rst_n, lr_has_car, hw_light, lr_light);

    initial begin

        @ (negedge clk)
            rst_n = 1'b0;

        @ (negedge clk)
            rst_n = 1'b1;
        
        repeat (75) @ (negedge clk);

        @ (negedge clk)
            lr_has_car <= 1'b1;

        repeat (25) begin
            @ (negedge clk)
                lr_has_car <= 1'b0;
        end

        @ (negedge clk);

        repeat (70) @ (negedge clk);

        repeat (25) @ (negedge clk);

        @ (negedge clk)
            lr_has_car <= 1'b1;

        repeat (70) @ (negedge clk);

        repeat (25) @ (negedge clk);

        @ (negedge clk);

        repeat (70) @ (negedge clk);

        repeat (25) @ (negedge clk);

        @ (negedge clk)
            $finish;

    end

endmodule
