// ============================================================
// FILE 2: pipeline_6stage_tb.v
// ============================================================

`timescale 1ns/1ps

module pipeline_6stage_tb;

    reg clk, rst;
    reg valid_in;
    reg [1:0] opcode;
    reg [7:0] a, b;

    wire valid_out;
    wire [8:0] result;

    integer output_count;
    reg [8:0] expected [0:3];

    pipeline_6stage uut (
        .clk(clk),
        .rst(rst),
        .valid_in(valid_in),
        .opcode(opcode),
        .a(a),
        .b(b),
        .valid_out(valid_out),
        .result(result)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        #1;
        if (valid_out) begin
            $display("Pipeline Output = %d", result);

            if (result !== expected[output_count])
                $display("FAIL: Expected %d", expected[output_count]);
            else
                $display("PASS");

            output_count = output_count + 1;
        end
    end

    task send;
        input [1:0] op;
        input [7:0] x, y;
        begin
            @(negedge clk);
            valid_in = 1;
            opcode = op;
            a = x;
            b = y;
        end
    endtask

    initial begin
        clk = 0;
        rst = 1;
        valid_in = 0;
        opcode = 0;
        a = 0;
        b = 0;
        output_count = 0;

        expected[0] = 15;
        expected[1] = 20;
        expected[2] = 8;
        expected[3] = 15;

        #12;
        rst = 0;

        send(2'b00, 10, 5);
        send(2'b01, 25, 5);
        send(2'b10, 12, 10);
        send(2'b11, 8, 7);

        @(negedge clk);
        valid_in = 0;

        repeat (10) @(posedge clk);

        if (output_count == 4)
            $display("ALL PIPELINE TESTS COMPLETED");
        else
            $display("TEST FAILED: Received %0d outputs", output_count);

        $finish;
    end

endmodule
