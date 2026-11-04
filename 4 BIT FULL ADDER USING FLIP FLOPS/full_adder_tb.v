module full_adder_tb;

reg clk, rst;
reg [3:0] A, B;
reg Cin;

wire [3:0] Sum;
wire Cout;

full_adder uut (
    .clk(clk),
    .rst(rst),
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $monitor("Time=%0t A=%b B=%b Cin=%b Sum=%b Cout=%b",
             $time, A, B, Cin, Sum, Cout);

    rst = 1;
    A = 4'b0000;
    B = 4'b0000;
    Cin = 0;

    #10 rst = 0;

    A = 4'b0011;
    B = 4'b0010;
    Cin = 0;
    #10;

    A = 4'b0101;
    B = 4'b0011;
    Cin = 1;
    #10;

    A = 4'b1111;
    B = 4'b0001;
    Cin = 0;
    #10;

    $finish;
end

endmodule
