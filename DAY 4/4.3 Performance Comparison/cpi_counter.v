module cpi_counter(
    input clk, reset,
    input instruction_done,
    output reg [31:0] cycles,
    output reg [31:0] instructions
);
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            cycles <= 0;
            instructions <= 0;
        end else begin
            cycles <= cycles + 1;
            if(instruction_done)
                instructions <= instructions + 1;
        end
    end
endmodule
