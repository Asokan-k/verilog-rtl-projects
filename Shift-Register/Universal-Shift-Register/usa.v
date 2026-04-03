module universal_shift_register (
    input wire clk,
    input wire rst,
    input wire [1:0] sel,
    input wire [3:0] d,
    input wire din_left,
    input wire din_right,
    output reg [3:0] q
);

always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 4'b0000;
    else begin
        case(sel)

            2'b00: q <= q;   // hold

            2'b01: q <= {din_right, q[3:1]}; // shift right

            2'b10: q <= {q[2:0], din_left};  // shift left

            2'b11: q <= d; // parallel load

        endcase
    end
end

endmodule
