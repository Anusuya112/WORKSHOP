`timescale 1ns/1ps
module pipeline_statistics_tb;
reg clk, reset, stall, flush, valid;
wire [31:0] stall_count,flush_count,instruction_count;

pipeline_statistics uut(
    clk,reset,stall,flush,valid,
    stall_count,flush_count,instruction_count
);

always #5 clk=~clk;

initial begin
    clk=0; reset=1;
    stall=0; flush=0; valid=0;
    #10 reset=0;
    #10 valid=1;
    #10 valid=0; stall=1;
    #10 stall=0; flush=1;
    #10 flush=0; valid=1;
    #20 $finish;
end

initial
    $monitor("Time=%0t stalls=%d flushes=%d instructions=%d",
             $time,stall_count,flush_count,instruction_count);
endmodule
