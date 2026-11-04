`timescale 1ns/1ps

module d_flipflop_tb;

reg clk, D;
wire Q;

d_flipflop uut(clk, D, Q);

// Clock generation
always #5 clk = ~clk;

// Apply inputs
initial
begin
    $dumpfile("d_flipflop.vcd");
    $dumpvars(0, d_flipflop_tb);

    clk = 0;
    D = 0;

    #10 D = 1;
    #10 D = 0;
    #10 D = 1;
    #10 D = 0;

    #10 $finish;
end

endmodule
