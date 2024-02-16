`timescale 1ns/1ps
module Mux3to_1_d_tb;
	reg [1:0] S;
	parameter n = 32;
	reg [n-1:0] x,y,z;
	wire [n-1:0] out;
	
	Mux3to_1_d #(n) mux2 (
		.S(S),
		.x(x),
		.y(y),
		.z(z),
		.out(out)
	);
	
	initial begin
		x = 32'h12345678;  
		y = 32'hFFFFFFFF;
		z = 32'h00000001;
		S = 2'b00;
		
		#10 S = 2'b01;
		#10 S = 2'b10;
		#10 x= 32'h11111111;
		y = 32'hCCCCCCCC; 
		z = 32'hDDDDBBBB;
		#10 S = 2'b00;
		#10
		$finish;
	end
endmodule