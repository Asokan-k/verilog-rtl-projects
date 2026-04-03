module sr_latch (
    input  wire s,
    input  wire r,
    input  wire en,
    output reg  q,
    output wire q_bar
);

always @(*) begin
    if (en) begin
        case({s,r})
            2'b00: q = q;
            2'b01: q = 1'b0;
            2'b10: q = 1'b1;
            2'b11: q = 1'bx;
        endcase
    end
end

assign q_bar = ~q;

endmodule
