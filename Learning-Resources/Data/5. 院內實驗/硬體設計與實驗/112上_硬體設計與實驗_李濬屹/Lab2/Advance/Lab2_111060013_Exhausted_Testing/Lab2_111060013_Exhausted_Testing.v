`timescale 1ns/1ps

module Exhausted_Testing(a, b, cin, error, done);
output [4-1:0] a, b;
output cin;
output error;
output done;

// input signal to the test instance.
reg [4-1:0] a = 4'b0000;
reg [4-1:0] b = 4'b0000;
reg cin = 1'b0;

// initial value for the done and error indicator: not done, no error
reg done = 1'b0;
reg error = 1'b0;


// output from the test instance.
wire [4-1:0] sum;
wire cout;

// instantiate the test instance.
Ripple_Carry_Adder rca(
    .a (a), 
    .b (b), 
    .cin (cin),
    .cout (cout),
    .sum (sum)
);

reg tmp_cout;
reg [3:0] tmp_sum;

initial begin
    repeat (2) begin
        repeat (16) begin
            repeat (16) begin
                {tmp_cout, tmp_sum} = a + b + cin;
                #1 error = (tmp_cout != cout) || (tmp_sum != sum);
                #4 b = b + 4'b0001;
            end
            a = a + 4'b0001;
        end
        cin = 1'b1;
    end

    done = 1'b1;
    #5 done = 1'b0;
    // design you test pattern here.
    // Remember to set the input pattern to the test instance every 5 nanasecond
    // Check the output and set the `error` signal accordingly 1 nanosecond after new input is set.
    // Also set the done signal to 1'b1 5 nanoseconds after the test is finished.
    // Example:
    // setting the input
    // a = 4'b0000;
    // b = 4'b0000;
    // cin = 1'b0;
    // check the output
    // #1
    // check_output;
    // #4
    // setting another input
    // a = 4'b0001;
    // b = 4'b0000;
    // cin = 1'b0;
    //.....
    // #4
    // The last input pattern
    // a = 4'b1111;
    // b = 4'b1111;
    // cin = 1'b1;
    // #1
    // check_output;
    // #4
    // setting the done signal
    // done = 1'b1;
end

endmodule
