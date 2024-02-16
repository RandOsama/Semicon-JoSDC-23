`timescale 1ns/1ps
module Pc_tb;
	reg clk , Resetn;
	reg [31:0] Din;
	wire [31:0] Qout;
	
	Pc pc(
		.clk(clk),
		.Resetn(Resetn),
		.Din(Din),
		.Qout(Qout)
	);
	
	always 
		begin
			#5 clk = ~clk;
		end

	initial begin
		clk = 0;
		Resetn = 1;
		Din = 0;
		
		#10 Resetn = 0;
		Din = 32'h00001111;
		#10 Din = 0;
		#5 Resetn = 1;
		#5 Resetn = 0;
		#5 Din = 32'h12345678;
		#10 Din = 0;
		#5
		
		$finish;
	end
endmodule