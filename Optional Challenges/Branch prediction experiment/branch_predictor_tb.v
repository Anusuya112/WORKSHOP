// ============================================================
// FILE 6: branch_predictor_tb.v
// ============================================================

`timescale 1ns/1ps

module branch_predictor_tb;

    reg clk, rst;
    reg branch_valid;
    reg actual_taken;

    wire predicted_taken;
    wire [7:0] total_branches;
    wire [7:0] mispredictions;

    integer i;
    reg [6:0] branch_sequence;

    branch_predictor uut (
        .clk(clk),
        .rst(rst),
        .branch_valid(branch_valid),
        .actual_taken(actual_taken),
        .predicted_taken(predicted_taken),
        .total_branches(total_branches),
        .mispredictions(mispredictions)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        branch_valid = 0;
        actual_taken = 0;

        // Sequence: T, T, N, T, N, N, T
        branch_sequence = 7'b1101001;

        #12;
        rst = 0;

        for (i = 6; i >= 0; i = i - 1) begin
            @(negedge clk);

            actual_taken = branch_sequence[i];
            branch_valid = 1;

            $display("Actual = %b, Prediction = %b",
                     actual_taken, predicted_taken);

            @(posedge clk);
            #1;

            $display("Total Branches = %d, Mispredictions = %d",
                     total_branches, mispredictions);
        end

        @(negedge clk);
        branch_valid = 0;

        $display("-------------------------------");
        $display("BRANCH PREDICTION TEST COMPLETED");
        $display("Total Branches = %d", total_branches);
        $display("Mispredictions = %d", mispredictions);
        $display("-------------------------------");

        $finish;
    end

endmodule
