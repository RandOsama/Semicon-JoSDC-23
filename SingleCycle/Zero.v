module Zero(x,y);
	parameter n = 16;
	input [n-1:0] x;
	output [31:0] y ;

	assign y = {{n{1'b0}},x};

endmodule