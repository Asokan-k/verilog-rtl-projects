module sr1_ff (
    input   clk,
    input   rst, 
    input   s,
    input   r,
    output reg q,
);

parameter HOLD    = 2'b00;
parameter RESET   = 2'b01;
parameter SET     = 2'b10;
parameter INVALID = 2'b11;

always @(posedge clk) begin
    if (rst_n)
        q <= 1'b0;
    else begin
        case ({s, r})
            HOLD   : q <= q;        // hold
            RESET  : q <= 1'b0;     // reset
            SET    : q <= 1'b1;     // set
            INVALID: q <= 1'bx;     // invalid state
        endcase
    end
end
endmodule
