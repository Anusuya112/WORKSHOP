`timescale 1ns/1ps

module full_adder4_tb;

reg  [3:0] A;
reg  [3:0] B;
reg        Cin;

wire [3:0] Sum;
wire       Cout;

full_adder4 uut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
);

initial begin

    $display("==============================================");
    $display("       4-BIT FULL ADDER SIMULATION");
    $display("==============================================");
    $display("Time   A      B      Cin    Sum    Cout");
    $display("----------------------------------------------");

    $monitor("%4t   %b   %b    %b      %b     %b",
             $time, A, B, Cin, Sum, Cout);

    // Test 1: 5 + 3 + 0 = 8
    A = 4'b0101;
    B = 4'b0011;
    Cin = 1'b0;
    #20;

    // Test 2: 15 + 1 + 0 = 16 (carry)
    A = 4'b1111;
    B = 4'b0001;
    Cin = 1'b0;
    #20;

    // Test 3: 5 + 3 + 1 = 9
    A = 4'b0101;
    B = 4'b0011;
    Cin = 1'b1;
    #20;

    // Test 4: 7 + 8 + 1 = 16 (carry)
    A = 4'b0111;
    B = 4'b1000;
    Cin = 1'b1;
    #20;

    // Test 5: 2 + 4 + 0 = 6
    A = 4'b0010;
    B = 4'b0100;
    Cin = 1'b0;
    #20;

    // Test 6: 15 + 15 + 1 = 31 (carry)
    A = 4'b1111;
    B = 4'b1111;
    Cin = 1'b1;
    #20;

    $display("==============================================");
    $display("        SIMULATION COMPLETED");
    $display("==============================================");

    $finish;

end

endmodule
