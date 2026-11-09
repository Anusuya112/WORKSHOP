`timescale 1ns/1ps
module hazard_waveform_flags_tb;
reg clk, reset, data_hazard, control_hazard;
wire data_flag, control_flag;

hazard_waveform_flags uut(
    clk,reset,data_hazard,control_hazard,
    data_flag,control_flag
);

always #5 clk=~clk;

initial begin
    clk=0; reset=1;
    data_hazard=0; control_hazard=0;
    #10 reset=0;
    #10 data_hazard=1;
    #10 data_hazard=0; control_hazard=1;
    #10 control_hazard=0;
    #20 $finish;
end

initial
    $monitor("Time=%0t data_flag=%b control_flag=%b",
             $time,data_flag,control_flag);
endmodule
