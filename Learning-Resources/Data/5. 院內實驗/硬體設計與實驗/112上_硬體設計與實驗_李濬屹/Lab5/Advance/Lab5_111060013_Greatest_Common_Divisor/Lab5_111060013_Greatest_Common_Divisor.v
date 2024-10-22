`timescale 1ns/1ps

module Greatest_Common_Divisor (clk, rst_n, start, a, b, done, gcd);
    input clk, rst_n;
    input start;
    input [15:0] a;
    input [15:0] b;
    output reg done;
    output reg [15:0] gcd;
    reg [1:0] state, tmp_state;
    reg [15:0] fixed_a, fixed_b, tmp_a, tmp_b, tmp_gcd;
    reg tmp_done;
    reg count, tmp_count;

    parameter WAIT = 2'b00;
    parameter CAL = 2'b01;
    parameter FINISH = 2'b10;

    always @ (posedge clk) begin
        state <= tmp_state;
        fixed_a <= tmp_a;
        fixed_b <= tmp_b;
        gcd <= tmp_gcd;
        done <= tmp_done;
        count <= tmp_count;
    end

    always @ (*) begin
        if (!rst_n) begin
            tmp_state = WAIT;
            tmp_a = 16'd0;
            tmp_b = 16'd0;
            tmp_gcd = 16'd0;
            tmp_done = 1'b0;
            tmp_count = 1'b0;
        end
        else begin
            case (state)
                WAIT: begin
                    if (start) begin
                        tmp_state = CAL;
                        tmp_a = a;
                        tmp_b = b;
                        tmp_gcd = 16'd0;
                        tmp_done = 1'b0;
                        tmp_count = 1'b0;
                    end
                    else begin
                        tmp_state = WAIT;
                        tmp_a = fixed_a;
                        tmp_b = fixed_b;
                        tmp_gcd = 16'd0;
                        tmp_done = 1'b0;
                        tmp_count = 1'b0;
                    end
                end
                CAL: begin
                    if (fixed_a == 16'd0) begin
                        tmp_state = FINISH;
                        tmp_a = fixed_a;
                        tmp_b = fixed_b;
                        tmp_gcd = fixed_b;
                        tmp_done = 1'b1;
                        tmp_count = 1'b0;
                    end
                    else if (fixed_b != 16'd0) begin
                        if (fixed_a > fixed_b) begin
                            tmp_state = CAL;
                            tmp_a = fixed_a - fixed_b;
                            tmp_b = fixed_b;
                            tmp_gcd = 16'd0;
                            tmp_done = 1'b0;
                            tmp_count = 1'b0;
                        end
                        else begin
                            tmp_state = CAL;
                            tmp_a = fixed_a;
                            tmp_b = fixed_b - fixed_a;
                            tmp_gcd = 16'd0;
                            tmp_done = 1'b0;
                            tmp_count = 1'b0;
                        end
                    end
                    else begin
                        tmp_state = FINISH;
                        tmp_a = fixed_a;
                        tmp_b = fixed_b;
                        tmp_gcd = fixed_a;
                        tmp_done = 1'b1;
                        tmp_count = 1'b0;
                    end
                end
                FINISH: begin
                    if (count == 1'b1) begin
                        tmp_state = WAIT;
                        tmp_a = fixed_a;
                        tmp_b = fixed_b;
                        tmp_gcd = 16'd0;
                        tmp_done = 1'b0;
                        tmp_count = 1'b0;
                    end
                    else begin
                        tmp_state = FINISH;
                        tmp_a = fixed_a;
                        tmp_b = fixed_b;
                        tmp_gcd = gcd;
                        tmp_done = 1'b1;
                        tmp_count = count + 1;
                    end
                end
                default: begin
                    tmp_state = state;
                    tmp_a = fixed_a;
                    tmp_b = fixed_b;
                    tmp_gcd = gcd;
                    tmp_done = done;
                    tmp_count = count;
                end
            endcase
        end
    end

endmodule