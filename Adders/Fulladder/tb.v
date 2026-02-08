module full_adder_tb();
  wire sum,carry;
  reg a,b,cin;

  //DUT instantiation
  full_adder DUT(.a(a),
                 .b(b),
                 .cin(cin),
                 .sum(sum),
                 .carry(carry)
                );
  initial begin
    $monitor("Time = %0t, a = %b | b = %b | c = %b | sum = %b | carry = %b",$time,a,b,cin,sum,carry);
    for(int i = 0; i < 8 ; i++) begin
      {a,b,cin} = i;
      #10;
    end
    $finish;
  end
endmodule
