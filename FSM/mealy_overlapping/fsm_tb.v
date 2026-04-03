module mealy_1001_tb;

reg clk;
reg rst;
reg in;
wire out;

// instantiate DUT
mealy_1001 dut (
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out)
);

// clock generation
always #5 clk = ~clk;

// stimulus
initial begin
    clk = 0;
    rst = 1;
    in  = 0;

    #10 rst = 0;

    // apply sequence: 10011001
    #10 in = 1;
    #10 in = 0;
    #10 in = 0;
    #10 in = 1;  // detect here

    #10 in = 1;
    #10 in = 0;
    #10 in = 0;
    #10 in = 1;  // detect again

    #20 $finish;
end

// monitor
initial begin
    $monitor("time=%0t rst=%b in=%b out=%b",
              $time, rst, in, out);
end

endmodule
