/*module Mux3to_1_d(x,y,z,S,out);
		input [31:0]x,y,z;
		input [1:0]S;
		output [31:0] out;
		reg [31:0] out;
		
		
		always@(*)begin
		case(S)
		2'b00: out = x;
		2'b01: out = y;
		2'b10: out = z;
		endcase
		end 
		
		
endmodule*/

module Mux3to_1_d(x,y,z,S,out);
		parameter n = 32 ;
		input [n-1:0]x,y,z;
		input [1:0]S;
		output [n-1:0] out;
		
		
		assign out = (S == 2'b00) ? x : (S == 2'b01) ? y : (S == 2'b10) ? z : 0 ;
		// i coded like this because the RTL viewer shows latches 
		
		
endmodule