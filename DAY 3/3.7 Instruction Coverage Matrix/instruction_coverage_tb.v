`timescale 1ns/1ps
module instruction_coverage_tb;
reg clk, reset;
reg [3:0] opcode;
wire [15:0] coverage;

instruction_coverage uut(clk,reset,opcode,coverage);

always #5 clk=~clk;

initial begin
    clk=0; reset=1; opcode=0;
    #10 reset=0;
    #10 opcode=1;
    #10 opcode=2;
    #10 opcode=4;
    #10 opcode=8;
    #20 $finish;
end

initial
    $monitor("Time=%0t opcode=%d coverage=%b",
             $time,opcode,coverage);
endmodule
