module arithmetic_units(
    input [31:0] a, b,
    input [1:0] select,
    output reg [31:0] result
);
    always @(*) begin
        case(select)
            2'b00: result = a + b;
            2'b01: result = a - b;
            2'b10: result = a * b;
            2'b11: result = (b != 0) ? a / b : 0;
            default: result = 0;
        endcase
    end
endmodule
