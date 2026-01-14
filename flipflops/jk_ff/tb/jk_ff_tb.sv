module jk_tb;

  logic clk;
  logic rst_n;
  logic j;
  logic k;
  logic q;
  logic q_bar;

  // DUT
  jk_ff DUT (
    .clk   (clk),
    .rst_n (rst_n),
    .j     (j),
    .k     (k),
    .q     (q),
    .q_bar (q_bar)
  );

  always #10 clk = ~clk;
  
  // Transaction class
 
  class trans;
    rand bit rst_n;
    rand bit j;
    rand bit k;

    // Reset active rarely
    constraint c_rst {
      rst_n dist {1 := 90, 0 := 10};
    }

   
    constraint c_jk {
      {j, k} inside {2'b00, 2'b01, 2'b10, 2'b11};
    }
  endclass

  trans t;
  
  initial begin
    clk   = 0;
    rst_n = 0;
    j     = 0;
    k     = 0;

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
      j     = t.j;
      k     = t.k;

      // Sample at clock edge
      @(posedge clk);
      #1;

      $display("T=%0t | rst_n=%b | J=%b K=%b | Q=%b Q_bar=%b",
               $time, rst_n, j, k, q, q_bar);
    end

    $display("---- RANDOM TEST COMPLETED ----");
    $finish;
  end

endmodule

