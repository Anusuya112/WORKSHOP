`timescale 1ns/1ps
module input_conditioning_tb;
    reg clk,reset,async_in,signal_in,noisy_in;
    wire sync_out,pulse,clean_out;
    integer pass_count,fail_count;
    synchronizer2 s1(.clk(clk),.reset(reset),.async_in(async_in),.sync_out(sync_out));
    rising_edge_detector e1(.clk(clk),.reset(reset),.signal_in(signal_in),.pulse(pulse));
    debouncer #(.COUNT_MAX(3),.WIDTH(2)) d1(.clk(clk),.reset(reset),.noisy_in(noisy_in),.clean_out(clean_out));
    always #5 clk=~clk;
    initial begin
        clk=0; reset=1; async_in=0; signal_in=0; noisy_in=0; pass_count=0; fail_count=0;
        repeat(2) @(posedge clk); @(negedge clk); reset=0; async_in=1; signal_in=1;
        @(posedge clk); #1; if(sync_out==0 && pulse==1) pass_count=pass_count+1; else fail_count=fail_count+1;
        @(posedge clk); #1; if(sync_out==1 && pulse==0) pass_count=pass_count+1; else fail_count=fail_count+1;
        @(negedge clk); signal_in=0; noisy_in=1;
        @(posedge clk); #1; if(pulse==0) pass_count=pass_count+1; else fail_count=fail_count+1;
        repeat(3) @(posedge clk); #1;
        if(clean_out==1) pass_count=pass_count+1; else fail_count=fail_count+1;
        $display("INPUT CONDITIONING SUMMARY: PASS=%0d FAIL=%0d",pass_count,fail_count); $finish;
    end
endmodule
