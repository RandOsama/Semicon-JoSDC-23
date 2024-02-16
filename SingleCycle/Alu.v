module Alu(shamt,x,y,ALUout,ZeroF,result);
		input [4:0]shamt;
		input [31:0] x,y;
		input [3:0] ALUout;
		output ZeroF;
		output reg [31:0] result;
		 
		//wire unsigned [31:0] x_unsigned = x;
		//wire unsigned [31:0] y_unsigned = y;
		
		wire signed [31:0] x_signed = x;
		wire signed [31:0] y_signed = y;
		
always@(*)begin		
		case(ALUout) 
		4'b0000:  result <= x & y;
		4'b0001:  result <= x | y;  
		4'b0010:  result <= x_signed + y_signed ;  //add 
		4'b0110:  result <= x_signed - y_signed ;  //sub 
		4'b0111:  result <= (x_signed < y_signed) ? {{31{1'b0}},1'b1} : 32'b0;  // slt 
	   4'b0101:  result <= x ^ y; // check
		4'b1100:  result <= ~(x|y);   
		4'b1111:  result <= y << shamt;    // shift left logical  , check  
		4'b1000:  result <= y >> shamt;    // shift right logical  , check 
		4'b1010:  result <= x + y;   // add unsigned 
		4'b1110:  result <= x - y;  //  sub unsigned 
		default : result = 0 ;
		endcase
		end
		
		assign ZeroF = (result == 0) ? 1'b1 : 1'b0;
		
endmodule