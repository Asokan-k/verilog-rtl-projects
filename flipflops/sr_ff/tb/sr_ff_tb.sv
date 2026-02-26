class trans_sr;
   rand bit rst;
   rand bit s;
   rand bit r;

   bit q;
   bit q_bar;

   constraint c1 {
      rst dist {0 := 75, 1 := 25};
   }
endclass

module SR_tb();

logic clk, rst, s, r;
logic q, q_bar;

sr1_ff DUT(
    .clk(clk),
    .rst(rst),
    .s(s),
    .r(r),
    .q(q),
    .q_bar(q_bar)
);

// clock generation
always #10 clk = ~clk;

trans_sr sr_h;

initial begin
    clk = 0;
    sr_h = new();

    repeat (10) begin
        assert(sr_h.randomize());
        
        rst = sr_h.rst;
        s   = sr_h.s;
        r   = sr_h.r;

        #10;
    end

     $finish;
end
// Assertions

// SET assertion
property set_sr;
   @(posedge clk) disable iff(rst)
      (s == 1 && r == 0) |=> (q == 1);
endproperty

assert property(set_sr)
else $error("SET failed");

// RESET assertion
property reset_sr;
   @(posedge clk) disable iff(rst)
      (s == 0 && r == 1) |=> (q == 0);
endproperty

assert property(reset_sr)
else $error("RESET failed");

// HOLD assertion
property hold_sr;
   @(posedge clk) disable iff(rst)
      (s == 0 && r == 0) |=> (q == $past(q));
endproperty

assert property(hold_sr)
else $error("HOLD failed");

// INVALID condition assertion
property invalid_sr;
   @(posedge clk) disable iff(rst)
      !(s == 1 && r == 1);
endproperty

assert property(invalid_sr)
else $error("INVALID SR condition detected");

endmodule
