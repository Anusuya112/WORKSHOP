`timescale 1ns/1ps
module fsm_design_tb;
reg clk, reset, start;
wire busy, done;

fsm_design uut(clk,reset,start,busy,done);

always #5 clk=~clk;

initial begin
    clk=0; reset=1; start=0;
    #10 reset=0;
    #10 start=1;
    #10 start=0;
    #50 $finish;
end

initial
    $monitor("Time=%0t start=%b busy=%b done=%b",
             $time,start,busy,done);
endmodule
