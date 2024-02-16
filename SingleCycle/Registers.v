  module Registers(clk,reset,Rr1,Rr2,WriteRegister,regWrite,WriteData,Rd1,Rd2);
	input clk ,reset;		
	input [4:0]Rr1,Rr2,WriteRegister;
  	input [31:0]WriteData;
	input regWrite;
	output [31:0] Rd1,Rd2;
	
	reg [31:0] registers [0:31]; 
	

	assign Rd1 = registers[Rr1];
	
   	assign Rd2 = registers[Rr2];
	
   always @(posedge clk) begin
	
		if(reset) begin
			registers[0] <= 0;
			registers[1] <= 0;
			registers[2] <= 0;
			registers[3] <= 0;
			registers[4] <= 0;
			registers[5] <= 0;
			registers[6] <= 0;
			registers[7] <= 0;
			registers[8] <= 0;
			registers[9] <= 0;
			registers[10] <= 0;
			registers[11] <= 0;
			registers[12] <= 0;
			registers[13] <= 0;
			registers[14] <= 0;
			registers[15] <= 0;
			registers[16] <= 0;
			registers[17] <= 0;
			registers[18] <= 0;
			registers[19] <= 0; 
			registers[20] <= 0; 
			registers[21] <= 0; 
			registers[22] <= 0; 
			registers[23] <= 0; 
			registers[24] <= 0;
			registers[25] <= 0;
			registers[26] <= 0;
			registers[27] <= 0;
			registers[28] <= 0;
			registers[29] <= 0;
			registers[30] <= 0;
			registers[31] <= 0;
		end
      else  
			if((regWrite)&& (~(WriteRegister == (5'b0))))
				registers[WriteRegister] <= WriteData;
   end
		
endmodule 
