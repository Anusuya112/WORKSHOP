module rv32_alu(
    input [31:0] a, b,
    input [3:0] opcode,
    output reg [31:0] result,
    output zero
);
    always @(*) begin
        case(opcode)
            4'b0000: result = a + b;
            4'b0001: result = a - b;
            4'b0010: result = a & b;
            4'b0011: result = a | b;
            4'b0100: result = a ^ b;
            4'b0101: result = a << b[4:0];
            4'b0110: result = a >> b[4:0];
            4'b0111: result = $signed(a) >>> b[4:0];
            4'b1000: result = ($signed(a) < $signed(b)) ? 1 : 0;
            default: result = 0;
        endcase
    end

    assign zero = (result == 0);
endmodule
