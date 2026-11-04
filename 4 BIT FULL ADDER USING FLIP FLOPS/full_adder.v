module full_adder (
    input clk,
    input rst,
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output reg [3:0] Sum,
    output reg Cout
);

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        Sum <= 4'b0000;
        Cout <= 1'b0;
    end
    else
    begin
        {Cout, Sum} <= A + B + Cin;
    end
end

endmodule
