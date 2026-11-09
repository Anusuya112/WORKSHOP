`timescale 1ns/1ps
module riscv_branch_tb;
reg [31:0] a,b;
reg [2:0] funct3;
reg branch;
wire take_branch;

riscv_branch uut(a,b,funct3,branch,take_branch);

initial begin
    a=10; b=10; branch=1;
    funct3=3'b000; #10;
    funct3=3'b001; #10;
    a=5; b=10;
    funct3=3'b100; #10;
    funct3=3'b101; #10;
    funct3=3'b110; #10;
    funct3=3'b111; #10;
    branch=0; #10;
    $finish;
end

initial
    $monitor("Time=%0t a=%d b=%d funct3=%b take_branch=%b",
             $time,a,b,funct3,take_branch);
endmodule
