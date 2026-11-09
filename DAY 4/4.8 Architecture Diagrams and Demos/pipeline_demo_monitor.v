module pipeline_demo_monitor(
    input clk,
    input [31:0] pc,
    input stall, flush,
    input [31:0] instruction
);
    always @(posedge clk) begin
        $display("Time=%0t PC=%h Instruction=%h Stall=%b Flush=%b",
                 $time, pc, instruction, stall, flush);
    end
endmodule
