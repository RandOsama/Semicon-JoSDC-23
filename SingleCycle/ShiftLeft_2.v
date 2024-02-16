module ShiftLeft_2(x,y);
	parameter n = 26; 
	input [n-1:0] x;
	output [31:0] y;
	

	assign y = (x << 2) ;
	  
   
   	
endmodule 