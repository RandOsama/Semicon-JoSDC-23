module sign_extention(x,y);
parameter n =16;
input [n-1:0] x;
output [31:0] y ;

assign y = {{n{x[15]}},x};

endmodule 