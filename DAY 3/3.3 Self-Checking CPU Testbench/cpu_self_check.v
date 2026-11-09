module cpu_self_check(
    input clk, reset,
    input [31:0] actual,
    input [31:0] expected,
    output reg error
);
    always @(posedge clk or posedge reset) begin
        if(reset)
            error <= 0;
        else
            error <= (actual != expected);
    end
endmodule
