`timescale 1ns/1ps
module traffic_light_tb;
reg clk, reset;
wire [2:0] north, east;

traffic_light uut(clk,reset,north,east);

always #5 clk=~clk;

initial begin
    clk=0; reset=1;
    #10 reset=0;
    #500 $finish;
end

initial
    $monitor("Time=%0t North=%b East=%b",
             $time,north,east);
endmodule
