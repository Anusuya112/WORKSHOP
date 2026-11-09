module pipeline_statistics(
    input clk, reset,
    input stall, flush, valid,
    output reg [31:0] stall_count,
    output reg [31:0] flush_count,
    output reg [31:0] instruction_count
);
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            stall_count <= 0;
            flush_count <= 0;
            instruction_count <= 0;
        end else begin
            if(stall)
                stall_count <= stall_count + 1;
            if(flush)
                flush_count <= flush_count + 1;
            if(valid)
                instruction_count <= instruction_count + 1;
        end
    end
endmodule
