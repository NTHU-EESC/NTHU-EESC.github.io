`timescale 1ns/1ps

module Traffic_Light_Controller (clk, rst_n, lr_has_car, hw_light, lr_light);
    input clk, rst_n;
    input lr_has_car;
    output reg [2:0] hw_light;
    output reg [2:0] lr_light;
    reg [6:0] count, tmp_count;
    reg [2:0] tmp_hw_light, tmp_lr_light;
    reg [2:0] state, tmp_state;

    parameter A = 3'd0;
    parameter B = 3'd1;
    parameter C = 3'd2;
    parameter D = 3'd3;
    parameter E = 3'd4;
    parameter F = 3'd5;

    parameter Green = 3'b100;
    parameter Yellow = 3'b010;
    parameter Red = 3'b001;

    always @(posedge clk) begin
        count <= tmp_count;
        hw_light <= tmp_hw_light;
        lr_light <= tmp_lr_light;
        state <= tmp_state;
    end

    always @ (*) begin
        if (!rst_n) begin
            tmp_state = A;
            tmp_hw_light = Green;
            tmp_lr_light = Red;
            tmp_count = 7'd0;
        end
        else begin
            case (state)

                A: begin
                    if (count == 7'd69) begin
                        if (lr_has_car) begin
                            tmp_state = B;
                            tmp_hw_light = Yellow;
                            tmp_lr_light = Red;
                            tmp_count = 7'd0;
                        end
                        else begin
                            tmp_state = state;
                            tmp_hw_light = hw_light;
                            tmp_lr_light = lr_light;
                            tmp_count = count;
                        end
                    end
                    else begin
                        tmp_state = state;
                        tmp_hw_light = hw_light;
                        tmp_lr_light = lr_light;
                        tmp_count = count + 1;
                    end
                end

                B: begin
                    if (count == 7'd24) begin
                        tmp_state = C;
                        tmp_hw_light = Red;
                        tmp_lr_light = Red;
                        tmp_count = 7'd0;
                    end
                    else begin
                        tmp_state = state;
                        tmp_hw_light = hw_light;
                        tmp_lr_light = lr_light;
                        tmp_count = count + 1;
                    end
                end

                C: begin
                    tmp_state = D;
                    tmp_hw_light = Red;
                    tmp_lr_light = Green;
                    tmp_count = 7'd0;
                end

                D: begin
                    if (count == 7'd69) begin
                        tmp_state = E;
                        tmp_hw_light = Red;
                        tmp_lr_light = Yellow;
                        tmp_count = 7'd0;
                    end
                    else begin
                        tmp_state = state;
                        tmp_hw_light = hw_light;
                        tmp_lr_light = lr_light;
                        tmp_count = count + 1;
                    end
                end

                E: begin
                    if (count == 7'd24) begin
                        tmp_state = F;
                        tmp_hw_light = Red;
                        tmp_lr_light = Red;
                        tmp_count = 7'd0;
                    end
                    else begin
                        tmp_state = state;
                        tmp_hw_light = hw_light;
                        tmp_lr_light = lr_light;
                        tmp_count = count + 1;
                    end
                end

                F: begin
                    tmp_state = A;
                    tmp_hw_light = Green;
                    tmp_lr_light = Red;
                    tmp_count = 7'd0;
                end

                default: begin
                    tmp_state = state;
                    tmp_hw_light = hw_light;
                    tmp_lr_light = lr_light;
                    tmp_count = count;
                end

            endcase
        end
    end

endmodule
