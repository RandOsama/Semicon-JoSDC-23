module Adder32(x,y,out);

		input [31:0] x,y;
		output reg [31:0] out;
		
		always @(*)begin 
		  out = x+y;
		end
endmodule