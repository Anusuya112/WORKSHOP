`timescale 1ns/1ps
module counter8 (
    input clk, reset, enable, up_down, load,
    input [7:0] load_data,
    output reg [7:0] count
);
    // Priority: synchronous reset, parallel load, then enabled count.
    // up_down=1: count up; up_down=0: count down.
    always @(posedge clk) begin
        if (reset)
            count <= 8'd0;
        else if (load)
            count <= load_data;
        else if (enable) begin
            if (up_down) count <= count + 1'b1;
            else         count <= count - 1'b1;
        end
    end
endmodule
