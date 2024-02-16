module Mux2_to1(x,y,S,out);
parameter n = 32 ;

input[n-1:0] x ,y ;
output reg[n-1:0] out ;

input S;
always@(*)begin
	case(S)
		1'b0 : out = x ;
		1'b1 : out = y ;
		endcase
end

endmodule 