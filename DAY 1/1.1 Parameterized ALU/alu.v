`timescale 1ns/1ps

module alu #(parameter WIDTH = 32) (
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    input  [2:0] opcode,
    output reg [WIDTH-1:0] result,
    output reg zero,
    output reg negative,
    output reg carry,
    output reg overflow
);

reg [WIDTH:0] temp;

always @(*) begin

    result = 0;
    carry = 0;
    overflow = 0;
    temp = 0;

    case (opcode)

        3'b000: begin
            // ADD
            temp = {1'b0,A} + {1'b0,B};
            result = temp[WIDTH-1:0];
            carry = temp[WIDTH];

            overflow = (~(A[WIDTH-1] ^ B[WIDTH-1])) &
                       (result[WIDTH-1] ^ A[WIDTH-1]);
        end

        3'b001: begin
            // SUBTRACT
            temp = {1'b0,A} + {1'b0,~B} + 1'b1;
            result = temp[WIDTH-1:0];
            carry = temp[WIDTH];

            overflow = (A[WIDTH-1] ^ B[WIDTH-1]) &
                       (result[WIDTH-1] ^ A[WIDTH-1]);
        end

        3'b010: begin
            // AND
            result = A & B;
        end

        3'b011: begin
            // OR
            result = A | B;
        end

        3'b100: begin
            // XOR
            result = A ^ B;
        end

        3'b101: begin
            // SLT - signed comparison
            result = ($signed(A) < $signed(B)) ? 1 : 0;
        end

        3'b110: begin
            // SHIFT LEFT LOGICAL
            result = A << B[4:0];
        end

        3'b111: begin
            // SHIFT RIGHT LOGICAL
            result = A >> B[4:0];
        end

        default: begin
            result = 0;
            carry = 0;
            overflow = 0;
        end

    endcase

    // ZERO FLAG
    if (result == 0)
        zero = 1;
    else
        zero = 0;

    // NEGATIVE FLAG
    negative = result[WIDTH-1];

end

endmodule
