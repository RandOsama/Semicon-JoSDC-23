`timescale 1ns/1ps
module Adder32_tb;
	reg [31:0] x,y;
	wire [31:0] out;
	
	Adder32 adder(
		.x(x),
		.y(y),
		.out(out)
	);
	
	initial begin 
	
		x = 32'h00000004;
		y = 32'h00000008;
		// C in hex
		
		#10 
		x = 32'h00000002;
		y = 32'h0000000F;
		// 11 in hex
		
		#10
		x = 32'h00000001;
		y = 32'h00000004;
		// 5
		#10
		$finish;
		
	end
endmodule