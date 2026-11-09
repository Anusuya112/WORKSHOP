// ============================================================
// BONUS CHALLENGE 2 - EXTRA PIPELINE STAGE
// FILE 1: pipeline_6stage.v
// ============================================================

module pipeline_6stage (
    input wire clk,
    input wire rst,
    input wire valid_in,
    input wire [1:0] opcode,
    input wire [7:0] a,
    input wire [7:0] b,
    output reg valid_out,
    output reg [8:0] result
);

    reg v1, v2, v3, v4, v5;
    reg [1:0] op1, op2, op3, op4, op5;
    reg [7:0] a1, a2, a3, a4, a5;
    reg [7:0] b1, b2, b3, b4, b5;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            v1 <= 0;
            v2 <= 0;
            v3 <= 0;
            v4 <= 0;
            v5 <= 0;
            valid_out <= 0;
            result <= 0;
        end
        else begin
            v1 <= valid_in;
            if (valid_in) begin
                op1 <= opcode;
                a1 <= a;
                b1 <= b;
            end

            v2 <= v1;
            op2 <= op1;
            a2 <= a1;
            b2 <= b1;

            v3 <= v2;
            op3 <= op2;
            a3 <= a2;
            b3 <= b2;

            v4 <= v3;
            op4 <= op3;
            a4 <= a3;
            b4 <= b3;

            v5 <= v4;
            op5 <= op4;
            a5 <= a4;
            b5 <= b4;

            valid_out <= v5;

            if (v5) begin
                case (op5)
                    2'b00: result <= {1'b0,a5} + {1'b0,b5};
                    2'b01: result <= {1'b0,a5} - {1'b0,b5};
                    2'b10: result <= a5 & b5;
                    2'b11: result <= a5 | b5;
                endcase
            end
        end
    end

endmodule
