module is_jump (input [31:0] Instruction ,
					 input [5:0] R31_Ex ,
					 input [5:0] functJR_E ,
					 input rtype,
					 
					 output reg [31:0] TargetAddress_Jump ,  // from R31 in case the instruction is JR  , or from immediate in case the instruction is JAL or J
					 output reg JumpSelector ,
					 output reg flush_JR);
					 					 

				
	always @(*) begin
		JumpSelector = 1'b0;
		flush_JR = 1'b0 ;
		TargetAddress_Jump = 32'd0 ;
		if(Instruction [31:26] == 6'b000010 || Instruction [31:26] == 6'b000011 || ((functJR_E == 6'b001000) & rtype))
			JumpSelector = 1'b1;
		if((functJR_E == 6'b001000) & rtype)begin
			flush_JR = 1'b1 ;
			TargetAddress_Jump = {26'd0,R31_Ex} ;
		end else if (Instruction [31:26] == 6'b000010 || Instruction [31:26] == 6'b000011)
			TargetAddress_Jump = {6'b000000,Instruction [25:0]} ;	

	end
				
										 
										 

endmodule 