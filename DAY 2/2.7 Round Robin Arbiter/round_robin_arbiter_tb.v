`timescale 1ns/1ps
module round_robin_arbiter_tb;
reg clk, reset;
reg [3:0] request;
wire [3:0] grant;

round_robin_arbiter uut(clk,reset,request,grant);

always #5 clk=~clk;

initial begin
    clk=0; reset=1; request=0;
    #10 reset=0;
    #10 request=4'b1111;
    #50 request=4'b0101;
    #30 request=0;
    #20 $finish;
end

initial
    $monitor("Time=%0t request=%b grant=%b",
             $time,request,grant);
endmodule
