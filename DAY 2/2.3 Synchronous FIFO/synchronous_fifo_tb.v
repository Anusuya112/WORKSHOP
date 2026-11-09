`timescale 1ns/1ps
module synchronous_fifo_tb;
reg clk, reset, wr_en, rd_en;
reg [7:0] din;
wire [7:0] dout;
wire full, empty;

synchronous_fifo uut(clk,reset,wr_en,rd_en,din,dout,full,empty);

always #5 clk=~clk;

initial begin
    clk=0; reset=1; wr_en=0; rd_en=0; din=0;
    #10 reset=0;
    #10 wr_en=1; din=8'h11;
    #10 din=8'h22;
    #10 din=8'h33;
    #10 wr_en=0; rd_en=1;
    #30 rd_en=0;
    #20 $finish;
end

initial
    $monitor("Time=%0t din=%h dout=%h full=%b empty=%b",
             $time,din,dout,full,empty);
endmodule
