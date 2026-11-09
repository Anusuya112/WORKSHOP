`timescale 1ns/1ps
module shift_register_lfsr_tb;
    reg clk,reset,serial_in; reg [1:0] mode; reg [7:0] parallel_in,seed;
    reg lfsr_enable; wire [7:0] q,lfsr_q;
    integer pass_count,fail_count;
    universal_shift_register8 u1(.clk(clk),.reset(reset),.mode(mode),.serial_in(serial_in),.parallel_in(parallel_in),.q(q));
    lfsr8 u2(.clk(clk),.reset(reset),.enable(lfsr_enable),.seed(seed),.q(lfsr_q));
    always #5 clk=~clk;
    task check_q; input [7:0] expected; begin @(posedge clk); #1;
        if(q===expected) pass_count=pass_count+1; else begin fail_count=fail_count+1; $display("SHIFT FAIL expected=%h got=%h",expected,q); end
    end endtask
    initial begin
        clk=0; reset=1; mode=0; serial_in=0; parallel_in=0; seed=8'hA5; lfsr_enable=0; pass_count=0; fail_count=0;
        @(posedge clk); #1; if(q==0 && lfsr_q==8'hA5) pass_count=pass_count+1; else fail_count=fail_count+1;
        @(negedge clk); reset=0; mode=3; parallel_in=8'h96; check_q(8'h96);
        @(negedge clk); mode=1; serial_in=1; check_q(8'hCB);
        @(negedge clk); mode=2; serial_in=0; check_q(8'h96);
        @(negedge clk); mode=0; check_q(8'h96);
        @(negedge clk); lfsr_enable=1; #1;
        repeat(10) @(posedge clk);
        #1; if(lfsr_q!=8'hA5 && lfsr_q!=0) pass_count=pass_count+1; else fail_count=fail_count+1;
        $display("SHIFT/LFSR SUMMARY: PASS=%0d FAIL=%0d",pass_count,fail_count); $finish;
    end
endmodule
