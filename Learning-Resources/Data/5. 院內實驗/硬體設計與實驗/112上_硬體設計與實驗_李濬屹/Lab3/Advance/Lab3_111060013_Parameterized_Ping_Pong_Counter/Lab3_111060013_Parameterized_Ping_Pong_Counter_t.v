`timescale 1ns / 1ps

module Lab3_111060013_Parameterized_Ping_Pong_Counter_t;

reg clk = 1'b1;
reg rst_n = 1'b1;
reg enable = 1'b1;
reg flip = 1'b0;
reg [3:0]max = 4'b1000;
reg [3:0]min = 4'b0000;
wire direction;
wire [3:0] out;

always #1 clk = !clk;

Parameterized_Ping_Pong_Counter P(
    .clk(clk),
    .rst_n(rst_n),
    .enable(enable),
    .flip(flip),
    .max(max),
    .min(min),
    .direction(direction),
    .out(out)
);


initial begin
    #1 rst_n <= 1'b0;
       max <= 4'b0111;
       min <= 4'b0100;
    #2 rst_n <= 1'b1;
       enable <= 1'b1;
       flip <= 1'b0;
    #6
        max = 4'b1111;
        min = 4'b0111;
    #(2)
        @(negedge clk)flip = 1'b1;
        @(negedge clk)flip = 1'b0;
    #(5)
    #(2)
    //enable = 0
    repeat(2*4) @(posedge clk)enable = 1'b0;
    enable = 1'b1;
    #(3)
    //max < min
    max = 4'b0001;
    min = 4'b1100;
    #(5)
    
    max = 4'b1001;
    min = 4'b0010;
    #(2)
    max = 4'b1001;
    min = 4'b0000;
    #(4)
    @(negedge clk)flip = 1'b1;
    @(negedge clk)flip = 1'b0;
    #(4)
    // out < min
    max = 4'b1110;
    min = 4'b1100;
    #(5)
    // out > max
    max = 4'b1000;
    min = 4'b0010;
    #(5)
	#1 $finish;
end

/*
    reg clk = 1'b1;
    reg rst_n = 1'b1;
    reg enable;
    reg flip;
    reg [4-1:0] max;
    reg [4-1:0] min;
    wire direction;
    wire [4-1:0] out;

    Parameterized_Ping_Pong_Counter PPPC(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .flip(flip),
        .max(max),
        .min(min),
        .direction(direction),
        .out(out)
    );

    always # (1) clk = ~clk;

    initial begin
        #1 rst_n <= 1'b0;
           max <= 4'b1111;
           min <= 4'b0100;
        #2 rst_n <= 1'b1;
           enable <= 1'b1;
           flip <= 1'b0;
        #50 flip <= 1'b1;
        #6 flip <= 1'b0;
        #23 max <= 4'b1110;
            min <= 4'b1110;
        #24 enable <= 1'b0;
        #4 $finish; 
    end
*/
endmodule



/*
module Lab3_Team30_Parameterized_Ping_Pong_Counter_t();
reg clk = 1'b1;
reg rst_n = 1'b1;
reg enable = 1'b1;
reg flip = 1'b0;
reg [3:0]max = 4'b1000;
reg [3:0]min = 4'b0000;
wire direction;
wire [3:0] out;

parameter cyc = 10;

always#(cyc/2)clk = !clk;
Parameterized_Ping_Pong_Counter Pppc(
    .clk(clk),
    .rst_n(rst_n),
    .enable(enable),
    .flip(flip),
    .max(max),
    .min(min),
    .direction(direction),
    .out(out)
);


initial begin
    @(negedge clk) rst_n = 1'b0;
    @(negedge clk) 
    rst_n = 1'b1;
    max = 4'b0100;
    min = 4'b0000;
    #(cyc*5)
    @(negedge clk)flip = 1'b1;
    @(negedge clk)flip = 1'b0;
    #(cyc/2)
    #(cyc*2)
    //enable = 0
    repeat(2*4) @(posedge clk)enable = 1'b0;
    enable = 1'b1;
    #(cyc*3)
    //max < min
    max = 4'b0001;
    min = 4'b1000;
    #(cyc*5)
    
    max = 4'b1111;
    min = 4'b0000;
    #(cyc*12)
    // out < min
    max = 4'b1110;
    min = 4'b1100;
    #(cyc*5)
    // out > max
    max = 4'b1000;
    min = 4'b0010;
    #(cyc*5)
    @(negedge clk)flip = 1'b1;
    @(negedge clk)flip = 1'b0;
    #(cyc*11/2)
    #(cyc/2*5)
    @(negedge clk)flip = 1'b1;
    @(negedge clk)flip = 1'b0;
    #(cyc)
    @(negedge clk)flip = 1'b1;
    @(negedge clk)flip = 1'b0;
    #(cyc*5/2)
    enable = 1'b0;
    #(cyc*3)
    enable = 1'b1;
    min = 4'b0000;
    max = 4'b1111;
	#1 $finish;
end
endmodule
*/