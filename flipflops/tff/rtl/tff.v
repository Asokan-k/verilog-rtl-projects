module t_ff (
    input   clk,
    input   rst_n,   // Active-low reset
    input   t,
    output reg  q,
    output wire q_bar
);

    always @(posedge clk) begin
        if (!rst_n)
            q <= 1'b0;
        else if (t)
            q <= ~q;     // Toggle
        else
            q <= q;      // Hold
    end

    assign q_bar = ~q;

endmodule
