// ============================================================
// FILE 8: pipelined_multiplier_tb.v
// ============================================================

`timescale 1ns/1ps

module pipelined_multiplier_tb;

    reg clk, rst;
    reg valid_in;
    reg [7:0] a, b;

    wire valid_out;
    wire [15:0] product;

    integer output_count;
    reg [15:0] expected [0:2];

    pipelined_multiplier uut (
        .clk(clk),
        .rst(rst),
        .valid_in(valid_in),
        .a(a),
        .b(b),
        .valid_out(valid_out),
        .product(product)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        #1;

        if (valid_out) begin
            $display("Product = %d", product);

            if (product !== expected[output_count])
                $display("FAIL: Expected %d", expected[output_count]);
            else
                $display("PASS");

            output_count = output_count + 1;
        end
    end

    initial begin
        clk = 0;
        rst = 1;
        valid_in = 0;
        a = 0;
        b = 0;
        output_count = 0;

        expected[0] = 200;
        expected[1] = 600;
        expected[2] = 65025;

        #12;
        rst = 0;

        // Input 1: 10 x 20 = 200
        @(negedge clk);
        valid_in = 1;
        a = 10;
        b = 20;

        // Input 2: 20 x 30 = 600
        @(negedge clk);
        a = 20;
        b = 30;

        // Input 3: 255 x 255 = 65025
        @(negedge clk);
        a = 255;
        b = 255;

        @(negedge clk);
        valid_in = 0;

        repeat (5) @(posedge clk);

        if (output_count == 3)
            $display("ALL MULTIPLIER TESTS COMPLETED");
        else
            $display("TEST FAILED: Received %0d outputs", output_count);

        $finish;
    end

endmodule
