module sequence_detector(
    input clk, reset, din,
    output reg detected
);
    reg [2:0] state;

    parameter S0=0, S1=1, S2=2, S3=3;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
            detected <= 0;
        end else begin
            detected <= 0;
            case(state)
                S0: state <= din ? S1 : S0;
                S1: state <= din ? S1 : S2;
                S2: state <= din ? S3 : S0;
                S3: begin
                    if (din) begin
                        detected <= 1;
                        state <= S1;
                    end else state <= S2;
                end
                default: state <= S0;
            endcase
        end
    end
endmodule
