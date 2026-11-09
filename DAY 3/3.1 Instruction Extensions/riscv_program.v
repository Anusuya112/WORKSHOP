module riscv_program(
    input clk, reset,
    output reg [31:0] result
);
    reg [31:0] regfile [0:7];

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            regfile[1] <= 10;
            regfile[2] <= 20;
            regfile[3] <= 0;
            result <= 0;
        end else begin
            regfile[3] <= regfile[1] + regfile[2];
            result <= regfile[3];
        end
    end
endmodule
