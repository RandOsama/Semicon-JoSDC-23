module fetch_Cycle(
		input clk,reset,IF_ID_write,PC_WRite,real_Value_E,branch_E,bne_E,
		input flush ,flush_hit , selectCorrectTarget , selectCorrectPcPlus1 ,select_hit, // from HDU
		input [31:0] targetAddress_D,// from decode cycle to write on BTB
		input [5:0] R31_Ex , /*jump*/
		input [5:0] functJR_E ,	/*jump*/	
		input rtype_E,
	
		output flush_JRout , /*jump*/
		input [4:0]	  Pc_D , Pc_E ,
		input [5:0]   opcode_D ,
		input [3:0]   Pc_Xor_GR_E,
		output reg	  prediction_Reg , hit_Reg ,
		output reg [3:0] GHR_value_Reg ,
		output reg [4:0]   Pc_Reg, // lower 5 bits of pc
		output reg [31:0]  InstrReg//,
		//output hit ,Hit_ifReadFromE,
		//output [31:0] BTB_wire_mem_F,BTB_wire_mem_E
		);


		
		
wire prediction ,hit ;
wire [3:0] GHR_value ;

wire [31:0] BTB_wire_mem_E , BTB_wire_mem_F ;  
wire [31:0] pcTarget_wire , pc_pluc1_wire ;
wire [31:0] pcNext ;
wire [31:0] instruction ;
wire [31:0] pcwire1; /*jump*/

//is jump wires 
wire [31:0] TargetAddress_jump ;   /*jump*/
wire jumpSelector ,flush_JR;       /*jump*/ 

wire Hit_ifReadFromE ; //hit wires (hit is bit from BTB to determine if this location has address or not)
wire finalHit = (select_hit) ? Hit_ifReadFromE : hit ;

wire PcMux_select = (prediction && finalHit ) || flush_hit ||  selectCorrectTarget ;

reg[31:0] pcTop ;



                                     
												 /*jump*/

is_jump isJUMP(instruction ,R31_Ex ,functJR_E, rtype_E,TargetAddress_jump , jumpSelector ,flush_JR);


assign flush_JRout = flush_JR ; /*jump*/

//Mux2_to1(x,y,S,out);
Mux2_to1 Pc_SelectCorrectPcPlus1(pcTop + 32'd1,{27'd0,Pc_E} + 32'd1 ,selectCorrectPcPlus1,pc_pluc1_wire);
Mux2_to1 Pc_SelectCorrectTarget(BTB_wire_mem_F,BTB_wire_mem_E,selectCorrectTarget,pcTarget_wire);
Mux2_to1 Pc_Mux1(pc_pluc1_wire,pcTarget_wire,PcMux_select,pcwire1/*jump*/);

Mux2_to1 Pc_Mux(pcwire1,TargetAddress_jump,(jumpSelector && !flush_hit && !flush && !flush_JR),pcNext); /*jump*/


//Global_History_Register(clk , reset , realValue_E, branch_E, bne_E, GHR_value);
Global_History_Register GHR_module(clk , reset , real_Value_E,branch_E,bne_E, GHR_value);

//Branch_Target_Buffer(clk,reset,opcode , Pc_F ,Pc_D , Pc_E,Target_Addrs_D , hit ,hit_ifReadfromE, Target_Addrs_F,Target_Addrs_E_out);
Branch_Target_Buffer BTb(clk,reset, opcode_D ,
								pcTop[4:0] ,Pc_D , Pc_E, targetAddress_D ,
								hit ,Hit_ifReadFromE, BTB_wire_mem_F,
								BTB_wire_mem_E);

//Direction_Predictor(clk,reset,branch_E, bne_E ,real_Value_E, opcode_F ,Pc_F,GHR_f,Pc_Xor_GR_E,prediction);
Direction_Predictor PHTable(clk,reset,branch_E, bne_E ,real_Value_E, instruction[31:26] ,pcTop[4:0] , GHR_value,Pc_Xor_GR_E,prediction);



always@(posedge clk)begin 
	if (reset)
		pcTop <= 0;
	else if(PC_WRite)begin 
		pcTop<=pcNext;
	end
end 

//Inst_mem(addr,Inst);
Inst_mem InstructionMemory(pcTop,instruction);

//instmem Inst(pcTop, ~clk, instruction);




always@(posedge clk)begin
	if(reset == 1 || flush == 1 || flush_hit == 1 || flush_JR == 1 /*jump*/)begin
		InstrReg <= 32'd0;
		prediction_Reg <= 1'b0;
		hit_Reg <= 1'b0;
		GHR_value_Reg <= 4'b0000 ; 
		Pc_Reg <= 5'b00000 ;
	end else if(IF_ID_write)begin
		InstrReg <= instruction;
		prediction_Reg <= prediction ;
		hit_Reg <= hit;
		GHR_value_Reg <= GHR_value ; 
		Pc_Reg <= pcTop[4:0] ;	
	end


end


endmodule 