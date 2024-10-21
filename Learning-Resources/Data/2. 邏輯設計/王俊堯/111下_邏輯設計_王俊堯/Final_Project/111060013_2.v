`timescale 1ns/1ps
module find_MAX(
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire valid,
    input wire [7:0] Data_A,
    input wire [7:0] Data_B,
    input wire one_left,
    input wire [2:0] instruction,
    output reg [7:0] maximum,
    output reg finish
);
    wire [7:0] result;

    // Functional_Unit instantiation
    Functional_Unit fu(
        .instruction(instruction), 
        .A(Data_A),
        .B(Data_B),
        .F(result)
    );

    //TODO: write your design below
    //You cannot modify anything above

	reg rst_flag, start_flag, last_flag;
	
	// main
	always@(posedge clk) begin
		// main
		if ((valid & rst_flag & start_flag & (~last_flag)) == 1) begin
			if (result > maximum) maximum <= result;
		end
		else;
		// start
		if ((rst_flag & start) == 1) begin
			last_flag <= 0;
			start_flag <= 1;
			maximum <= 0;
			finish <= 0;
		end
		else;
		// one left
		if ((rst_flag & start_flag & one_left) == 1) begin
			last_flag <= 1;
		end
		else;
		// finish
		if ((valid & rst_flag & start_flag & last_flag) == 1) begin
			if (result > maximum) maximum <= result;
			last_flag <= 0;
			start_flag <= 0;
			finish <= 1;
		end
		else;
		if (finish == 1) begin
			finish <= 0;
		end
		else;
	end

	// reset
	always@(negedge rst_n) begin
		rst_flag <= 1;
		start_flag <= 0;
		last_flag <= 0;
	end
endmodule