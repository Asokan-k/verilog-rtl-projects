//mux2_1
module mux2_1(y,sel,i);
  input [1:0]i,sel;
  output y;
  assign y = (sel) ? i[1] : i[0];
endmodule

//mux 4_1 mux
module mux4_1(y,i,sel);
  input [1:0]sel;
  input [3:0]i;
  output reg y;
  always @(*) begin
    case(sel)
      2'b00: y = i[0];
      2'b01: y = i[1];
      2'b10: y = i[2];
      2'b11: y = i[3];
    endcase
  end
endmodule

//8_1 mux using 4_1 mux

module mux8_1(y,sel,i);
  input [7:0]i;
  input [2:0]sel;
  output y;
wire w0,w1;
  
  mux4_1 m1(.y(w0), .sel(sel[1:0]), .i(i[3:0]));
  mux4_1 m2(.y(w1), .sel(sel[1:0]), .i(i[7:4]));
  mux2_1 m3(.y(y), .sel(sel[2]), .i({w1,w0}));

endmodule
