`timescale 1ns/1ps
module regfile_tb;
    reg clk,we; reg [4:0] ra1,ra2,wa; reg [31:0] wd;
    wire [31:0] rd1,rd2;
    reg [31:0] model [1:31];
    integer i,pass_count,fail_count,idx;
    reg [31:0] exp1,exp2;
    reg [31:0] seed;
    reg [4:0] r1,r2,w;
    reg [31:0] data;
    reg write_en;
    regfile32x32 dut(.clk(clk),.we(we),.ra1(ra1),.ra2(ra2),.wa(wa),.wd(wd),.rd1(rd1),.rd2(rd2));
    always #5 clk=~clk;
    task verify;
        begin
            #1;
            exp1=(ra1==0)?0:((we && wa==ra1)?wd:model[ra1]);
            exp2=(ra2==0)?0:((we && wa==ra2)?wd:model[ra2]);
            if(rd1===exp1 && rd2===exp2) pass_count=pass_count+1;
            else begin
                fail_count=fail_count+1;
                $display("FAIL read1 exp=%h got=%h read2 exp=%h got=%h",exp1,rd1,exp2,rd2);
            end
        end
    endtask
    initial begin
        clk=0; we=0; ra1=0; ra2=0; wa=0; wd=0; pass_count=0; fail_count=0; seed=32'h12345678;
        for(i=1;i<32;i=i+1) model[i]=0;
        // 200 reproducible pseudo-random read/write transactions.
        for(idx=0;idx<200;idx=idx+1) begin
            @(negedge clk);
            seed = seed * 32'd1664525 + 32'd1013904223;
            r1=seed[4:0]; r2=seed[9:5]; w=seed[14:10]; data=seed ^ idx;
            write_en=seed[15];
            ra1=r1; ra2=r2; wa=w; wd=data; we=write_en;
            verify();
            @(posedge clk);
            if(we && wa!=0) model[wa]=wd;
        end
        @(negedge clk); we=0; ra1=0; ra2=1; #1;
        if(rd1===0 && rd2===model[1]) pass_count=pass_count+1; else fail_count=fail_count+1;
        $display("REGFILE SUMMARY: PASS=%0d FAIL=%0d",pass_count,fail_count); $finish;
    end
endmodule
