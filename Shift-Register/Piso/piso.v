module piso (
    input  wire clk,
    input  wire rst,
    input  wire load,
    input  wire [3:0] d,
    output wire dout
);

reg [3:0] shift;

always @(posedge clk or posedge rst) begin
    if (rst)
        shift <= 4'b0000;
    else if (load)
        shift <= d;
    else
        shift <= {shift[2:0], 1'b0};
end

assign dout = shift[3];

endmodule
