`timescale 1ns / 1ps

module Lab3_111060013_FIFO_8_t;
    reg clk = 1'b1, rst_n = 1'b1, ren, wen;
    reg [7:0] din;
    wire error;
    wire [7:0] dout;

    FIFO_8 Queue(.clk(clk),
        .rst_n(rst_n),
        .wen(wen),
        .ren(ren),
        .din(din),
        .dout(dout),
        .error(error)
    );

    always # (1) clk = ~clk;
    
    initial begin
        @(negedge clk)
            rst_n <= 1'b0;
            din <= 8'b00000000;
            ren <= 1'b1;
            wen <= 1'b0;

        @(negedge clk)
            rst_n <= 1'b1;

        @(negedge clk)
            ren <= 1'b0;
            wen <= 1'b1;
            din <= 8'd56;

        @(negedge clk)
            din <= 8'd11;

        @(negedge clk)
            din <= 8'd42;

        @(negedge clk)
            din <= 8'd10;

        @(negedge clk)
            din <= 8'd23;

        @(negedge clk)
            din <= 8'd20;

        @(negedge clk)
            din <= 8'd6;

        @(negedge clk)
            din <= 8'd85;

        @(negedge clk)
            din <= 8'd45;
            ren <= 1'b1;

        @(negedge clk)
            din <= 8'd12;
            ren <= 1'b0;

        @(negedge clk)
            din <= 8'd77;

        @(negedge clk)
            wen <= 0;
            din <= 8'd0;

        repeat (10) begin
            @(negedge clk)
                ren <= 1;
        end

        @(negedge clk)
            $finish;

    end

endmodule
