`timescale 1ns/1ps
module barrel_shifter_tb;
    reg [31:0] data_in; reg [4:0] shamt; reg [1:0] mode;
    wire [31:0] data_out; integer pass_count, fail_count;
    barrel_shifter32 dut(.data_in(data_in),.shamt(shamt),.mode(mode),.data_out(data_out));
    task check;
        input [31:0] d, expected; input [4:0] s; input [1:0] m;
        begin
            data_in=d; shamt=s; mode=m; #10;
            if(data_out===expected) begin $display("PASS mode=%b shift=%0d out=%h",m,s,data_out); pass_count=pass_count+1; end
            else begin $display("FAIL mode=%b shift=%0d expected=%h got=%h",m,s,expected,data_out); fail_count=fail_count+1; end
        end
    endtask
    initial begin
        pass_count=0; fail_count=0;
        check(32'h00000001,32'h00000001,0,0);
        check(32'h00000001,32'h00000010,4,0);
        check(32'h80000001,32'h80000000,31,0);
        check(32'h80000000,32'h40000000,1,1);
        check(32'h80000000,32'h00000001,31,1);
        check(32'hffffffff,32'h0fffffff,4,1);
        check(32'h80000000,32'hc0000000,1,2);
        check(32'h80000000,32'hffffffff,31,2);
        check(32'h7fffffff,32'h3fffffff,1,2);
        check(32'h12345678,32'h12345678,0,1);
        $display("SHIFTER SUMMARY: PASS=%0d FAIL=%0d",pass_count,fail_count); $finish;
    end
endmodule
