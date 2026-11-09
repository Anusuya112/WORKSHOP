`timescale 1ns/1ps
module rv32_alu_tb;
reg [31:0] a,b;
reg [3:0] opcode;
wire [31:0] result;
wire zero;

rv32_alu uut(a,b,opcode,result,zero);

initial begin
    a=10; b=5;
    opcode=0; #10;
    opcode=1; #10;
    opcode=2; #10;
    opcode=3; #10;
    opcode=4; #10;
    opcode=5; #10;
    opcode=6; #10;
    opcode=7; #10;
    opcode=8; #10;
    $finish;
end

initial
    $monitor("Time=%0t opcode=%b result=%h zero=%b",
             $time,opcode,result,zero);
endmodule
