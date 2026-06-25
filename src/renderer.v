module renderer (
    input wire display_on,
    input wire [9:0] pixel_x,
    input wire [9:0] pixel_y,

    input wire [6:0] snake_x [0:63],
    input wire [5:0] snake_y [0:63],
    input wire [5:0] length,

    input wire [6:0] food_x,
    input wire [5:0] food_y,

    output reg [7:0] VGA_R,
    output reg [7:0] VGA_G,
    output reg [7:0] VGA_B
);

    wire [6:0] cell_x = pixel_x[9:3];
    wire [5:0] cell_y = pixel_y[9:3];

    integer i;
    reg snake_pixel;
	 
	 
	 
	 always @(*) begin
        snake_pixel = 0;

        for (i = 0; i < length; i = i + 1) begin
            if (cell_x == snake_x[i] && cell_y == snake_y[i])
                snake_pixel = 1;
        end

        if (!display_on) begin
            {VGA_R,VGA_G,VGA_B} = 0;
        end
        else if (snake_pixel) begin
            {VGA_R,VGA_G,VGA_B} = {8'h00,8'hFF,8'h00}; // green
        end
        else if (cell_x == food_x && cell_y == food_y) begin
            {VGA_R,VGA_G,VGA_B} = {8'hFF,8'h00,8'h00}; // red
        end
        else begin
            {VGA_R,VGA_G,VGA_B} = 0;
        end
    end

endmodule