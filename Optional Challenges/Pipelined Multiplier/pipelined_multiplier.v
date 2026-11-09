// ============================================================
// BONUS CHALLENGE 5 - PIPELINED MULTIPLIER
// FILE 7: pipelined_multiplier.v
// ============================================================

module pipelined_multiplier (
    input wire clk,
    input wire rst,
    input wire valid_in,
    input wire [7:0] a,
    input wire [7:0] b,
    output reg valid_out,
    output reg [15:0] product
);

    // Stage 1: Partial products
    reg [7:0] pp0, pp1, pp2, pp3;
    reg valid_stage1;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pp0 <= 0;
            pp1 <= 0;
            pp2 <= 0;
            pp3 <= 0;
            valid_stage1 <= 0;
            product <= 0;
            valid_out <= 0;
        end
        else begin

            valid_stage1 <= valid_in;

            if (valid_in) begin
                pp0 <= a[3:0] * b[3:0];
                pp1 <= a[7:4] * b[3:0];
                pp2 <= a[3:0] * b[7:4];
                pp3 <= a[7:4] * b[7:4];
            end

            // Stage 2: Add partial products
            valid_out <= valid_stage1;

            if (valid_stage1) begin
                product <=
                    {8'b0, pp0} +
                    ({8'b0, pp1} << 4) +
                    ({8'b0, pp2} << 4) +
                    ({8'b0, pp3} << 8);
            end
        end
    end

endmodule
