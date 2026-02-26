class trans_jk;
   rand bit rst;
   rand bit j;
   rand bit k;
   bit q;

   constraint c1 {
      rst dist {0 := 75, 1 := 25};
   }
  
endclass


module jk_tb();

logic clk, rst, j, k;
logic q;

jk_ff DUT(
    .clk(clk),
    .rst(rst),
    .j(j),
    .k(k),
    .q(q)
);

// clock generation
always #10 clk = ~clk;

trans_jk jk_h;

initial begin
    clk = 0;
    jk_h = new();

    repeat (10) begin
      assert(jk_h.randomize());
        
        rst = jk_h.rst;
        j   = jk_h.j;
        k   = jk_h.k;

        #10;
    end

     $finish;
end

// Assertions
  
// SET assertion
property set_jk;
   @(posedge clk) disable iff(rst)
  (j == 1 && k == 0) |=> (q == 1);
endproperty

  assert property(set_jk)
else $error("SET failed");


// RESET assertion
property reset_jk;
   @(posedge clk) disable iff(rst)
  (j == 0 && k == 1) |=> (q == 0);
endproperty

assert property(reset_jk)
else $error("RESET failed");


// HOLD assertion
property hold_jk;
   @(posedge clk) disable iff(rst)
   (j == 0 && k == 0) |=> (q == $past(q));
endproperty

assert property(hold_jk)
else $error("HOLD failed");


// TOGGLE condition assertion
property toggle_jk;
   @(posedge clk) disable iff(rst)
      (j==1 && k==1) |=> (q == ~$past(q));
endproperty

assert property(toggle_jk)
else $error("JK TOGGLE failed at time %0t", $time);
endmodule
