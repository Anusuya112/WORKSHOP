module round_robin_arbiter(
    input clk, reset,
    input [3:0] request,
    output reg [3:0] grant
);
    reg [1:0] priority;
    integer i;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            priority <= 0;
            grant <= 0;
        end else begin
            grant <= 0;
            for(i=0; i<4; i=i+1) begin
                if(request[(priority+i)%4] && grant==0) begin
                    grant[(priority+i)%4] <= 1;
                    priority <= (priority+i+1)%4;
                end
            end
        end
    end
endmodule
