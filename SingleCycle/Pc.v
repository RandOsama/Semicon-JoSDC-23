module Pc(clk,reset,PC_IN,PC_OUT);
input [31:0] PC_IN ; 
input clk; 
input reset; 
output reg [31:0] PC_OUT; 
initial 
	PC_OUT=0;
always @(posedge clk ) 
begin
 if(reset==1'b1)
  PC_OUT <= 1'b0; 
 else 
  PC_OUT <= PC_IN ;  
end 
endmodule 