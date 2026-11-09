`timescale 1ns/1ps
module counter_tb;
    reg clk, reset, enable, up_down, load;
    reg [7:0] load_data;
    wire [7:0] count;
    integer pass_count, fail_count;
    counter8 dut(.clk(clk),.reset(reset),.enable(enable),.up_down(up_down),
                 .load(load),.load_data(load_data),.count(count));
    always #5 clk=~clk;
    task check;
        input [7:0] expected;
        begin
            @(posedge clk); #1;
            if(count===expected) begin $display("PASS count=%h",count); pass_count=pass_count+1; end
            else begin $display("FAIL expected=%h got=%h",expected,count); fail_count=fail_count+1; end
        end
    endtask
    initial begin
        clk=0; reset=1; enable=0; up_down=1; load=0; load_data=0; pass_count=0; fail_count=0;
        check(0);
        @(negedge clk); reset=0; enable=1; up_down=1; check(1);
        @(negedge clk); check(2);
        @(negedge clk); up_down=0; check(1);
        @(negedge clk); enable=0; check(1);
        @(negedge clk); load=1; load_data=8'hFE; check(8'hFE);
        @(negedge clk); load=0; enable=1; up_down=1; check(8'hFF);
        @(negedge clk); check(8'h00);
        @(negedge clk); up_down=0; check(8'hFF);
        $display("COUNTER SUMMARY: PASS=%0d FAIL=%0d",pass_count,fail_count); $finish;
    end
endmodule
