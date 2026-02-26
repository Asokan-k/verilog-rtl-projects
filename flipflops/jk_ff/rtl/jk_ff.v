
module jk_ff (
    input   clk,
    input   rst,  
    input   j,
    input   k,
    output reg q,
);

parameter HOLD    = 2'b00;
parameter RESET   = 2'b01;
parameter SET     = 2'b10;
parameter TOGGLE  = 2'b11;

always @(posedge clk) begin
    if (rst_n)
        q <= 1'b0;
    else begin
      case ({j, k})
            HOLD   : q <= q;          // hold
            RESET  : q <= 1'b0;      // reset
            SET    : q <= 1'b1;     // set
            TOGGLE : q <= ~q;      // complement of q
        endcase
    end
end
endmodule
