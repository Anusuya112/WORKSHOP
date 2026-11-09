module waveform_monitor(
    input clk,
    input [31:0] pc,
    input [31:0] instruction,
    input [31:0] result
);
    always @(posedge clk) begin
        $display("Time=%0t PC=%h Instruction=%h Result=%h",
                 $time, pc, instruction, result);
    end
endmodule
