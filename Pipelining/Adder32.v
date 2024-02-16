module Adder32(x,y,out);
	input [31:0] x,y;
	output [31:0] out;
	
	assign out = x+y;
endmodule