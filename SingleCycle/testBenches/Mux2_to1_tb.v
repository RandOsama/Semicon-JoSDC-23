`timescale 1ns/1ps
module Mux2_to1_tb;
	reg S;
	parameter n = 32;
	reg [n-1:0] x,y;
	wire [n-1:0] out;
	
	Mux2_to1 #(n) mux2 (
		.S(S),
		.x(x),
		.y(y),
		.out(out)
	);
	
	initial begin
		x = 32'h12345678;  
		y = 32'hFFFFFFFF;  
		S = 0;
		
		#10 S = 1;
		#5 y= 32'h11111111;
		x = 32'hCCCCCCCC; 
		#10 S = 0;
		#10
		$finish;
	end
endmodule