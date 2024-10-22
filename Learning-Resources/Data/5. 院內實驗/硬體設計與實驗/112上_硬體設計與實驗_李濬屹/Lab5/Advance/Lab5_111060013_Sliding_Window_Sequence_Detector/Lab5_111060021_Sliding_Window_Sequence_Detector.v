`timescale 1ns/1ps

module Sliding_Window_Sequence_Detector (clk, rst_n, in, dec);
input clk, rst_n;
input in;
output reg dec;
reg [3:0] state, next_state;  //¦@¦³8­Óstate
parameter S0 = 4'b0000;
parameter S1 = 4'b0001;
parameter S2 = 4'b0010;
parameter S3 = 4'b0011;
parameter S4 = 4'b0100;
parameter S5 = 4'b0101;
parameter S6 = 4'b0110;
parameter S7 = 4'b0111;

always @(posedge clk) begin
    if(rst_n == 1'b0) state <= S0;
    else state <= next_state;
end

always @(*) begin
    case(state)
        S0: begin
            if(in == 1'b0)  next_state = S0;
            else            next_state = S1;
            dec = 0;
        end
        
        S1: begin
            if(in == 1'b0)  next_state = S0;
            else            next_state = S2;
            dec = 0;
        end
        
        S2: begin
            if(in == 1'b0)  next_state = S0;
            else            next_state = S3;
            dec = 0;
        end
        
        S3: begin
            if(in == 1'b0)  next_state = S4;
            else            next_state = S3;
            dec = 0;
        end
        
        S4: begin
            if(in == 1'b0)  next_state = S5;
            else            next_state = S1;
            dec = 0;
        end
        
        S5: begin
            if(in == 1'b0)  next_state = S0;
            else            next_state = S6;
            dec = 0;
        end
        
        S6: begin
            if(in == 1'b0)  next_state = S5;
            else            next_state = S7;
            dec = 0;
        end
        
        S7: begin
            if(in == 1'b0)  next_state = S0;
            else            next_state = S3;
            dec = (in == 1'b0) ? 1'b0 : 1'b1;
        end
    endcase
end

endmodule 