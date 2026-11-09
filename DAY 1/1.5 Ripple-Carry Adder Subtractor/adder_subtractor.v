`timescale 1ns/1ps
module full_adder (
    input a,b,cin,
    output sum,cout
);
    assign {cout,sum} = a + b + cin;
endmodule

module ripple_adder_subtractor8 (
    input [7:0] A,B,
    input sub, // 0=addition, 1=subtraction
    output [7:0] result,
    output carry_out
);
    wire [7:0] bx;
    wire [8:0] c;
    assign bx = B ^ {8{sub}};
    assign c[0] = sub;
    genvar i;
    generate
        for(i=0;i<8;i=i+1) begin: FA_STAGE
            full_adder fa(.a(A[i]),.b(bx[i]),.cin(c[i]),.sum(result[i]),.cout(c[i+1]));
        end
    endgenerate
    assign carry_out=c[8];
endmodule
