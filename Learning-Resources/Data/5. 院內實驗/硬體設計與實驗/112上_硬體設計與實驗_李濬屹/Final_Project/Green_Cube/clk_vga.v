module clk_vga(rst, clk, dclk, dclk_x);
    input rst, clk;
    output wire dclk;
    output wire dclk_x;
    reg [18:0] counter;

    assign dclk = counter[17:0] == 18'd0;
    assign dclk_x = counter == 19'd0;

    always @ (posedge clk) begin
        if (rst) counter <= 19'd0;
        else counter <= counter + 19'd1;
    end

endmodule