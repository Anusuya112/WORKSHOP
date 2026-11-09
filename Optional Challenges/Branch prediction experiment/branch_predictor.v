// ============================================================
// BONUS CHALLENGE 4 - BRANCH PREDICTION
// FILE 5: branch_predictor.v
// ============================================================

module branch_predictor (
    input wire clk,
    input wire rst,
    input wire branch_valid,
    input wire actual_taken,
    output wire predicted_taken,
    output reg [7:0] total_branches,
    output reg [7:0] mispredictions
);

    // 2-bit saturating counter
    // 00 = Strongly Not Taken
    // 01 = Weakly Not Taken
    // 10 = Weakly Taken
    // 11 = Strongly Taken

    reg [1:0] state;

    assign predicted_taken = state[1];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 2'b01;
            total_branches <= 0;
            mispredictions <= 0;
        end
        else if (branch_valid) begin

            total_branches <= total_branches + 1;

            if (predicted_taken != actual_taken)
                mispredictions <= mispredictions + 1;

            if (actual_taken) begin
                if (state != 2'b11)
                    state <= state + 1;
            end
            else begin
                if (state != 2'b00)
                    state <= state - 1;
            end
        end
    end

endmodule
