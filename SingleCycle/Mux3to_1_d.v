module Mux3to_1_d(x,y,z,S,out);
		parameter n = 32 ;
		input [n-1:0]x,y,z;
		input [1:0]S;
		output [n-1:0] out;
		
		
		assign out = (S == 2'b00) ? x : (S == 2'b01) ? y : (S == 2'b10) ? z : 0 ;
		
		
		
endmodule
