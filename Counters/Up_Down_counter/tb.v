module counter_tb();
  reg up_down,clk,rst;
  wire [3:0]q;

  //DUT instantiation
  counter DUT(.clk(clk),
              .rst(rst),
              .up_down(up_down),
              .q(q)
             );
  //clk generation
  always #5 clk = ~clk;
  initial begin
    $monitor("time = %0t | clk = %b | rst = %b | up_down = %b | q = %b",$time,clk,rst,up_down,q);
    clk = 0; rst = 1; up_down = 0; #10;
    rst = 0;
    up_down = 1;
    #50;
    up_down = 0;
    #50;
    $finish;
  end
endmodule
