`timescale 1ns/1ps
module sign_extention_tb;
	parameter n = 16;
	reg [n-1:0] x;
	wire [31:0] y ;
	
	sign_extention #(n) extender(
		.x(x),
		.y(y)
	); 
	
	initial begin
		x = 16'h1234;
		#10
		x= 16'hFFFF;//sign
		#10
		$finish;
	end
  
endmodule
