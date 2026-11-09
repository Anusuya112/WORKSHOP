module riscv_branch(
    input [31:0] a, b,
    input [2:0] funct3,
    input branch,
    output reg take_branch
);
    always @(*) begin
        take_branch = 0;
        if(branch) begin
            case(funct3)
                3'b000: take_branch = (a == b);
                3'b001: take_branch = (a != b);
                3'b100: take_branch = ($signed(a) < $signed(b));
                3'b101: take_branch = ($signed(a) >= $signed(b));
                3'b110: take_branch = (a < b);
                3'b111: take_branch = (a >= b);
                default: take_branch = 0;
            endcase
        end
    end
endmodule
