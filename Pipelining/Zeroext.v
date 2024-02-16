module Zeroext(x,y);
input [25:0] x;
output [31:0] y ;



assign y = {16'b0,x};

endmodule