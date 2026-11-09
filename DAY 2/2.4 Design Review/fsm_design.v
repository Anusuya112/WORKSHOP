module fsm_design(
    input clk, reset, start,
    output reg busy, done
);
    reg [1:0] state;

    localparam IDLE=2'b00,
               RUN=2'b01,
               FINISH=2'b10;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            busy <= 0;
            done <= 0;
        end else begin
            case(state)
                IDLE: begin
                    busy <= 0;
                    done <= 0;
                    if(start) state <= RUN;
                end
                RUN: begin
                    busy <= 1;
                    state <= FINISH;
                end
                FINISH: begin
                    busy <= 0;
                    done <= 1;
                    state <= IDLE;
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule
