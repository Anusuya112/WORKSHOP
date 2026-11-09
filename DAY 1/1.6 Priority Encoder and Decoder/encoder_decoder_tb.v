`timescale 1ns/1ps
module encoder_decoder_tb;
    reg [7:0] in; reg [2:0] code_in; reg enable;
    wire [2:0] code1,code2; wire valid1,valid2; wire [7:0] decoded;
    integer i,pass_count,fail_count;
    priority_encoder_casez e1(.in(in),.code(code1),.valid(valid1));
    priority_encoder_if e2(.in(in),.code(code2),.valid(valid2));
    decoder3to8 d1(.code(code_in),.enable(enable),.out(decoded));
    initial begin
        pass_count=0; fail_count=0; in=0; code_in=0; enable=0;
        for(i=0;i<9;i=i+1) begin
            #5;
            case(i)
                0: in=0; 1: in=1; 2: in=2; 3: in=4; 4: in=8;
                5: in=16; 6: in=32; 7: in=64; 8: in=8'h81;
            endcase
            #5;
            if(code1===code2 && valid1===valid2) pass_count=pass_count+1; else fail_count=fail_count+1;
        end
        for(i=0;i<8;i=i+1) begin
            code_in=i; enable=1; #5;
            if(decoded===(8'b1<<i)) pass_count=pass_count+1; else fail_count=fail_count+1;
        end
        enable=0; #5;
        if(decoded===0) pass_count=pass_count+1; else fail_count=fail_count+1;
        $display("ENCODER/DECODER SUMMARY: PASS=%0d FAIL=%0d",pass_count,fail_count); $finish;
    end
endmodule
