`timescale 1ns/1ps
module barrel_shifter32 (
    input [31:0] data_in,
    input [4:0] shamt,
    input [1:0] mode, // 00=LSL, 01=LSR, 10=ASR
    output reg [31:0] data_out
);
    always @(*) begin
        case(mode)
            2'b00: data_out = data_in << shamt;
            2'b01: data_out = data_in >> shamt;
            2'b10: data_out = $signed(data_in) >>> shamt;
            default: data_out = 32'b0;
        endcase
    end
endmodule
