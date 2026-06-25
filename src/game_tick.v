module game_tick (
    input wire clk,
    input wire rst_n,
    output reg tick
);

    parameter COUNT_MAX = 5_000_000; // ~10 Hz (50MHz / 5M)

    reg [22:0] count;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 0;
            tick <= 0;
        end else if (count == COUNT_MAX) begin
            count <= 0;
            tick <= 1;   // one-cycle pulse
        end else begin
            count <= count + 1;
            tick <= 0;
        end
    end

endmodule