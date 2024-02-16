module Mux3to_1_d(x,y,z,S,out);
		parameter n = 32 ;
		input [n-1:0]x,y,z;
		input [1:0]S;
		output reg[n-1:0] out;
		
		always@(*)begin
			case(S)
			2'b00 : out = x;
			2'b01 : out = y;
			2'b10 : out = z ;
			default : out = 32'd0 ;
			endcase
		end
		
		
		
endmodule

