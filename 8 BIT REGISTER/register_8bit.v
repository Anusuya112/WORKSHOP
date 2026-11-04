module register_8bit(
    input clk,
    input rst,
    input [7:0] data_in,
    output reg [7:0] data_out
);

always @(posedge clk)
begin
    if (rst)
        data_out <= 8'b00000000;
    else
        data_out <= data_in;
end

endmodule
