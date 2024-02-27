module Zero(x,y);
input [15:0] x;
output [31:0] y ;

assign y = {16'b0,x};

endmodule
