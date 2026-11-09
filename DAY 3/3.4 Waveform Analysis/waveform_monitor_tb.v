`timescale 1ns/1ps
module waveform_monitor_tb;
reg clk;
reg [31:0] pc, instruction, result;

waveform_monitor uut(clk,pc,instruction,result);

always #5 clk=~clk;

initial begin
    clk=0; pc=0; instruction=0; result=0;
    #10 pc=4; instruction=32'h00100093; result=10;
    #10 pc=8; instruction=32'h00208133; result=20;
    #10 pc=12; instruction=32'h003101B3; result=30;
    #20 $finish;
end
endmodule
