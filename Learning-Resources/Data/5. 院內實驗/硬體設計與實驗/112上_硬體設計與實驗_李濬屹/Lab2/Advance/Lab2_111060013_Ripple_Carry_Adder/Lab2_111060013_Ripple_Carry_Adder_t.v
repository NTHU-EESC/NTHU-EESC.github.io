`timescale 1ns / 1ps

module Lab2_111060013_Ripple_Carry_Adder_t;
    reg [7:0] a = 8'b00000000;
    reg [7:0] b = 8'b00000000;
    reg cin = 1'b0;
    wire [7:0] sum;
    wire cout;
    reg tmpc;
    reg [7:0] tmps;
    reg err = 1'b0;

    Ripple_Carry_Adder RCA(
        .a(a),
        .b(b),
        .cin(cin),
        .cout(cout),
        .sum(sum)
    );

    always @(*) begin
        {tmpc, tmps} = a + b + cin;
        if (tmpc == cout && tmps == sum) err = 1'b0;
        else err = 1'b1; 
    end

    initial begin
        a = 8'b00000000;
        repeat (2 ** 8) begin
            b = 8'b00000000;
            repeat (2 ** 8) begin
                cin = 1'b0;
                repeat (2) begin
                    #1 cin = cin + 1'b1;
                end
                b = b + 8'b00000001;
            end
            a = a + 8'b00000001;
        end
        #1 $finish;
    end
endmodule