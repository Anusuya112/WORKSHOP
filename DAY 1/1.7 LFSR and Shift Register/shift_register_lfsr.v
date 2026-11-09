`timescale 1ns/1ps
module universal_shift_register8 (
    input clk, reset,
    input [1:0] mode, // 00 hold, 01 shift right, 10 shift left, 11 parallel load
    input serial_in,
    input [7:0] parallel_in,
    output reg [7:0] q
);
    always @(posedge clk) begin
        if(reset) q<=0;
        else case(mode)
            2'b00: q<=q;
            2'b01: q<={serial_in,q[7:1]};
            2'b10: q<={q[6:0],serial_in};
            2'b11: q<=parallel_in;
        endcase
    end
endmodule

module lfsr8 (
    input clk, reset, enable,
    input [7:0] seed,
    output reg [7:0] q
);
    wire feedback;
    assign feedback = q[0] ^ q[2] ^ q[3] ^ q[4];
    always @(posedge clk) begin
        if(reset) q <= (seed==0) ? 8'h01 : seed;
        else if(enable) q <= {feedback,q[7:1]};
    end
endmodule
