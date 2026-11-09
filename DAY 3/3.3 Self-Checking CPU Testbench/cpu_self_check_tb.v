`timescale 1ns/1ps
module cpu_self_check_tb;
reg clk, reset;
reg [31:0] actual, expected;
wire error;

cpu_self_check uut(clk,reset,actual,expected,error);

always #5 clk=~clk;

initial begin
    clk=0; reset=1; actual=0; expected=0;
    #10 reset=0;
    #10 actual=10; expected=10;
    #10 actual=20; expected=10;
    #10 actual=30; expected=30;
    #20 $finish;
end

initial
    $monitor("Time=%0t actual=%d expected=%d error=%b",
             $time,actual,expected,error);
endmodule
