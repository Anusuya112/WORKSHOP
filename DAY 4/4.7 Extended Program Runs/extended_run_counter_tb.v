`timescale 1ns/1ps
module extended_run_counter_tb;
reg clk, reset, enable;
wire [63:0] count;

extended_run_counter uut(clk,reset,enable,count);

always #5 clk=~clk;

initial begin
    clk=0; reset=1; enable=0;
    #10 reset=0;
    #10 enable=1;
    #50 enable=0;
    #20 enable=1;
    #30 $finish;
end

initial
    $monitor("Time=%0t enable=%b count=%d",
             $time,enable,count);
endmodule
