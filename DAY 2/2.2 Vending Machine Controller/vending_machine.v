module vending_machine(
    input clk, reset,
    input [1:0] coin,
    output reg dispense,
    output reg [1:0] change
);
    reg [2:0] balance;
    reg [2:0] total;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            balance <= 0;
            dispense <= 0;
            change <= 0;
            total <= 0;
        end else begin
            dispense <= 0;
            change <= 0;

            case(coin)
                2'b01: total = balance + 1;
                2'b10: total = balance + 2;
                default: total = balance;
            endcase

            if (total >= 3) begin
                dispense <= 1;
                change <= total - 3;
                balance <= 0;
            end else begin
                balance <= total;
            end
        end
    end
endmodule
