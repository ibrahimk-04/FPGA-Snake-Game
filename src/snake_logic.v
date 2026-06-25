module snake_logic (
    input wire clk,
    input wire rst_n,
    input wire tick,
    input wire [1:0] dir,

    output reg [6:0] snake_x [0:63],
    output reg [5:0] snake_y [0:63],
    output reg [5:0] length,

    output reg [6:0] food_x,
    output reg [5:0] food_y
);

    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            length <= 3;

            snake_x[0] <= 40;
            snake_y[0] <= 30;

            snake_x[1] <= 39;
            snake_y[1] <= 30;

            snake_x[2] <= 38;
            snake_y[2] <= 30;

            food_x <= 20;
            food_y <= 20;
        end

        else if (tick) begin

            // shift body
            for (i = 63; i > 0; i = i - 1) begin
                snake_x[i] <= snake_x[i-1];
                snake_y[i] <= snake_y[i-1];
            end

            // move head
            case (dir)
                2'b00: snake_y[0] <= snake_y[0] - 1; // up
                2'b01: snake_y[0] <= snake_y[0] + 1; // down
                2'b10: snake_x[0] <= snake_x[0] - 1; // left
                2'b11: snake_x[0] <= snake_x[0] + 1; // right
            endcase

            // eat food
            if (snake_x[0] == food_x && snake_y[0] == food_y) begin
                length <= length + 1;
                food_x <= (food_x + 7) % 80; // simple move (no RNG yet)
                food_y <= (food_y + 5) % 60;
            end

            // wall collision
            if (snake_x[0] >= 80 || snake_y[0] >= 60) begin
                length <= 3;
            end
        end
    end

endmodule