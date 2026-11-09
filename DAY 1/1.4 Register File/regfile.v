`timescale 1ns/1ps
module regfile32x32 (
    input clk, we,
    input [4:0] ra1, ra2, wa,
    input [31:0] wd,
    output [31:0] rd1, rd2
);
    reg [31:0] regs [0:31];
    integer i;
    initial begin
        for(i=0;i<32;i=i+1) regs[i]=0;
    end
    always @(posedge clk) begin
        if(we && wa!=0) regs[wa] <= wd;
        regs[0] <= 32'b0;
    end
    // Same-cycle write-through bypass for either read port.
    assign rd1 = (ra1==0) ? 32'b0 : ((we && wa==ra1) ? wd : regs[ra1]);
    assign rd2 = (ra2==0) ? 32'b0 : ((we && wa==ra2) ? wd : regs[ra2]);
endmodule
