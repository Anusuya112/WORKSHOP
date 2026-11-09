`timescale 1ns/1ps
module cpu_bug_detection_tb;
reg clk, reset;
reg [31:0] actual, expected;
wire bug_detected;

cpu_bug_detection uut(clk,reset,actual,expected,bug_detected);

always #5 clk=~clk;

initial begin
    clk=0; reset=1; actual=0; expected=0;
    #10 reset=0;
    #10 actual=100; expected=100;
    #10 actual=200; expected=150;
    #10 actual=300; expected=300;
    #20 $finish;
end

initial
    $monitor("Time=%0t actual=%d expected=%d bug=%b",
             $time,actual,expected,bug_detected);
endmodule
