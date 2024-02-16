module Mux2_to1(x,y,S,out);
parameter n = 32 ;

input[n-1:0] x ,y ;
output[n-1:0] out ;

input S;

assign out = (S==0) ? x : y ;

endmodule 