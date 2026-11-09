`timescale 1ns/1ps
module cpi_counter_tb;
reg clk, reset, instruction_done;
wire [31:0] cycles,instructions;

cpi_counter uut(clk,reset,instruction_done,cycles,instructions);

always #5 clk=~clk;

initial begin
    clk=0; reset=1; instruction_done=0;
    #10 reset=0;
    #10 instruction_done=1;
    #10 instruction_done=0;
    #10 instruction_done=1;
    #10 instruction_done=1;
    #10 instruction_done=0;
    #20 $finish;
end

initial
    $monitor("Time=%0t cycles=%d instructions=%d",
             $time,cycles,instructions);
endmodule
