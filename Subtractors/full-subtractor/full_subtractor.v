module full_subtractor(
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire diff,
    output wire borrow
);

assign diff = a ^ b ^ cin;

  assign borrow = (~a & b) | (~a & cin) | (b & cin);

endmodule
