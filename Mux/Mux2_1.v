module mux2_1(y,sel,i0,i1);
  
  input sel;
  input i0;
  input i1;
  output y;
  //logic for 2:1 mux
  assign y = (sel) ? i1 : i0;
  
endmodule
