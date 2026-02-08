module half_adder(sum,carry,a,b);
  input a,b;
  output sum,carry;

  //logic for sum
  assign sum = a ^ b;
  //logic for carry
  assign carry = a & b;
endmodule
