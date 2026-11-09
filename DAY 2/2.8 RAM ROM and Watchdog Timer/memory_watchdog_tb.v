`timescale 1ns/1ps
module memory_watchdog_tb;
reg clk, reset, write_en, refresh;
reg [3:0] address;
reg [7:0] data_in;
wire [7:0] data_out;
wire watchdog_expired;

memory_watchdog uut(
    clk,reset,write_en,refresh,address,data_in,
    data_out,watchdog_expired
);

always #5 clk=~clk;

initial begin
    clk=0; reset=1; write_en=0; refresh=0;
    address=0; data_in=0;
    #10 reset=0;
    #10 write_en=1; address=4; data_in=8'hAB;
    #10 write_en=0;
    #10 address=4;
    #10 refresh=1;
    #10 refresh=0;
    #150 $finish;
end

initial
    $monitor("Time=%0t address=%d data=%h watchdog=%b",
             $time,address,data_out,watchdog_expired);
endmodule
