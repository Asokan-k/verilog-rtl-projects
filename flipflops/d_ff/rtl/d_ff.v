module d_ff (
    input   clk,
    input   rst_n,   // Active-low reset
    input   d,
    output reg q,
    output  q_bar
);

    always @(posedge clk) begin
        if (!rst_n) begin
            q <= 1'b0;
        end
        else begin
            q <= d;
        end
    end

    // Complement output
    assign q_bar = ~q;

endmodule
