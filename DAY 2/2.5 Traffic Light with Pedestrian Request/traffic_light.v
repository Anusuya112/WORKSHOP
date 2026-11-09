module traffic_light(
    input clk, reset,
    output reg [2:0] north,
    output reg [2:0] east
);
    reg [1:0] state;
    reg [3:0] timer;

    localparam NS_GREEN=0, NS_YELLOW=1,
               EW_GREEN=2, EW_YELLOW=3;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= NS_GREEN;
            timer <= 0;
        end else begin
            timer <= timer + 1;
            if(timer == 4'd9) begin
                timer <= 0;
                state <= state + 1;
            end
        end
    end

    always @(*) begin
        north = 3'b100;
        east = 3'b001;
        case(state)
            NS_GREEN: begin north=3'b100; east=3'b001; end
            NS_YELLOW: begin north=3'b010; east=3'b001; end
            EW_GREEN: begin north=3'b001; east=3'b100; end
            EW_YELLOW: begin north=3'b001; east=3'b010; end
        endcase
    end
endmodule
