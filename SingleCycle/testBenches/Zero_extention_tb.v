`timescale 1ns/1ps
module Zero_extention_tb;
	parameter n = 16;
	reg [n-1:0] x;
	wire [31:0] y ;
	
	Zero #(n) zeroExt(
		.x(x),
		.y(y)
	); 
	
	initial begin
		x = 16'h1234;
		#10
		x= 16'hFFFF;
		#10
		$finish;
	end
  
endmodule
