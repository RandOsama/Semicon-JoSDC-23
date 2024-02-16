 module Data_Memory(clk,Addr,WriteData,MemRead,MemWrite,ReadData); 
   input clk;
	input [31:0]Addr,WriteData;
	input MemRead,MemWrite;
	
	output  [31:0] ReadData;
	
	
	reg [31:0] memory [31:0];
	
	
	assign ReadData=(MemRead==1) ? memory[Addr] : 32'd0;
		
	always @(negedge clk)
		begin
		if(MemWrite)
				memory[Addr]<=WriteData;
		end
		
endmodule 