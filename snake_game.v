module snake_game (
    input CLOCK_50,
    input [3:0] KEY,
    input rst_n,

    output VGA_HS,
    output VGA_VS,
    output VGA_CLK,
    output VGA_BLANK_N,
    output VGA_SYNC_N,

    output [7:0] VGA_R,
    output [7:0] VGA_G,
    output [7:0] VGA_B
);

wire pix_clk;
wire display_on;
wire [9:0] pixel_x;
wire [9:0] pixel_y;

wire tick;
wire [1:0] dir;

assign VGA_CLK = pix_clk;
assign VGA_SYNC_N = 1'b1;

reg pix_clk_reg;

always @(posedge CLOCK_50 or negedge rst_n) begin
    if (!rst_n)
        pix_clk_reg <= 0;
    else
        pix_clk_reg <= ~pix_clk_reg;
end

assign pix_clk = pix_clk_reg;

vga_controller vga_inst (
    .pixel_clk(pix_clk),
    .rst_n(rst_n),
    .h_sync(VGA_HS),
    .v_sync(VGA_VS),
    .display_on(display_on),
    .pixel_x(pixel_x),
    .pixel_y(pixel_y)
);

assign VGA_BLANK_N = display_on;

game_tick tick_inst (
    .clk(CLOCK_50),
    .rst_n(rst_n),
    .tick(tick)
);

input_control input_inst (
    .clk(CLOCK_50),
    .rst_n(rst_n),
    .up(~KEY[3]),
    .down(~KEY[2]),
    .left(~KEY[1]),
    .right(~KEY[0]),
    .dir(dir)
);

wire [6:0] snake_x [0:63];
wire [5:0] snake_y [0:63];

wire [5:0] length;

wire [6:0] food_x;
wire [5:0] food_y;


snake_logic snake_inst (
    .clk(CLOCK_50),
    .rst_n(rst_n),
    .tick(tick),
    .dir(dir),

    .snake_x(snake_x),
    .snake_y(snake_y),
    .length(length),

    .food_x(food_x),
    .food_y(food_y)
);

renderer render_inst (
    .display_on(display_on),
    .pixel_x(pixel_x),
    .pixel_y(pixel_y),

    .snake_x(snake_x),
    .snake_y(snake_y),
    .length(length),

    .food_x(food_x),
    .food_y(food_y),

    .VGA_R(VGA_R),
    .VGA_G(VGA_G),
    .VGA_B(VGA_B)
);
endmodule