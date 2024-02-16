module Direction_Predictor(clk,reset,branch_E, bne_E ,real_Value_E, opcode_F ,Pc_F,GHR_f,Pc_Xor_GR_E,prediction);
	input clk ,reset  ;
	input branch_E , bne_E ;
	input real_Value_E ; /* this signal come from excuation cycle and this is to test if the two registers is equal or not
	                       we don't take it from decode cycle bcz of the length of the critical path*/
	input [5:0] opcode_F ;							  
	input [3:0] Pc_F , GHR_f ; // to read from the PHT
	input [3:0] Pc_Xor_GR_E ; // to write on the PHT , we caculate the Xor in Decode Cycle and take is from Excuation cycle 
 
	output reg prediction ;
	
	reg [1:0] PHTable [15:0] ;
	wire [3:0]Pc_Xor_GR_F = Pc_F ^ GHR_f ; //read
	
	integer i ;
	
	always @(posedge clk)begin
		if(reset)
			for(i=0 ; i <16 ; i=i+1)
				PHTable [i] <= 2'b10 ; //initialize all entries to weakly Taken  
		else begin 
			if(branch_E || bne_E) begin
				if(real_Value_E)begin
					if(PHTable[Pc_Xor_GR_E] != 2'b11)
						PHTable[Pc_Xor_GR_E] <= PHTable[Pc_Xor_GR_E] + 2'b01 ;end 
				else begin
				   if(PHTable[Pc_Xor_GR_E] != 2'b00)
						PHTable[Pc_Xor_GR_E] <= PHTable[Pc_Xor_GR_E] - 2'b01 ;end
			end	    
	
		end
		
	end
	
	always @(*)begin
	if(opcode_F == 6'd4 || opcode_F == 6'd5)
		case(PHTable[Pc_Xor_GR_F])
			2'b00 :  prediction = 1'b0 ; //predict not taken
			2'b01 :  prediction = 1'b0 ; //predict not taken
			2'b10 :  prediction = 1'b1 ; //predict taken
			2'b11 :  prediction = 1'b1 ; //predict taken
			endcase
	else 
		prediction = 1'b0 ; // go to pc + 1 
	end 

endmodule