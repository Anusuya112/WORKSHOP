// ============================================================
// FILE 4: uart_tx_tb.v
// ============================================================

`timescale 1ns/1ps

module uart_tx_tb;

    reg clk, rst;
    reg tx_start;
    reg [7:0] tx_data;

    wire tx;
    wire tx_done;

    integer i;
    reg [7:0] received;

    uart_tx #(
        .CLKS_PER_BIT(4)
    ) uut (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_done(tx_done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        tx_start = 0;
        tx_data = 8'b10100101;
        received = 0;

        #12;
        rst = 0;

        @(negedge clk);
        tx_start = 1;

        @(negedge clk);
        tx_start = 0;

        // Wait for start bit and sample data bits
        @(negedge tx);
        repeat (6) @(posedge clk);
        #1;

        for (i = 0; i < 8; i = i + 1) begin
            received[i] = tx;
            repeat (4) @(posedge clk);
            #1;
        end

        $display("Transmitted Data = %b", tx_data);
        $display("Received Data    = %b", received);

        if (received == tx_data)
            $display("UART TEST PASSED");
        else
            $display("UART TEST FAILED");

        wait (tx_done);
        $display("TRANSMISSION COMPLETED");

        $finish;
    end

endmodule
