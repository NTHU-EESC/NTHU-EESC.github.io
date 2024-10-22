`timescale 1ns/1ps 

module Booth_Multiplier_4bit(clk, rst_n, start, a, b, p);
    input clk;
    input rst_n; 
    input start;
    input signed [3:0] a, b;
    output reg signed [7:0] p;
    reg [7:0] tmp_p;
    reg [4:0] neg_a;
    reg [9:0] P, tmp_P, A, tmp_A, S, tmp_S, sumPA, sumPS;
    reg [1:0] state, tmp_state;
    reg [1:0] count, tmp_count;

    parameter WAIT = 2'd0;
    parameter CAL = 2'd1;
    parameter FINISH = 2'd2;

    always @ (*) begin
        neg_a = ~{a[3], a} + 1;
        sumPA = P + A;
        sumPS = P + S;
    end

    always @ (posedge clk) begin
        state <= tmp_state;
        count <= tmp_count;
        p <= tmp_p;
        P <= tmp_P;
        A <= tmp_A;
        S <= tmp_S;
    end

    always @ (*) begin
        if (!rst_n) begin
            tmp_state = WAIT;
            tmp_count = 2'd0;
            tmp_p = 8'd0;
            tmp_P = 10'd0;
            tmp_A = 10'd0;
            tmp_S = 10'd0;
        end
        else begin
            case (state)

                WAIT: begin
                    if (start) begin
                        tmp_state = CAL;
                        tmp_count = 2'd0;
                        tmp_p = 8'd0;
                        tmp_P = {5'd0, b, 1'd0};
                        tmp_A = {a[3], a, 5'd0};
                        tmp_S = {neg_a, 5'd0};
                    end
                    else begin
                        tmp_state = WAIT;
                        tmp_count = 2'd0;
                        tmp_p = 8'd0;
                        tmp_P = 10'd0;
                        tmp_A = 10'd0;
                        tmp_S = 10'd0;
                    end
                end

                CAL: begin
                    if (count == 2'd3) begin
                        tmp_state = FINISH;
                        tmp_count = 2'd0;
                        tmp_A = A;
                        tmp_S = S;
                        case (P[1:0])
                            2'b00: begin
                                tmp_P = {P[9], P[9:1]};
                                tmp_p = tmp_P[8:1];
                            end
                            2'b01: begin
                                tmp_P = {sumPA[9], sumPA[9:1]};
                                tmp_p = tmp_P[8:1];
                            end
                            2'b10: begin
                                tmp_P = {sumPS[9], sumPS[9:1]};
                                tmp_p = tmp_P[8:1];
                            end
                            2'b11: begin
                                tmp_P = {P[9], P[9:1]};
                                tmp_p = tmp_P[8:1];
                            end
                            default: begin
                                tmp_P = P;
                                tmp_p = p;
                            end
                        endcase
                    end
                    else begin
                        tmp_state = CAL;
                        tmp_count = count + 1;
                        tmp_p = 8'd0;
                        tmp_A = A;
                        tmp_S = S;
                        case (P[1:0])
                            2'b00: begin
                                tmp_P = {P[9], P[9:1]};
                            end
                            2'b01: begin
                                tmp_P = {sumPA[9], sumPA[9:1]};
                            end
                            2'b10: begin
                                tmp_P = {sumPS[9], sumPS[9:1]};
                            end
                            2'b11: begin
                                tmp_P = {P[9], P[9:1]};
                            end
                            default: begin
                                tmp_P = P;
                            end
                        endcase
                    end
                    
                end

                FINISH: begin
                    if (count == 2'd1) begin
                        tmp_state = WAIT;
                        tmp_count = 2'd0;
                        tmp_p = 8'd0;
                        tmp_P = 10'd0;
                        tmp_A = 10'd0;
                        tmp_S = 10'd0;
                    end
                    else begin
                        tmp_state = FINISH;
                        tmp_count = count + 1;
                        tmp_p = p;
                        tmp_P = 10'd0;
                        tmp_A = 10'd0;
                        tmp_S = 10'd0;
                    end
                end

                default: begin
                    tmp_state = state;
                    tmp_count = count;
                    tmp_p = p;
                    tmp_P = P;
                    tmp_A = A;
                    tmp_S = S;
                end
                
            endcase
                    
        end
    end


endmodule
