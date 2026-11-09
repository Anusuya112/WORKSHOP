// ============================================================
// BONUS CHALLENGE 3 - UART TRANSMITTER
// FILE 3: uart_tx.v
// ============================================================

module uart_tx #(
    parameter CLKS_PER_BIT = 16
)(
    input wire clk,
    input wire rst,
    input wire tx_start,
    input wire [7:0] tx_data,
    output reg tx,
    output reg tx_done
);

    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam DATA  = 2'b10;
    localparam STOP  = 2'b11;

    reg [1:0] state;
    reg [15:0] clk_count;
    reg [2:0] bit_index;
    reg [7:0] data_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            tx <= 1'b1;
            tx_done <= 1'b0;
            clk_count <= 0;
            bit_index <= 0;
            data_reg <= 0;
        end
        else begin
            tx_done <= 1'b0;

            case (state)

                IDLE: begin
                    tx <= 1'b1;
                    clk_count <= 0;
                    bit_index <= 0;

                    if (tx_start) begin
                        data_reg <= tx_data;
                        state <= START;
                    end
                end

                START: begin
                    tx <= 1'b0;

                    if (clk_count < CLKS_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        state <= DATA;
                    end
                end

                DATA: begin
                    tx <= data_reg[bit_index];

                    if (clk_count < CLKS_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;

                        if (bit_index < 7)
                            bit_index <= bit_index + 1;
                        else begin
                            bit_index <= 0;
                            state <= STOP;
                        end
                    end
                end

                STOP: begin
                    tx <= 1'b1;

                    if (clk_count < CLKS_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        tx_done <= 1'b1;
                        state <= IDLE;
                    end
                end

            endcase
        end
    end

endmodule
