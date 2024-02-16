module Memory_Cycle(
    input clk,reset,MemRead_M, MemToReg_M, MemWrite_M, RegWrite_M, JumpAndLink/*jump*/ ,
    input [31:0] AluResult_M, ReadData2_M,
    input [4:0] RegisterD_M, Pc_M /*jump*/ ,
    
    output reg mem_ToReg, regWrite, JumpAndLink_WB /*jump*/,          
    output reg [31:0] loadData, AluResult,  
    output reg [4:0] RegisterD , Pc_WB /*jump*/ ,
	 output [31:0] ALU_Result_Mout 
	 );

assign ALU_Result_Mout = AluResult_M ;
	 
wire [31:0] dataLoad;

//module Data_Memory(clk,Addr,WriteData,MemRead,MemWrite,ReadData);
//Data_Memory Data_mem(clk,AluResult_M,ReadData2_M,MemRead_M,MemWrite_M,dataLoad);


datamem1 data_memory(AluResult_M[4:0],~clk,ReadData2_M,MemWrite_M,dataLoad);


always@(posedge clk)begin
	if(reset)begin
		mem_ToReg <= 0 ;
		regWrite <=  0 ;
		loadData <=  0 ;
		AluResult<=  0 ;
		RegisterD<=  0 ;
		JumpAndLink_WB <= 0 ; /*jump*/
		Pc_WB <= 0 ; /*jump*/
	end else begin
		mem_ToReg<=MemToReg_M ;
		regWrite<=RegWrite_M ;
		loadData<=dataLoad;
		AluResult<=AluResult_M;
		RegisterD<=RegisterD_M;
		JumpAndLink_WB <= JumpAndLink ; /*jump*/
		Pc_WB <= Pc_M ;	/*jump*/
	end	
end


endmodule 
