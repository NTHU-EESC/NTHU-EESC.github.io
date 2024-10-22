`timescale 1ns / 1ps

module Lab2_111060013_Decode_And_Execute_t;
    reg [3:0] rs, rt;
    reg [2:0] sel;
    wire [3:0] rd;
    reg [3:0] tmp;
    reg err;

    Decode_And_Execute DAE(
        .rs(rs),
        .rt(rt),
        .sel(sel),
        .rd(rd)
    );

    initial begin
        err = 1'b0;
        rs = 4'b0000;
        repeat (16) begin
            rt = 4'b0000;
            repeat (16) begin
                sel = 3'b000;
                repeat (8) begin
                    if (sel == 3'b000) tmp = rs - rt;
                    else if (sel == 3'b001) tmp = rs + rt; 
                    else if (sel == 3'b010) tmp = rs | rt;
                    else if (sel == 3'b011) tmp = rs & rt;
                    else if (sel == 3'b100) tmp = {rt[3], rt[3:1]};
                    else if (sel == 3'b101) tmp = {rs[2:0], rs[3]};
                    else if (sel == 3'b110) tmp = {3'b101, rs < rt};
                    else tmp = {3'b111, rs == rt};
                    #1 err = tmp != rd;
                    #4 sel = sel + 3'b001;
                end
                rt = rt + 4'b0001;
            end
            rs = rs + 4'b0001;
        end

        #5 $finish;

    end

endmodule