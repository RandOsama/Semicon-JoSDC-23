module Control_pip(Op,RegDst,Branch,MemRead,MemToReg,ALUop,MemWrite,ALUSrc,RegWrite,bne,zeroEX_Selector, JumpAndLink,rType);
		input [5:0] Op;
		output reg Branch,RegDst,MemToReg,MemRead,MemWrite,RegWrite , bne, zeroEX_Selector , JumpAndLink ;
		output reg ALUSrc ,rType;
		output reg [2:0]ALUop;
		
		always@(*)begin
			JumpAndLink = 1'b0/*jump*/ ;
			zeroEX_Selector = 1'b0;
			RegDst=1'b0;
			Branch=1'b0;
			bne=1'b0;
			MemRead=1'b0;
			MemToReg=1'b0;
			ALUop=3'b000;
			MemWrite=1'b0;
			ALUSrc=1'b0;
			RegWrite=1'b0;
			rType = 1'b0 ;
			case(Op)
				6'b000000:begin // R type							 
							 RegDst = 1'b1;
							 ALUop = 3'b010;
							 RegWrite = 1'b1;
							 rType = 1'b1 ;
							 end
				6'b100011:begin  // load
							 ALUSrc = 1'b1;
							 MemToReg = 1'b1;
							 RegWrite = 1'b1;
							 MemRead = 1'b1;
							 end
				6'b101011:begin // store
							 ALUSrc = 1'b1;
							 MemWrite = 1'b1;
							 end
				6'b000100:begin // beq
							 Branch = 1'b1;
							 ALUop = 3'b001;
							 end
				6'b000101:begin // bne
							 bne =1'b1;
							 ALUop=3'b001;
							 end
				6'b001100:begin // andi
							 ALUSrc =1'b1;
							 ALUop =3'b100;
							 RegWrite =1'b1;
							 zeroEX_Selector = 1'b1;
							 end
				6'b001000:begin // addi
							 ALUSrc =1'b1;
							 RegWrite =1'b1;
							 end
				6'b001101:begin // ori
							 ALUSrc =1'b1;
							 ALUop =3'b011;
							 RegWrite =1'b1;  
							 zeroEX_Selector = 1'b1;	
							 end
				6'b000011:begin // JAL                                      /*jump*/
							 JumpAndLink = 1'b1 ;
							 RegWrite = 1'b1;	
							 end			 							 
				default : ALUop =3'b001;			 
		endcase
	end
endmodule