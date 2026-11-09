module hazard_waveform_flags(
    input clk, reset,
    input data_hazard, control_hazard,
    output reg data_flag, control_flag
);
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            data_flag <= 0;
            control_flag <= 0;
        end else begin
            data_flag <= data_hazard;
            control_flag <= control_hazard;
        end
    end
endmodule
