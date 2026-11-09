`timescale 1ns/1ps
module sequence_detector_tb;
reg clk, reset, din;
wire detected;

sequence_detector uut(clk, reset, din, detected);

always #5 clk = ~clk;

initial begin
    clk=0; reset=1; din=0;
    #10 reset=0;
    #10 din=1;
    #10 din=0;
    #10 din=1;
    #10 din=1;
    #20;
    $finish;
end

initial
    $monitor("Time=%0t din=%b detected=%b",
             $time,din,detected);
endmodule
