module Top(
    input clk,
    input rst,
    input echo,
    input left_signal,
    input right_signal,
    input mid_signal,
    output trig,
    output left_motor,
    output reg [1:0]left,
    output right_motor,
    output reg [1:0]right
);

    parameter STOP = 3'd0;
    parameter FOWARD = 3'd1;
    parameter BACK = 3'd2;
    parameter LEFT = 3'd3;
    parameter RIGHT = 3'd4;
    parameter STRONG_LEFT = 3'd5;
    parameter STRONG_RIGHT = 3'd6;

    wire Rst_n, rst_pb, stop;
    wire [2:0] state;
    reg [2:0] mode;
    debounce d0(rst_pb, rst, clk);
    onepulse d1(rst_pb, clk, Rst_n);

    // reg [24:0] state_dclk;

    motor A(
        .clk(clk),
        .rst(rst_pb),
        .mode(mode),
        .pwm({left_motor, right_motor})
    );

    sonic_top B(
        .clk(clk), 
        .rst(rst_pb), 
        .Echo(echo), 
        .Trig(trig),
        .stop(stop)
    );
    
    tracker_sensor C(
        .clk(clk), 
        .reset(rst_pb), 
        .left_signal(left_signal), 
        .right_signal(right_signal),
        .mid_signal(mid_signal), 
        .state(state)
    );

    always @(*) begin
        // [TO-DO] Use left and right to set your pwm
        //if(stop) {left, right} = ???;
        //else  {left, right} = ???;
        if (stop) mode = state;
        else mode = state;
    end

    always @ (*) begin
        case (mode)
            STOP: begin
                left = 2'b00;
                right = 2'b00;
            end
            FOWARD: begin
                left = 2'b10;
                right = 2'b10;
            end
            BACK: begin
                left = 2'b01;
                right = 2'b01;
            end
            LEFT: begin
                left = 2'b00;
                right = 2'b10;
            end
            RIGHT: begin
                left = 2'b10;
                right = 2'b00;
            end
            STRONG_LEFT: begin
                left = 2'b01;
                right = 2'b10;
            end
            STRONG_RIGHT: begin
                left = 2'b10;
                right = 2'b01;
            end
            default: begin
                left = 2'b01;
                right = 2'b01;
            end
        endcase
    end

endmodule

module debounce (pb_debounced, pb, clk);
    output pb_debounced; 
    input pb;
    input clk;
    reg [4:0] DFF;
    
    always @(posedge clk) begin
        DFF[4:1] <= DFF[3:0];
        DFF[0] <= pb; 
    end
    assign pb_debounced = (&(DFF)); 
endmodule

module onepulse (PB_debounced, clk, PB_one_pulse);
    input PB_debounced;
    input clk;
    output reg PB_one_pulse;
    reg PB_debounced_delay;

    always @(posedge clk) begin
        PB_one_pulse <= PB_debounced & (! PB_debounced_delay);
        PB_debounced_delay <= PB_debounced;
    end 
endmodule

