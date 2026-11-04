module tb_register_8bit;

reg clk;
reg rst;
reg [7:0] data_in;
wire [7:0] data_out;

register_8bit uut(
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    data_in = 8'b00000000;

    #10 rst = 0;
    data_in = 8'b10101010;

    #10 data_in = 8'b11110000;

    #10 data_in = 8'b11001100;

    #10 data_in = 8'b00001111;

    #20 $finish;
end

endmodule
