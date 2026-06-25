module input_control (
    input wire clk,
    input wire rst_n,
    input wire up, down, left, right,
    output reg [1:0] dir
);
// 00=UP, 01=DOWN, 10=LEFT, 11=RIGHT

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            dir <= 2'b11; // start RIGHT
        else begin
            if (up && dir != 2'b01) dir <= 2'b00;
            else if (down && dir != 2'b00) dir <= 2'b01;
            else if (left && dir != 2'b11) dir <= 2'b10;
            else if (right && dir != 2'b10) dir <= 2'b11;
        end
    end
endmodule