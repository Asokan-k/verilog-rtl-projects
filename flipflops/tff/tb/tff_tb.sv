
module tff_tb;

  logic clk;
  logic rst_n;
  logic t;
  logic q;
  logic q_bar;

  // DUT
  t_ff DUT (
    .clk   (clk),
    .rst_n (rst_n),
    .t     (t),
    .q     (q),
    .q_bar (q_bar)
  );

  always #10 clk = ~clk;
  
  // Transaction class
  
  class trans;
    rand bit rst_n;
    rand bit t;

    constraint c_rst {
      rst_n dist {1 := 90, 0 := 10};
    }
  endclass

  trans tr;
  
  initial begin
    clk   = 0;
    rst_n = 0;
    t     = 0;

    tr = new();

    // Apply initial reset for 2 cycles
    repeat (2) @(posedge clk);
    rst_n = 1;

    // Random stimulus
    repeat (20) begin
      assert(tr.randomize())
        else $fatal("Randomization failed");

      // Drive inputs BEFORE clock edge
      rst_n = tr.rst_n;
      t     = tr.t;

      // Sample at clock edge
      @(posedge clk);
      #1;

      $display("T=%0t | rst_n=%b | T=%b | Q=%b Q_bar=%b",
               $time, rst_n, t, q, q_bar);
    end

    $display("---- RANDOM TEST COMPLETED ----");
    $finish;
  end

endmodule
