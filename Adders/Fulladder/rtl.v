module full_adder(sum,carry,a,b,cin);
  input a,b,cin;
  output sum,carry;

  //logic for sum
  assign sum = a ^ b ^ cin;
  //logic for carry
  assign sum = a & b | b & c | c & a;
endmodule
