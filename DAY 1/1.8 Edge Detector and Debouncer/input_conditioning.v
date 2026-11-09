`timescale 1ns/1ps
module synchronizer2 (
    input clk, reset, async_in,
    output reg sync_out
);
    reg stage1;
    always @(posedge clk) begin
        if(reset) begin stage1<=0; sync_out<=0; end
        else begin stage1<=async_in; sync_out<=stage1; end
    end
endmodule

module rising_edge_detector (
    input clk, reset, signal_in,
    output reg pulse
);
    reg previous;
    always @(posedge clk) begin
        if(reset) begin previous<=0; pulse<=0; end
        else begin pulse<=signal_in & ~previous; previous<=signal_in; end
    end
endmodule

module debouncer #(parameter COUNT_MAX=4, WIDTH=3) (
    input clk, reset, noisy_in,
    output reg clean_out
);
    reg [WIDTH-1:0] count;
    reg sample;
    always @(posedge clk) begin
        if(reset) begin count<=0; sample<=0; clean_out<=0; end
        else if(noisy_in==sample) count<=0;
        else if(count==COUNT_MAX-1) begin
            sample<=noisy_in;
            clean_out<=noisy_in;
            count<=0;
        end
        else count<=count+1'b1;
    end
endmodule
