`timescale 1ns/1ps
module atm_controller_tb;
reg clk, reset, request;
reg [7:0] balance, amount;
wire approved, denied;

atm_controller uut(clk,reset,request,balance,amount,approved,denied);

always #5 clk=~clk;

initial begin
    clk=0; reset=1; request=0;
    balance=100; amount=50;
    #10 reset=0;
    #10 request=1;
    #10 request=0;
    #20 amount=150; request=1;
    #10 request=0;
    #20 $finish;
end

initial
    $monitor("Time=%0t balance=%d amount=%d approved=%b denied=%b",
             $time,balance,amount,approved,denied);
endmodule
