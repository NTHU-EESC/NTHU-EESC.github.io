module GCD (
  input wire CLK,
  input wire RST_N,
  input wire [7:0] A,
  input wire [7:0] B,
  input wire START,
  output reg [7:0] Y,
  output reg DONE,
  output reg ERROR
);

wire found, err;
reg [7:0] reg_a, reg_b, next_a, next_b;
reg [7:0] big_one;
reg error_next;
reg [1:0] state, state_next;

parameter [1:0] IDLE = 2'b00;
parameter [1:0] CALC = 2'b01;
parameter [1:0] FINISH = 2'b10;



always @(posedge CLK) begin
    if(RST_N == 0)begin
        state = IDLE;
        DONE = 0;
        ERROR = 0;
        Y = 0;
    end
    else begin
        state = state_next;
    end

    state_next = IDLE;
    case(state)
        IDLE:begin
            if(!START)
                state_next = IDLE;
            else begin
                state_next = CALC;
                next_a = A;
                next_b = B;
                error_next = (A == 0 || B == 0);
            end
        end
        
        CALC:begin
            reg_a = next_a;
            reg_b = next_b;
            
            if(error_next == 1) ERROR = 1;
            else ERROR = 0;
            
            if(reg_a > reg_b)begin
                next_a = reg_a - reg_b;
                next_b = reg_b;
            end
            else begin
                next_b = reg_b - reg_a;
                next_a = reg_a;
            end
            
            
            
            if(!found && !ERROR) begin
                Y = 0;
                state_next = CALC;
                error_next = ERROR;
            end
            else begin
                if(next_a == 0) Y = next_b;
                else Y = next_a;
                state_next = FINISH;
                DONE = 1;
                error_next = ERROR;
            end
        end
        
        FINISH:begin
            Y = 0;
            state_next = IDLE;
            DONE = 0;
            ERROR = 0;
        end
    endcase
end

assign found = (next_a == 0 || next_b == 0) ? 1 : 0;

endmodule
