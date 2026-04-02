module tri_state_buffer (
    input   a,
    input   en,
    output  y
);

assign y = (en) ? a : 1'bz;

endmodule
