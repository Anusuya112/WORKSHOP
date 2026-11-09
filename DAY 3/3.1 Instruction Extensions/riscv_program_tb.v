`timescale 1ns/1ps
module riscv_program_tb;
reg clk, reset;
wire [31:0] result;

riscv_program uut(clk,reset,result);

always #5 clk=~clk;

initial begin
    clk=0; reset=1;
    #10 reset=0;
    #50 $finish;
end

initial
    $monitor("Time=%0t result=%d",$time,result);
endmodule
