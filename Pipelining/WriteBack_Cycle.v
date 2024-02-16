module WriteBack_Cycle(
	input mem_ToReg, JumpAndLink /*jump*/ ,
   input [31:0] loadData,AluResult,
	input [4:0] Pc_WB /*jump*/, RegisterDestination ,

	output [4:0] Rdfinal , /*jump*/
	output [31:0] wB_Data
);


wire [31:0] mux1out ; /*jump*/

//output [4:0] Rd ;        i can take these outputs from the output of 
//output regWriteWB_out ;	memory cycle output (MEM/WB register output).

Mux2_to1 writeBack_Mux(AluResult,loadData,mem_ToReg,mux1out/*jump*/);

Mux2_to1 JAL_Mux(mux1out,{27'd0,Pc_WB} + 32'd1,JumpAndLink,wB_Data); /*jump*/

Mux2_to1 WriteRegisterAddress(RegisterDestination,5'b11111,JumpAndLink,Rdfinal); /*jump*/
defparam WriteRegisterAddress.n = 5 ;


endmodule 