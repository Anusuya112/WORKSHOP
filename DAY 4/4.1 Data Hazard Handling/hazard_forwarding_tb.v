`timescale 1ns/1ps
module hazard_forwarding_tb;
reg [4:0] rs1,rs2,ex_rd,mem_rd;
reg ex_regwrite,mem_regwrite;
wire [1:0] forward_a,forward_b;
wire stall;

hazard_forwarding uut(
    rs1,rs2,ex_rd,mem_rd,
    ex_regwrite,mem_regwrite,
    forward_a,forward_b,stall
);

initial begin
    rs1=1; rs2=2; ex_rd=1; mem_rd=2;
    ex_regwrite=1; mem_regwrite=1;
    #10 ex_rd=3; mem_rd=1;
    #10 ex_rd=2; mem_rd=4;
    #10 ex_regwrite=0; mem_regwrite=0;
    #20 $finish;
end

initial
    $monitor("Time=%0t forward_a=%b forward_b=%b stall=%b",
             $time,forward_a,forward_b,stall);
endmodule
