`timescale 1ns/1ps
module ShiftLeft_2_tb;
	parameter n = 26;
	reg [n-1:0] x;
	wire [31:0] y;
	
	ShiftLeft_2 #(n) shift(
		.x(x),
		.y(y)
	);
	
	
	initial begin
		x = 26'd2;
		#10
		x = 26'd3;
		#10
		
		$finish;
	end
	
endmodule