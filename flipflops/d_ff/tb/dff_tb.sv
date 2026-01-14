
module dff_tb;

  logic clk;
  logic rst_n;
  logic d;
  logic q;
  logic q_bar;

  // DUT
  d_ff DUT (
    .clk   (clk),
    .rst_n (rst_n),
    .d     (d),
    .q     (q),
    .q_bar (q_bar)
  );

  always #10 clk = ~clk;
  
  // Transaction class
  
  class trans;
    rand bit rst_n;
    rand bit d;

    constraint c_rst {
      rst_n dist {1 := 90, 0 := 10};
    }
  endclass

  trans t;
  
  initial begin
    clk   = 0;
    rst_n = 0;
    d     = 0;

    t = new();

    // Apply initial reset for 2 cycles
    repeat (2) @(posedge clk);
    rst_n = 1;

    // Random stimulus
    repeat (20) begin
      assert(t.randomize())
        else $fatal("Randomization failed");

      // Drive inputs BEFORE clock edge
      rst_n = t.rst_n;
      d     = t.d;

      // Sample at clock edge
      @(posedge clk);
      #1;

      $display("T=%0t | rst_n=%b | D=%b | Q=%b Q_bar=%b",
               $time, rst_n, d, q, q_bar);
    end

    $display("---- RANDOM TEST COMPLETED ----");
    $finish;
  end

endmodule

