`timescale 1ns/1ps

module Many_To_One_LFSR(clk, rst_n, out);
    input clk;
    input rst_n;
    output reg [8-1:0] out;

    always @ (posedge clk) begin
        if (!rst_n) out <= 8'b10111101;
        else out <= {out[6:0], in};
    end

    assign in = (out[1] ^ out[2]) ^ (out[3] ^ out[7]);

endmodule

