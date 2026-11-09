`timescale 1ns/1ps
module arithmetic_units_tb;
reg [31:0] a,b;
reg [1:0] select;
wire [31:0] result;

arithmetic_units uut(a,b,select,result);

initial begin
    a=20; b=5;
    select=0; #10;
    select=1; #10;
    select=2; #10;
    select=3; #10;
    b=0; select=3; #10;
    $finish;
end

initial
    $monitor("Time=%0t select=%b result=%d",
             $time,select,result);
endmodule
