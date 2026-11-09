`timescale 1ns/1ps

module alu_tb;

reg [31:0] A, B;
reg [2:0] opcode;

wire [31:0] result;
wire zero, negative, carry, overflow;

integer pass_count, fail_count;

// DUT INSTANTIATION
alu uut (
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(result),
    .zero(zero),
    .negative(negative),
    .carry(carry),
    .overflow(overflow)
);

// CHECK TASK
task check;
    input [31:0] expected;
    input exp_zero, exp_negative, exp_carry, exp_overflow;
    begin
        #10;
        if ({result,zero,negative,carry,overflow} ===
            {expected,exp_zero,exp_negative,exp_carry,exp_overflow}) begin
            $display("PASS: OP=%b A=%h B=%h RESULT=%h",
                     opcode,A,B,result);
            pass_count = pass_count + 1;
        end
        else begin
            $display("FAIL: OP=%b A=%h B=%h RESULT=%h EXPECTED=%h",
                     opcode,A,B,result,expected);
            fail_count = fail_count + 1;
        end
    end
endtask

initial begin
    pass_count = 0;
    fail_count = 0;

    $monitor("TIME=%0t OP=%b A=%h B=%h RESULT=%h Z=%b N=%b C=%b V=%b",
             $time,opcode,A,B,result,zero,negative,carry,overflow);

    // 1-5: ADD
    opcode = 3'b000;
    A = 32'd5; B = 32'd3;
    check(32'd8,0,0,0,0);

    A = 32'hFFFFFFFF; B = 32'd1;
    check(32'h00000000,1,0,1,0);

    A = 32'h7FFFFFFF; B = 32'd1;
    check(32'h80000000,0,1,0,1);

    A = 32'd0; B = 32'd0;
    check(32'd0,1,0,0,0);

    A = 32'hFFFFFFFF; B = 32'd0;
    check(32'hFFFFFFFF,0,1,0,0);

    // 6-10: SUBTRACT
    opcode = 3'b001;
    A = 32'd9; B = 32'd4;
    check(32'd5,0,0,1,0);

    A = 32'd0; B = 32'd1;
    check(32'hFFFFFFFF,0,1,0,0);

    A = 32'h80000000; B = 32'd1;
    check(32'h7FFFFFFF,0,0,1,1);

    A = 32'd10; B = 32'd10;
    check(32'd0,1,0,1,0);

    A = 32'd5; B = 32'd7;
    check(32'hFFFFFFFE,0,1,0,0);

    // 11-13: AND
    opcode = 3'b010;
    A = 32'hF0F0F0F0; B = 32'h0FF00FF0;
    check(32'h00F000F0,0,0,0,0);

    A = 32'hAAAAAAAA; B = 32'h55555555;
    check(32'h00000000,1,0,0,0);

    A = 32'hFFFFFFFF; B = 32'h12345678;
    check(32'h12345678,0,0,0,0);

    // 14-16: OR
    opcode = 3'b011;
    A = 32'hF0000000; B = 32'h0000000F;
    check(32'hF000000F,0,1,0,0);

    A = 32'd0; B = 32'd0;
    check(32'd0,1,0,0,0);

    A = 32'h0F0F0000; B = 32'h0000F0F0;
    check(32'h0F0FF0F0,0,0,0,0);

    // 17-19: XOR
    opcode = 3'b100;
    A = 32'hAAAAAAAA; B = 32'h55555555;
    check(32'hFFFFFFFF,0,1,0,0);

    A = 32'h12345678; B = 32'h12345678;
    check(32'd0,1,0,0,0);

    A = 32'hFFFFFFFF; B = 32'h00000000;
    check(32'hFFFFFFFF,0,1,0,0);

    // 20-22: SLT
    opcode = 3'b101;
    A = 32'd3; B = 32'd5;
    check(32'd1,0,0,0,0);

    A = 32'hFFFFFFFF; B = 32'd1;
    check(32'd1,0,0,0,0);

    A = 32'd5; B = 32'd3;
    check(32'd0,1,0,0,0);

    // 23-24: SHIFT LEFT
    opcode = 3'b110;
    A = 32'd1; B = 32'd4;
    check(32'd16,0,0,0,0);

    A = 32'h80000001; B = 32'd1;
    check(32'd2,0,0,0,0);

    // 25-26: SHIFT RIGHT
    opcode = 3'b111;
    A = 32'h80000000; B = 32'd1;
    check(32'h40000000,0,0,0,0);

    A = 32'hFFFFFFFF; B = 32'd4;
    check(32'h0FFFFFFF,0,0,0,0);

    #10;
    $display("--------------------------------");
    $display("TOTAL PASS = %0d",pass_count);
    $display("TOTAL FAIL = %0d",fail_count);
    $display("--------------------------------");

    if (fail_count == 0)
        $display("ALL TESTS PASSED");
    else
        $display("SOME TESTS FAILED");

    $finish;
end

endmodule
