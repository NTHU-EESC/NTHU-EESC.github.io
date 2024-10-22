`timescale 1ns/1ps
module tracker_sensor(clk, reset, left_signal, right_signal, mid_signal, state);
    input clk;
    input reset;
    input left_signal, right_signal, mid_signal;
    output reg [2:0] state;

    parameter STOP = 3'd0;
    parameter FOWARD = 3'd1;
    parameter BACK = 3'd2;
    parameter LEFT = 3'd3;
    parameter RIGHT = 3'd4;
    parameter STRONG_LEFT = 3'd5;
    parameter STRONG_RIGHT = 3'd6;

    reg [2:0] next_state;
    reg [22:0] counter;
    
    // [TO-DO] Receive three signals and make your own policy.
    // Hint: You can use output state to change your action.

    always @ (posedge clk) begin
        if (reset==1'd1) begin
            state <= STOP;
        end
        else begin
            state <= next_state;
        end
    end
    always @ (*) begin
        case ({left_signal, mid_signal, right_signal})
            3'b000: begin
                if (state == STRONG_LEFT || state == STRONG_RIGHT) next_state = state;
                else if (state == LEFT) next_state = STRONG_LEFT;
                else if (state == RIGHT) next_state = STRONG_RIGHT;
                else next_state = BACK;
            end
            3'b001: begin
                next_state = STRONG_RIGHT;
            end
            3'b011: begin
                next_state = RIGHT;
            end
            3'b010: begin
                next_state = FOWARD;
            end
            3'b111: begin
                next_state = FOWARD;
            end
            3'b110: begin
                next_state = LEFT;
            end
            3'b100: begin
                next_state = STRONG_LEFT;
            end
            default: begin
                next_state = BACK;
            end
        endcase
    end

endmodule
