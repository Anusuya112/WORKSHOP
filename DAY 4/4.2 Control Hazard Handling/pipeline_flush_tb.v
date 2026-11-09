`timescale 1ns/1ps
module pipeline_flush_tb;
reg clk, reset, branch_taken;
wire flush;

pipeline_flush uut(clk,reset,branch_taken,flush);

always #5 clk=~clk;

initial begin
    clk=0; reset=1; branch_taken=0;
    #10 reset=0;
    #10 branch_taken=1;
    #10 branch_taken=0;
    #20 branch_taken=1;
    #10 branch_taken=0;
    #20 $finish;
end

initial
    $monitor("Time=%0t branch_taken=%b flush=%b",
             $time,branch_taken,flush);
endmodule
