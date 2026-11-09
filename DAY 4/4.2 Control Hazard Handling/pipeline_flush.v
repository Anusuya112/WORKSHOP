module pipeline_flush(
    input clk, reset,
    input branch_taken,
    output reg flush
);
    always @(posedge clk or posedge reset) begin
        if(reset)
            flush <= 0;
        else
            flush <= branch_taken;
    end
endmodule
