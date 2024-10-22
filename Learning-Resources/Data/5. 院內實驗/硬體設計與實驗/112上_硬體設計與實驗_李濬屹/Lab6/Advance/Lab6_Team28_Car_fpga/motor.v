module motor(
    input clk,
    input rst,
    input [2:0] mode,
    output [1:0] pwm
);

    wire [9:0]left_motor, right_motor;
    wire left_pwm, right_pwm;

    parameter STOP = 3'd0;
    parameter FOWARD = 3'd1;
    parameter BACK = 3'd2;
    parameter LEFT = 3'd3;
    parameter RIGHT = 3'd4;
    parameter STRONG_LEFT = 3'd5;
    parameter STRONG_RIGHT = 3'd6;

    motor_pwm m0(clk, rst, left_motor, left_pwm);
    motor_pwm m1(clk, rst, right_motor, right_pwm);


    assign left_motor = 10'd1023;
    assign right_motor = 10'd1023;

    // [TO-DO] take the right speed for different situation
    
    assign pwm = {left_pwm, right_pwm};
endmodule

module motor_pwm (
    input clk,
    input reset,
    input [9:0]duty,
	output pmod_1 //PWM
);
        
    PWM_gen pwm_0 ( 
        .clk(clk), 
        .reset(reset), 
        .freq(32'd25000),
        .duty(duty), 
        .PWM(pmod_1)
    );

endmodule

//generte PWM by input frequency & duty
module PWM_gen (
    input wire clk,
    input wire reset,
	input [31:0] freq,
    input [9:0] duty,
    output reg PWM
);
    wire [31:0] count_max = 32'd100_000_000 / freq;
    wire [31:0] count_duty = count_max * duty / 32'd1024;
    reg [31:0] count;
        
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            count <= 32'b0;
            PWM <= 1'b0;
        end else if (count < count_max) begin
            count <= count + 32'd1;
            if(count < count_duty)
                PWM <= 1'b1;
            else
                PWM <= 1'b0;
        end else begin
            count <= 32'b0;
            PWM <= 1'b0;
        end
    end
endmodule

