
`timescale 1ns / 1ps

module Lab3_111060013_Round_Robin_FIFO_Arbiter_t;
    reg clk = 1'b1;
    reg rst_n = 1'b1;
    reg [3:0] wen;
    reg [7:0] a, b, c, d;
    wire valid;
    wire [7:0] dout;

    Round_Robin_FIFO_Arbiter RRFA(
        .clk(clk),
        .rst_n(rst_n),
        .wen(wen),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .dout(dout),
        .valid(valid)
    );

    always # (1) clk = ~clk;

    initial begin
        @(negedge clk) 
            rst_n <= 1'b0;

        @(negedge clk)
            rst_n <= 1'b1;
            wen <= 4'b1111;
            a <= 8'd87;
            b <= 8'd56;
            c <= 8'd9;
            d <= 8'd13;

        @(negedge clk)
            wen <= 4'b1000;
            a <= 8'd0;
            b <= 8'd0;
            c <= 8'd0;
            d <= 8'd85;

        @(negedge clk)
            wen <= 4'b0100;
            c <= 8'd139;
            d <= 8'd0;

        @(negedge clk)
            wen <= 4'b0000;
            c <= 8'd0;

        @(negedge clk)
            wen <= 4'b0000;

        @(negedge clk
            )wen <= 4'b0000;

        @(negedge clk)
            wen <= 4'b0001;
            a <= 8'd51;

        @(negedge clk)
            wen <= 4'b0000;
            a <= 8'd0;

        @(negedge clk)
            wen <= 4'b0000;

        repeat (4) @(negedge clk);

        repeat (8) begin
            @(negedge clk)
                wen <= 4'b1111;
                a <= 4'd1;
                b <= 4'd2;
                c <= 4'd3;
                d <= 4'd4;
        end
        
        @(negedge clk)
            a <= 4'd5;
            b <= 4'd6;
            c <= 4'd7;
            d <= 4'd8;

        @(negedge clk);
        @(negedge clk);

        repeat (4 * 9) begin
            @(negedge clk)
                wen <= 4'b0000;
                a <= 4'd0;
                b <= 4'd0;
                c <= 4'd0;
                d <= 4'd0;
        end

        @(negedge clk);
        @(negedge clk)
            $finish;

    end

endmodule
