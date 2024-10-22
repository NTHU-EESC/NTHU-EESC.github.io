`timescale 1ns / 1ps

module Lab2_111060013_Carry_Look_Ahead_Adder_8bit_t;
    reg [7:0] a = 8'b00000000;
    reg [7:0] b = 8'b00000000;
    reg c0 = 1'b0;
    wire [7:0] s;
    wire c8;
    reg err, tmpc8;
    reg [7:0] tmps;

    Carry_Look_Ahead_Adder_8bit CLAA8(
        .a(a),
        .b(b),
        .c0(c0),
        .s(s),
        .c8(c8)
    );

    always @(*) begin
        {tmpc8, tmps} = a + b + c0;
        if (tmpc8 == c8 && tmps == s) err = 1'b0;
        else err = 1'b1; 
    end

    initial begin
        a = 8'b00000000;
        repeat (2 ** 8) begin
            b = 8'b00000000;
            repeat (2 ** 8) begin
                c0 = 1'b0;
                repeat (2) begin
                    #1 c0 = c0 + 1'b1;
                end
                b = b + 8'b00000001;
            end
            a = a + 8'b00000001;
        end
        #1 $finish;
    end

endmodule
