module Excuation_Cycle(
    input clk,reset, MemRead, MemWrite, RegWrite, RegDst, MemToReg,ALUSrc, JumpAndLink /*jump*/ ,
    input [1:0] ForwardA, ForwardB,
	 input [2:0] ALUop,
	 input [4:0] RegDistination,shamt, Pc_E ,
	 input [5:0] funct, 
    input [31:0] Read_Data1_D, Read_Data2_D, input [4:0] rs2_d,input [31:0] imm, writeBData, writeDatamemstage,
     
    
    output reg MemRead_Ex, MemToReg_Ex, MemWrite_Ex, RegWrite_Ex, JumpAndLink_M /*jump*/ ,
    output reg [31:0] AluResult, ReadData2_EX,
    output reg [4:0] RegisterD_EX , Pc_M /*jump*/,
	 output [4:0] RegDistination_E
);



wire [31:0] Alusrc1 ,rd2 ,Alusrc2 , result ;
wire [3:0] ALUout ;
wire [4:0] finalDestination ;

//Mux3to_1_d(x,y,z,S,out);
Mux3to_1_d ForwardAMux(Read_Data1_D,writeBData,writeDatamemstage,ForwardA,Alusrc1);

Mux3to_1_d ForwardBMux(Read_Data2_D,writeBData,writeDatamemstage,ForwardB,rd2);

Mux2_to1 RandIdea(rd2,imm,ALUSrc,Alusrc2);
//Mux3to_1_d alusrc2mux(rd2,SE_imm_D,ZeroExt_imm_D,ALUSrc,Alusrc2);

//module ALUcontrol(ALUop,funct,ALUout);
ALUcontrol Alucontrol(ALUop,funct,ALUout);

//module Alu(shamt,x,y,ALUout,ZeroF,result);
Alu alu(shamt,Alusrc1,Alusrc2,ALUout,,result);

//module Mux2_to1(x,y,S,out);
Mux2_to1 muxRegDst(rs2_d,RegDistination,RegDst,finalDestination);
defparam muxRegDst.n = 5 ;

assign RegDistination_E = finalDestination ;


always@(posedge clk)begin

	if(reset)begin
		MemRead_Ex <= 0;
		MemToReg_Ex<= 0;
		MemWrite_Ex<= 0;
		RegWrite_Ex<= 0;
		AluResult  <= 0;
		ReadData2_EX<=0;
		RegisterD_EX<=0;
		JumpAndLink_M <= 0 ; /*jump*/
		Pc_M <= 0 ; /*jump*/
	end else begin 
		MemRead_Ex<=MemRead;
		MemToReg_Ex<=MemToReg;
		MemWrite_Ex<=MemWrite;
		RegWrite_Ex<=RegWrite;
		AluResult<=result;
		ReadData2_EX<=rd2;
		RegisterD_EX<=finalDestination;
		JumpAndLink_M <= JumpAndLink ; /*jump*/
		Pc_M <= Pc_E; /*jump*/
	end
end 







endmodule 