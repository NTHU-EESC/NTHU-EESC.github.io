`timescale 1ns/1ps

module Parameterized_Ping_Pong_Counter (clk, rst_n, enable, flip, max, min, direction, out);
    input clk, rst_n;
    input enable;
    input flip;
    input [4-1:0] max;
    input [4-1:0] min;
    output reg direction;
    output reg [4-1:0] out;

    reg newEnable, able_flip, hit;
    reg tmp_dir;
    reg [3:0] tmp_out;

    // Combinational: direction
    always @ (*) begin
        newEnable = enable && (min < max) && !(out < min) && !(out > max);
        able_flip = (out > min) && (out < max) && flip;
        hit = (direction == 1'b1 && out == max) || (direction == 1'b0 && out == min);
    end

    always @ (*) begin
        if (rst_n == 1'b0) tmp_dir = 1'b1;
        else if (newEnable && (able_flip || hit)) tmp_dir = ~direction;
        else tmp_dir = direction;
    end

    // DFF: direction
    always @ (posedge clk) begin
        direction <= tmp_dir;
    end

    // Mux: out
    always @ (*) begin
        if (rst_n == 1'b0) tmp_out = min;
        else if (newEnable) begin
            case ({direction, able_flip})
                2'b00: tmp_out = (out == min) ? out + 1 : out - 1;
                2'b10: tmp_out = (out == max) ? out - 1 : out + 1;
                2'b01: tmp_out = out + 1;
                2'b11: tmp_out = out - 1;
            endcase
        end
        else tmp_out = out;
    end

    // DFF: out
    always @ (posedge clk) begin
        out <= tmp_out;
    end

endmodule