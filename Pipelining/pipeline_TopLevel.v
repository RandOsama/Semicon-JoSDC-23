module pipeline_TopLevel(MAX10_CLK1_50 , reset,Pc_D);
input  MAX10_CLK1_50 , reset ;
output Pc_D;

pll1	pll1_inst (
	.inclk0 ( MAX10_CLK1_50 ),
	.c0 ( clk )
	);

wire clk;
//(_D) : output of F_Cycle (in decode cycle)
wire [31:0] instruction_D  ; 
wire Branch_Dout,bne_Dout; // these signals come from control unit (output in same cycle without clock)
wire [5:0] Op_D, functI_D;
wire [4:0] rs1_D, rs2_D, rd_D, shamt_D;
wire [15:0] imm_D;

wire [31:0] targetAddress_D ;
wire [4:0] Pc_Dout ,Pc_D;
wire [5:0] opcode_D ;
wire prediction_D , hit_D ;
wire [3:0] GHR_value_D ;
wire [5:0] opcode_Dout ;


//(_E) : output of D_Cycle (in Excute Cycle)
wire [31:0] Read_Data1_E ,Read_Data2_E ,imm_E  ; 
wire [4:0] rs1_E ,rs2_E, RegDistination_E , shamt_E ;
wire [4:0] RegDistination_Eout ;/* output of the mux that select the correct register destination according to the control signal RegDst
											  to use in hazard detiction unit*/
wire [5:0] funct_E ;
wire /*jump*/JumpAndLink_E,branch_E, MemRead_E, MemWrite_E, RegWrite_E, bne_E, RegDst_E, MemToReg_E,ALUSrc_E ;
wire [2:0] ALUop_E;
wire [4:0] Pc_E ;
wire [3:0] Pc_Xor_GR_E ;
wire stall_E ,hit_E ,real_Value_E,prediction_E ;


//(_M) : output of E_Cycle (in Memory Cycle)
wire  MemRead_M, MemToReg_M, MemWrite_M, RegWrite_M,JumpAndLink_M/*jump*/;
wire [31:0] AluResult_M, ReadData2_M;
wire [4:0] RegDistination_M ,Pc_M /*jump*/;

wire [31:0] ALU_Result_Mout ;


//(_WB) : output of M_Cycle (in WB Cycle)
wire MemToReg_WB, RegWrite_WB , JumpAndLink_WB/*jump*/ ;          
wire [31:0] loadData_WB, AluResult_WB ;  
wire [4:0] RegDistination_WB ;


// (_WB) : output of Write back cycle without clock  
wire [31:0]wB_Data_final; 
wire [4:0] Pc_WB ; /*jump*/
wire [4:0] Rdfinal ; /*jump*/



//HDU wires 
wire stall_HDU, pcwrite_HDU, IF_ID_write_HDU , flush ,flush_hit , selectCorrectTarget , selectCorrectPcPlus1 ,select_hit ;

//foeward wires 
wire [1:0] ForwardA, ForwardB;
wire ForwardRs1, ForwardRs2;


// is branch wires 
wire [5:0] R31_Ex ;  /*jump*/
wire flush_JRout, rtype_E;   /*jump*/


// sim
//wire hit ,Hit_ifReadFromE;
//wire [31:0] BTB_wire_mem_F,BTB_wire_mem_E;

// fetch Cycle :-->

fetch_Cycle F_c(clk,reset,IF_ID_write_HDU,pcwrite_HDU,real_Value_E ,branch_E,bne_E,
						flush ,flush_hit , selectCorrectTarget , selectCorrectPcPlus1 ,select_hit,
						targetAddress_D , 
						R31_Ex , /*jump*/
						funct_E,	/*jump*/	
						rtype_E,
	
						
						flush_JRout , /*jump*/
						Pc_Dout , Pc_E ,
						opcode_Dout , 
						Pc_Xor_GR_E ,
						prediction_D  , hit_D ,
						GHR_value_D ,
						Pc_D ,
						instruction_D//,
						//hit ,Hit_ifReadFromE,
						//BTB_wire_mem_F,BTB_wire_mem_E
						) ;
						 

