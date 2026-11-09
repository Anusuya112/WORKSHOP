module hazard_forwarding(
    input [4:0] rs1, rs2,
    input [4:0] ex_rd, mem_rd,
    input ex_regwrite, mem_regwrite,
    output reg [1:0] forward_a, forward_b,
    output reg stall
);
    always @(*) begin
        forward_a = 0;
        forward_b = 0;
        stall = 0;

        if(ex_regwrite && ex_rd != 0 && ex_rd == rs1)
            forward_a = 2'b10;
        else if(mem_regwrite && mem_rd != 0 && mem_rd == rs1)
            forward_a = 2'b01;

        if(ex_regwrite && ex_rd != 0 && ex_rd == rs2)
            forward_b = 2'b10;
        else if(mem_regwrite && mem_rd != 0 && mem_rd == rs2)
            forward_b = 2'b01;
    end
endmodule
