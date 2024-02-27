module Decode_Cycle(
	 input clk,reset, RegWrite_wb, stall,flush , flush_hit, hit,prediction,
	 input flush_JR , /*jump*/
    input [5:0] Op, functI,
    input [4:0] rs1_F, rs2_F, rd_F, shamtI,regDestination_forWriting,
	 input [4:0] pc,
	 input [3:0] GHR_value ,
    input [31:0] writeData_WB, dataForForwarding_MEM,
    input [15:0] imm,
	 input Foraward_Rs1,Foraward_Rs2,/**/
    
	 output [4:0] Pc_Dout ,
	 output [31:0]	targetAddress,							
    output reg [31:0] Read_Data1_D, Read_Data2_D, imm_D ,
    output reg [4:0] rs1_d,rs2_d, RegDistination , shamt,
	 output reg [4:0] pc_Reg ,
	 output reg [3:0] Pc_Xor_GR ,
    output reg [5:0] funct, 
	 output reg [5:0] R31_Ex , /*jump*/
	 output [5:0] opcode_D ,
    output reg JumpAndLink_E /*jump*/ ,Branch, MemRead, MemWrite, RegWrite, bne, RegDst, MemToReg,ALUSrc,stallreg ,hit_Reg ,real_Value,prediction_Reg,
    output reg [2:0] ALUop,
	 output  Branch_D_out ,bne_D_out, // for HDU :stall number 2 in case the instruction before branch is load
	 output reg rtype_E
	 );

	assign Pc_Dout = pc ;
	assign opcode_D = Op ;
	
	
	
	wire [31:0] rd1,rd2,SE_imm,ZeroExt_imm , imm_E ,out_mux1 ,out_mux2;
	wire Branch_D,MemRead_D,MemWrite_D,RegWrite_D ,RegDst_D,MemToReg_D,bne_D ,zeroEX_Selector , JumpAndLink_D ;  // (_D) mean Decode stage
	wire ALUSrc_D;
	wire [2:0]ALUop_D;

	
	


	
	reg realValueWire ;
	
	
	
	//Adder32(x,y,out);
	Adder32 tagetAddressAdder({27'd0,pc}+ 32'd1,SE_imm,targetAddress);
	
	
	Register_File rf(clk,reset,rs1_F, rs2_F, regDestination_forWriting ,writeData_WB,RegWrite_wb,rd1, rd2);
	
	//module Control_pip(Op,RegDst,Branch,MemRead,MemToReg,ALUop,MemWrite,ALUSrc,RegWrite,bne,zeroEX_Selector, JumpAndLink);
	Control_pip Cu(Op,RegDst_D,Branch_D,MemRead_D,MemToReg_D,ALUop_D,MemWrite_D,ALUSrc_D,RegWrite_D,bne_D,zeroEX_Selector,JumpAndLink_D,rtype);
	
	assign Branch_D_out = Branch_D;
	assign bne_D_out = bne_D ;
	
	//forward rs1 mux
	Mux2_to1 forward_rs1(rd1,dataForForwarding_MEM,Foraward_Rs1,out_mux1);
	
	//forward rs2 mux
	Mux2_to1 forward_rs2(rd2,dataForForwarding_MEM,Foraward_Rs2,out_mux2);
	
	
	always @(*)begin
		if( ((out_mux1==out_mux2) && Branch_D) || ((out_mux1!=out_mux2) && bne_D) )
			realValueWire = 1'b1;
		else 
			realValueWire = 1'b0;
	end
	
	//module sign_extention(x,y);
	sign_extention SE_o(imm,SE_imm);

	//module Zero(x,y);  
	Zero ZeroExt(imm,ZeroExt_imm);
	
	Mux2_to1 imm_mux(SE_imm,ZeroExt_imm,zeroEX_Selector,imm_E);
	

	
	always@(posedge clk)begin 
			if(stall) begin
				real_Value <= 0;
				Read_Data1_D <= 0;
				Read_Data2_D <= 0;
				imm_D <= 0;
				rs1_d <= 0 ;
				rs2_d <= 0;
				RegDistination <= 0;
				funct <= 0;
				shamt <= 0;
				RegDst<=0;
				Branch<=0;
				MemRead<=0;
				MemToReg<=0;
				ALUop <= 0;
				MemWrite<=0;
				ALUSrc<= 0;
				RegWrite<= 0; 
				bne<= 0;
				JumpAndLink_E <= 0 ; /*jump*/
				pc_Reg <= 0 ;
				Pc_Xor_GR <= 0 ;
				hit_Reg <= 0 ;
				prediction_Reg <= 0 ;
				R31_Ex <= 0 ;
			end
			else if(reset || flush || flush_hit || flush_JR /*jump*/)begin
				real_Value <= 0;
				stallreg <= 0 ;
				Read_Data1_D <= 0;
				Read_Data2_D <= 0;
				imm_D <= 0;
				rs1_d <= 0 ;
				rs2_d <= 0;
				RegDistination <= 0;
				funct <= 0;
				shamt <= 0;
				RegDst<=0;
				Branch<=0;
				MemRead<=0;
				MemToReg<=0;
				ALUop <= 0;
				MemWrite<=0;
				ALUSrc<= 0;
				RegWrite<= 0; 
				bne<= 0;
				JumpAndLink_E <= 0 ; /*jump*/
				pc_Reg <= 0 ;
				Pc_Xor_GR <= 0 ;
				hit_Reg <= 0 ;
				prediction_Reg <= 0 ;
				R31_Ex <= 0 ;

		end else begin
				prediction_Reg <= prediction ;
				hit_Reg <= hit ;
				Pc_Xor_GR <= pc[3:0] ^ GHR_value ;
				pc_Reg <= pc ;
				real_Value <= realValueWire;
				stallreg <= stall ;
				Read_Data1_D <= rd1;
				Read_Data2_D <= rd2;
				imm_D <= imm_E;
				rs1_d <= rs1_F ;
				rs2_d <= rs2_F;
				R31_Ex <= rd1 [4:0] ;  /*jump*/
				RegDistination <= rd_F; 
				funct <= functI;
				shamt <= shamtI;
				RegDst <= RegDst_D;
				Branch <= Branch_D;
				MemRead <= MemRead_D;
				MemToReg<= MemToReg_D;
				ALUop <= ALUop_D;
				MemWrite<= MemWrite_D;
				ALUSrc<= ALUSrc_D;
				RegWrite<= RegWrite_D; 
				bne<= bne_D;
				JumpAndLink_E <= JumpAndLink_D;  /*jump*/
				rtype_E <= rtype;
		end
	end
		

endmodule 