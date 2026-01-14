module sr_tb;
  logic clk;
  logic rst_n;
  logic s;
  logic r;
  logic q;
  logic q_bar;

  sr_ff DUT (
    .clk   (clk),
    .rst_n (rst_n),
    .s     (s),
    .r     (r),
    .q     (q),
    .q_bar (q_bar)
  );

  always #10 clk = ~clk;
  
  // Transaction class
  
  class trans;
    rand bit rst_n;
    rand bit s;
    rand bit r;
    
    constraint c_rst {
      rst_n dist {1 := 90, 0 := 10};
    }
    constraint c_sr {
      {s, r} inside {2'b00, 2'b01, 2'b10, 2'b11};
    }
  endclass

  trans t;
  
  initial begin
    clk   = 0;
    rst_n = 0;
    s     = 0;
    r     = 0;

    t = new();
    
    repeat (2) @(posedge clk);
    rst_n = 1;

    // Random stimulus
    repeat (20) begin
      assert(t.randomize())
        else $fatal("Randomization failed");

      // Drive inputs BEFORE clock edge
      rst_n = t.rst_n;
      s     = t.s;
      r     = t.r;

      // Sample at clock edge
      @(posedge clk);
      #1;

      $display("T=%0t | rst_n=%b | S=%b R=%b | Q=%b Q_bar=%b",
               $time, rst_n, s, r, q, q_bar);
    end

    $display("---- RANDOM TEST COMPLETED ----");
    $finish;
  end

endmodule
