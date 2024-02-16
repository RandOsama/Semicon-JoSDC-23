module Data_Memory(clk,Addr,WriteData,MemRead,MemWrite,ReadData); // we can make it dual ports so we can read and write in same clk cycle 
   input clk;
	input [31:0]Addr,WriteData;
	input MemRead,MemWrite;
	
	output  [31:0] ReadData;
	
	
	reg [31:0] memory [100:0];
	
	initial begin
	
		// arrays1
				memory[0]=32'h00000003;//a[0]
				memory[1]=32'h00000008;
				memory[2]=32'h00000005;
				memory[3]=32'h00000002;
				memory[4]=32'h00000032;//b[0]
				memory[5]=32'h00000032;
				memory[6]=32'h00000032;
				memory[7]=32'h00000032;
				memory[8]=32'h00000032;
				memory[9]=32'h00000032;
				memory[10]=32'h00000032;
				memory[11]=32'h00000032;
				memory[12]=32'h00000032;
				memory[13]=32'h00000032;
				memory[14]=32'h00000032;
				memory[15]=32'h00000032;
				memory[16]=32'h00000032;
				memory[17]=32'h00000068;
				memory[18]=32'h00000065;//c[0]
				memory[19]=32'h0000006c;
				memory[20]=32'h0000006c;
				memory[21]=32'h0000006f;
				memory[22]=32'h00000000;
		
		
		/*
			// arrays2
				memory[0]=32'h00000003;
				memory[1]=32'h00000003;
				memory[2]=32'h00000003;
				memory[3]=32'h00000003;
				memory[4]=32'h00000003;
		*/
		
		/*
			// Arithmetic Operations
				memory[0]=32'h00000023;//35
				memory[1]=32'h0000002F;//47
				memory[2]=32'h0000001A;//26
		*/
	
	end
	
	assign ReadData= (MemRead==1) ? memory[Addr] : 32'd0;
		
	always @(negedge clk)
		begin
		if(MemWrite)
				memory[Addr]<=WriteData;
		end
		
endmodule 