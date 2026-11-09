`timescale 1ns/1ps
module pipeline_demo_monitor_tb;
reg clk;
reg [31:0] pc, instruction;
reg stall, flush;

pipeline_demo_monitor uut(clk,pc,stall,flush,instruction);

always #5 clk=~clk;

initial begin
    clk=0; pc=0; instruction=0;
    stall=0; flush=0;
    #10 pc=4; instruction=32'h00100093;
    #10 pc=8; instruction=32'h00208133;
    #10 stall=1;
    #10 stall=0; flush=1;
    #10 flush=0; pc=12; instruction=32'h003101B3;
    #20 $finish;
end
endmodule
