module cpu_bug_detection(
    input clk, reset,
    input [31:0] actual,
    input [31:0] expected,
    output reg bug_detected
);
    always @(posedge clk or posedge reset) begin
        if(reset)
            bug_detected <= 0;
        else
            bug_detected <= (actual != expected);
    end
endmodule
