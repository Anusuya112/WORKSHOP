`timescale 1ns/1ps
module vending_machine_tb;
reg clk, reset;
reg [1:0] coin;
wire dispense;
wire [1:0] change;

vending_machine uut(clk,reset,coin,dispense,change);

always #5 clk=~clk;

initial begin
    clk=0; reset=1; coin=0;
    #10 reset=0;
    #10 coin=2'b01;
    #10 coin=2'b01;
    #10 coin=2'b01;
    #10 coin=0;
    #20 $finish;
end

initial
    $monitor("Time=%0t coin=%b dispense=%b change=%d",
             $time,coin,dispense,change);
endmodule
