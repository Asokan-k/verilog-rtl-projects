module counter(
  input clk,
  input rst,
  input up_down,
  output reg q
  };
  always @(posedge clk or posedge rst) begin
    if(rst)
      q <= 1'b0;
    else if(up_down)
      q <= q + 1'b1;    // up_count
    else
      q <= q - 1'b1;   // down_count
  end
  endmodule
