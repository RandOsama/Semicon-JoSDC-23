module Control(Op,funct,RegDst,Branch,MemRead,MemToReg,ALUop,MemWrite,ALUSrc,RegWrite,bne,jump,jumpReg);
		input [5:0] Op;
		input [5:0] funct; // Inst[0:5] , to implement jr instruction 
		output reg Branch,MemRead,MemWrite,RegWrite , bne ,jump,jumpReg;
		output reg [1:0]RegDst,MemToReg,ALUSrc;
		output reg [2:0]ALUop;
		
		
		always@(*)begin
			jumpReg<=1'b0;jump<=1'b0;RegDst<=2'b00;Branch<=1'b0;bne<=1'b0;MemRead<=1'b0;MemToReg<=2'b00;ALUop<=3'b000;MemWrite<=1'b0;ALUSrc<=2'b00;RegWrite<=1'b0;
			case(Op)
				6'b000000:begin // R type
							 case(funct)
							 6'b001000 : jumpReg<=1'b1; 
							 default:
							 begin
							         RegDst<=2'b01;
										ALUop<=3'b010;
										RegWrite<=1'b1;
							 end 
							 endcase
							 end
				6'b100011:begin  // load
							 ALUSrc<=2'b01;
							 MemToReg<=2'b01;
							 RegWrite<=1'b1;
							 MemRead<=1'b1;
							 end
				6'b101011:begin // store
							 ALUSrc<=2'b01;
							 MemWrite<=1'b1;
							 end
				6'b000100:begin // beq
							 Branch<=1'b1;
							 ALUop<=3'b001;
							 end
				6'b000101:begin // bne
							 bne<=1'b1;
							 ALUop<=3'b001;
							 end
				6'b001100:begin // andi
							 ALUSrc<=2'b10;
							 ALUop<=3'b100;
							 RegWrite<=1'b1;
							 end
				6'b001000:begin // addi
							 ALUSrc<=2'b01;
							 RegWrite<=1'b1;   
							 end
				6'b001101:begin // ori
							 ALUSrc<=2'b10;
							 ALUop<=3'b011;
							 RegWrite<=1'b1;    
							 
							 end
				6'b000011:begin // JAL 
						    MemToReg<=2'b10;
							 jump <= 1'b1;
							 RegWrite<=1'b1;
							 RegDst<=2'b10;
							 end
				6'b000010:begin // JUMP 
							 jump <= 1'b1;
							 end			 
				default : ALUop<=3'b001;			 
		endcase
	end
endmodule
