module instruction_coverage(
    input clk, reset,
    input [3:0] opcode,
    output reg [15:0] coverage
);
    always @(posedge clk or posedge reset) begin
        if(reset)
            coverage <= 0;
        else
            coverage[opcode] <= 1'b1;
    end
endmodule
