module memory_watchdog(
    input clk, reset, write_en, refresh,
    input [3:0] address,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output reg watchdog_expired
);
    reg [7:0] memory [0:15];
    reg [3:0] timer;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            timer <= 0;
            watchdog_expired <= 0;
            data_out <= 0;
        end else begin
            if(write_en)
                memory[address] <= data_in;
            else
                data_out <= memory[address];

            if(refresh) begin
                timer <= 0;
                watchdog_expired <= 0;
            end else if(timer == 4'd9) begin
                watchdog_expired <= 1;
            end else begin
                timer <= timer + 1;
            end
        end
    end
endmodule
