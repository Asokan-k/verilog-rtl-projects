module demux_1_4 (
    input  wire in,
    input  wire [1:0] sel,
    output wire y0,
    output wire y1,
    output wire y2,
    output wire y3
);

assign y0 = (sel == 2'b00) ? in : 1'b0;
assign y1 = (sel == 2'b01) ? in : 1'b0;
assign y2 = (sel == 2'b10) ? in : 1'b0;
assign y3 = (sel == 2'b11) ? in : 1'b0;

endmodule
