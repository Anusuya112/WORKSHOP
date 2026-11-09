`timescale 1ns/1ps
module adder_subtractor_tb;
    reg [7:0] A,B; reg sub; wire [7:0] result; wire carry_out;
    integer pass_count,fail_count; reg [8:0] expected;
    ripple_adder_subtractor8 dut(.A(A),.B(B),.sub(sub),.result(result),.carry_out(carry_out));
    task check;
        input [7:0] a,b; input s;
        begin
            A=a; B=b; sub=s; #10;
            if(!s) expected={1'b0,a}+{1'b0,b};
            else expected={1'b0,a}+{1'b0,~b}+9'd1;
            if({carry_out,result}===expected) begin $display("PASS A=%h B=%h sub=%b result=%h",a,b,s,result); pass_count=pass_count+1; end
            else begin $display("FAIL expected=%h got=%b%h",expected,carry_out,result); fail_count=fail_count+1; end
        end
    endtask
    initial begin
        pass_count=0; fail_count=0;
        check(10,5,0); check(255,1,0); check(0,0,0); check(100,55,0);
        check(20,5,1); check(5,20,1); check(0,1,1); check(255,255,1);
        check(128,127,0); check(200,100,0);
        $display("RIPPLE ADDER SUMMARY: PASS=%0d FAIL=%0d",pass_count,fail_count); $finish;
    end
endmodule
