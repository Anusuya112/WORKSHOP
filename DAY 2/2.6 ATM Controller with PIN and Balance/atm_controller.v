module atm_controller(
    input clk, reset, request,
    input [7:0] balance,
    input [7:0] amount,
    output reg approved,
    output reg denied
);
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            approved <= 0;
            denied <= 0;
        end else begin
            approved <= 0;
            denied <= 0;
            if(request) begin
                if(amount <= balance)
                    approved <= 1;
                else
                    denied <= 1;
            end
        end
    end
endmodule
