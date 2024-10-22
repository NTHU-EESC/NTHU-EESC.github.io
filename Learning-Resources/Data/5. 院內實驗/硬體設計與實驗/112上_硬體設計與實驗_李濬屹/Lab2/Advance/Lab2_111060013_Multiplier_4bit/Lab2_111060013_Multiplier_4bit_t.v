`timescale 1ns / 1ps

module Lab2_111060013_Multiplier_4bit_t;
    reg [3:0] a = 4'b0000;
    reg [3:0] b = 4'b0000;
    wire [7:0] out;
    reg err = 1'b0;
    reg [7:0] tmp;

    Multiplier_4bit M(
        .a(a),
        .b(b),
        .p(out)
    );
    
    always @(*) begin
        tmp = a * b;
        if (out != tmp) err = 1'b1;
        else err = 1'b0;
    end

    initial begin
        a = 4'b0000;
        repeat (16) begin
            b = 4'b0000;
            repeat (16) begin
                #1 b = b + 4'b0001;
            end
            a = a + 4'b0001;
        end
        #1 $finish;
    end

endmodule
