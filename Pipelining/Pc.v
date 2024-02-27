module Pc(clk,reset,PC_write,Din,Qout);

input clk,reset ,PC_write ;
input [31:0] Din ;
output [31:0] Qout ;

reg [31:0] QoutReg ;

initial begin
	QoutReg <= 0;
end 

always@(posedge clk) begin
 if(reset)
	QoutReg <= 32'd0 ;
 else if(PC_write)
	QoutReg <= Din;
 else 
	QoutReg <= QoutReg ;
 end
 
 assign Qout = QoutReg ;
 
 
endmodule  
 