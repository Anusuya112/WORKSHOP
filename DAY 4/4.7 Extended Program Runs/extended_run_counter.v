module extended_run_counter(
    input clk, reset, enable,
    output reg [63:0] count
);
    always @(posedge clk or posedge reset) begin
        if(reset)
            count <= 0;
        else if(enable)
            count <= count + 1;
    end
endmodule
