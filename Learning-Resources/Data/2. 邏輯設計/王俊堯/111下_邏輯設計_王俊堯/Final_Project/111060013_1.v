`timescale 1ns/1ps

module Functional_Unit(instruction, A, B, F);
    input wire [2:0] instruction;
    input wire [7:0] A;
    input wire [7:0] B;
    output [7:0] F;
	reg [7:0] F, tmp;

    //TODO: write your design below
    //You can define F as 'reg' or 'wire'
	always@(instruction or A or B) begin
		case (instruction)
			3'b000:
				F = A + B;
			3'b001:
				F = A + (~B);
			3'b010:
				F = A & B;
			3'b011:
				F = A | B;
			3'b100:
				F = A ^ B;
			3'b101:
				F = A / 2 + B;
			3'b110: begin
				tmp = A[0];
				F = A / 2;
				F[7] = tmp;
				F = F + B;
			end
			3'b111: begin
				tmp = A[7];
				F = A * 2;
				F[0] = tmp;
				F = F + B;
			end
			default:
				F = 0;
		endcase
	end

endmodule