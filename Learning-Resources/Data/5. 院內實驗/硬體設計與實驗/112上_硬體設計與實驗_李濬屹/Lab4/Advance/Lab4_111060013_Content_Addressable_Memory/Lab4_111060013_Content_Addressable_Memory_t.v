`timescale 1ns / 1ps

module Lab4_111060013_Content_Addressable_Memory_t;
    reg clk = 1'b1;
    reg wen, ren;
    reg [7:0] din;
    reg [3:0] addr;
    wire [3:0] dout;
    wire hit;

    Content_Addressable_Memory CAM(clk, wen, ren, din, addr, dout, hit);

    always # (1) clk = ~clk;

    initial begin
        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b1;
            ren <= 1'b0;
            din <= 8'd4;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b1;
            ren <= 1'b0;
            din <= 8'd8;
            addr <= 4'd7;

        @ (negedge clk)
            wen <= 1'b1;
            ren <= 1'b0;
            din <= 8'd35;
            addr <= 4'd15;

        @ (negedge clk)
            wen <= 1'b1;
            ren <= 1'b0;
            din <= 8'd8;
            addr <= 4'd9;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b1;
            din <= 8'd4;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b1;
            din <= 8'd8;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b1;
            din <= 8'd35;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b1;
            din <= 8'd87;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b1;
            din <= 8'd45;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b1;
            ren <= 1'b1;
            din <= 8'd35;
            addr <= 4'd5;

        @ (negedge clk)
            wen <= 1'b1;
            ren <= 1'b1;
            din <= 8'd4;
            addr <= 4'd5;

        @ (negedge clk)
            wen <= 1'b1;
            ren <= 1'b1;
            din <= 8'd8;
            addr <= 4'd5;
        
        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b1;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd9;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b1;
            din <= 8'd8;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b1;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            wen <= 1'b0;
            ren <= 1'b0;
            din <= 8'd0;
            addr <= 4'd0;

        @ (negedge clk)
            $finish;
    end

endmodule
