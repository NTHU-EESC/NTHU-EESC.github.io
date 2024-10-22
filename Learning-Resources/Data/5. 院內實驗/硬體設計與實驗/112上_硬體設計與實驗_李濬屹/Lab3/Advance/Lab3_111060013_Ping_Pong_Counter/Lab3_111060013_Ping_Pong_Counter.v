`timescale 1ns/1ps

module Ping_Pong_Counter (clk, rst_n, enable, direction, out);
    input clk, rst_n;
    input enable;
    output reg direction;
    output reg [4-1:0] out;

    reg [3:0] tmp_out;
    reg tmp_dir;

    // Mux
    always @ (direction or out or enable or rst_n) begin
        if (rst_n == 1'b0) tmp_dir = 1'b1;
        else if (enable && ((direction == 1'b1 && out == 4'b1111) || (direction == 1'b0 && out == 4'b0000)))
            tmp_dir = ~direction;
        else tmp_dir = direction;
    end

    // DFF
    always @ (posedge clk) begin
        direction <= tmp_dir;
    end

    // Mux
    always @ (direction or out or enable or rst_n) begin
        if (rst_n == 1'b0) tmp_out = 4'b0000;
        else if (enable == 1'b1) begin
            case (direction)
                1'b0: tmp_out = (out == 4'b0000) ? out + 1 : out - 1;
                1'b1: tmp_out = (out == 4'b1111) ? out - 1 : out + 1;
            endcase
        end
        else tmp_out = out;
    end

    // DFF
    always @ (posedge clk) begin
        out <= tmp_out;
    end

endmodule
