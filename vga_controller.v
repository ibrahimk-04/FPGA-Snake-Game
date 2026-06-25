module vga_controller (
    input wire pixel_clk,  // 25.175 MHz 
    input  wire rst_n,
    output reg h_sync,
    output reg v_sync,
    output wire display_on, // high when within visible area
    output reg [9:0] pixel_x,
    output reg [9:0] pixel_y
);
    // Horizontal parameters
    localparam H_VISIBLE = 10'd640;
    localparam H_FRONT_PORCH = 10'd16;
    localparam H_SYNC_PULSE = 10'd96;
    localparam H_BACK_PORCH = 10'd48;
    localparam H_TOTAL = 10'd800;

    // Vertical parameters
    localparam V_VISIBLE = 10'd480;
    localparam V_FRONT_PORCH = 10'd10;
    localparam V_SYNC_PULSE = 10'd2;
    localparam V_BACK_PORCH = 10'd33;
    localparam V_TOTAL = 10'd525;

    // COUNTERS
    reg [9:0] h_count;
    reg [9:0] v_count;

    always @(posedge pixel_clk or negedge rst_n) begin
        if (!rst_n) begin
            h_count <= 0;
        end 
        else begin
            if (h_count == H_TOTAL - 1)
                h_count <= 0;
            else
                h_count <= h_count + 1;
        end
    end

    always @(posedge pixel_clk or negedge rst_n) begin
        if (!rst_n) begin
            v_count <= 0;
        end
        else begin
            if (h_count == H_TOTAL -1) begin
               if (v_count == V_TOTAL) begin
                    v_count <= 0;
					end
					else begin
                    v_count <= v_count + 1;
					end
            end
        end
    end


    // HSYNC and VSYNC (active low)
    always @(posedge pixel_clk or negedge rst_n) begin
        if (!rst_n) begin
            h_sync <= 1;
        end
        else begin
            if (h_count > H_VISIBLE + H_FRONT_PORCH && h_count < H_VISIBLE + H_FRONT_PORCH + H_SYNC_PULSE)
                h_sync <= 0;
            else
                h_sync <= 1;
        end
    end

    always @(posedge pixel_clk or negedge rst_n) begin
        if (!rst_n) begin
            v_sync <= 1;
        end
        else begin
            if (v_count > V_VISIBLE + V_FRONT_PORCH && v_count < V_VISIBLE + V_FRONT_PORCH + V_SYNC_PULSE)
                v_sync <= 0;
            else
                v_sync <= 1;
        end
    end

    // Verifying pixels in visible area
    always @(posedge pixel_clk or negedge rst_n) begin
        if(!rst_n) begin
            pixel_x <= 0;
        end
        else begin
            if (h_count < H_VISIBLE)
                pixel_x <= h_count;
            else
                pixel_x <= 0;
        end
    end

    always @(posedge pixel_clk or negedge rst_n) begin
        if(!rst_n) begin
            pixel_y <= 0;
        end
        else begin
            if (v_count < V_VISIBLE)
                pixel_y <= v_count;
            else
                pixel_y <= 0;
        end
    end

    assign display_on = (h_count < H_VISIBLE) && (v_count < V_VISIBLE);

endmodule
