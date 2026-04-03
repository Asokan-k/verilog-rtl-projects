module siso (
    input  wire clk,
    input  wire rst,
    input  wire din,
    output wire dout
);

reg [3:0] shift;

always @(posedge clk or posedge rst) begin
    if (rst)
        shift <= 4'b0000;
    else
        shift <= {shift[2:0], din};
end

assign dout = shift[3];

endmodule