// Decode Cycle :-->

assign Op_D = instruction_D[31:26];
assign functI_D = instruction_D[5:0];
assign rs1_D = instruction_D[25:21];
assign rs2_D = instruction_D[20:16];
assign rd_D = instruction_D[15:11];
assign shamt_D = instruction_D[10:6];
assign imm_D = instruction_D[15:0];

Decode_Cycle D_c(
					clk, reset,RegWrite_WB ,stall_HDU, flush , flush_hit, hit_D,prediction_D ,
					flush_JRout , /*jump*/
					Op_D , functI_D , 
					rs1_D, rs2_D, rd_D,shamt_D,Rdfinal,
					Pc_D ,
					GHR_value_D ,
					wB_Data_final,AluResult_M ,
					imm_D,
					ForwardRs1, ForwardRs2,
    
					Pc_Dout ,
					targetAddress_D ,
					Read_Data1_E, Read_Data2_E, imm_E,
					rs1_E,rs2_E, RegDistination_E,shamt_E,
					Pc_E , // to use in BTB 
					Pc_Xor_GR_E , // to use in PHT 
					funct_E, 
					R31_Ex ,/*jump*/
					opcode_Dout , 
					JumpAndLink_E/*jump*/,branch_E, MemRead_E, MemWrite_E, RegWrite_E, bne_E, RegDst_E, MemToReg_E,ALUSrc_E, stall_E ,hit_E ,real_Value_E,prediction_E,
					ALUop_E,
					Branch_Dout,bne_Dout,
					rtype_E
	 );




	 
// Excuation Cycle :-->

Excuation_Cycle E_c(
					clk,reset, MemRead_E, MemWrite_E, RegWrite_E, RegDst_E, MemToReg_E,ALUSrc_E,JumpAndLink_E/*jump*/ ,
					ForwardA, ForwardB,  
					ALUop_E,
					RegDistination_E,shamt_E, Pc_E ,
					funct_E, 
					Read_Data1_E, Read_Data2_E, rs2_E, imm_E, wB_Data_final, ALU_Result_Mout,
     
    
   
					MemRead_M, MemToReg_M, MemWrite_M, RegWrite_M, JumpAndLink_M /*jump*/,
					AluResult_M, ReadData2_M,
					RegDistination_M ,Pc_M /*jump*/,
					RegDistination_Eout
);	 

// Memory Cycle :-->
Memory_Cycle M_c(
					clk,reset, MemRead_M, MemToReg_M, MemWrite_M, RegWrite_M,JumpAndLink_M /*jump*/,
					AluResult_M, ReadData2_M,
					RegDistination_M, Pc_M /*jump*/,
    
					MemToReg_WB, RegWrite_WB, JumpAndLink_WB /*jump*/,         
					loadData_WB, AluResult_WB,  
					RegDistination_WB, Pc_WB /*jump*/ ,
					ALU_Result_Mout 
	 );

	 
	 
// Write Back Cycle :-->

WriteBack_Cycle WB_c(
					MemToReg_WB, /*jump*/JumpAndLink_WB,
					loadData_WB, AluResult_WB,
					Pc_WB /*jump*/, RegDistination_WB ,
					
					Rdfinal , /*jump*/
					wB_Data_final
);	



// HDU :-->
Hazard_Detection_Unit HD_u(
				  RegDistination_Eout, rs1_D, rs2_D,
			     MemRead_E,Branch_Dout,bne_Dout,stall_E,MemRead_M,prediction_E ,real_Value_E ,branch_E,bne_E,
				  hit_E ,
				  stall_HDU, pcwrite_HDU, IF_ID_write_HDU ,
				  flush ,flush_hit , selectCorrectTarget , selectCorrectPcPlus1 ,select_hit 
);


// Forwarding unit :-->
forwarding_Unit F_u(
				  RegDistination_M, RegDistination_WB, rs1_E, rs2_E,rs1_D, rs2_D,
				  RegWrite_M, RegWrite_WB, Branch_Dout,bne_Dout ,
				  ForwardA, ForwardB,
				  ForwardRs1, ForwardRs2
);

endmodule