module Single_Cycle_TopLevel (MAX10_CLK1_50,reset,pcTop);
input MAX10_CLK1_50,reset ;
output pcTop;
wire clk;

pll1	pll1_inst (
	.inclk0 ( MAX10_CLK1_50 ),
	.c0 ( clk )
	);
	
wire [31:0] ALU_result ,inst, ReadData1 , ALU_data2,
target_address,write_data_RF; 
wire [31:0]  ReadDatamem ,pc_plus_1,SE_imm,ReadData2,
				 pc_next ,ZE_jumpaddrs , ZeroExt_imm,SE_imm_shift2,muxaddrs1,muxaddrs2;
wire [1:0] RegDst,MemToReg ,ALUSrc;
wire [4:0] writeRegisterNum ; 
wire Branch,MemRead,MemWrite,RegWrite,bne,jump,jumpReg,ZeroF ;
wire [2:0] ALUop;
wire [3:0] ALUout;

wire [15:0]imm;
wire [25:0]jumpImm;
wire [5:0]Op,funct;
wire [4:0]rd,rs2,rs1,shamt;

reg [31:0] pcTop;
always @(posedge reset or posedge clk)
	if (reset)
		pcTop <= 32'h00000000;
	else
		pcTop <= pc_next;

//module Adder32(x,y,out);
Adder32 pc_adder(pcTop,32'd1,pc_plus_1);


//module Inst_mem(addr,Inst);
Inst_mem instruction_memory(pcTop,inst);


assign imm = inst[15:0];
//module sign_extention(x,y);
sign_extention SE_o(imm,SE_imm );



//module Zero(x,y);  
Zero zeroExt(imm,ZeroExt_imm);




assign jumpImm = inst[25:0];
//module Zero(x,y);
Zero jumpaddrs(jumpImm,ZE_jumpaddrs);



//module Adder32(x,y,out);
Adder32 branch_addrs(pc_plus_1,SE_imm,target_address);


assign Op = inst[31:26];
assign funct = inst[5:0];
//module Control(Op,funct,RegDst,Branch,MemRead,MemToReg,ALUop,MemWrite,ALUSrc,RegWrite,bne,jump,jumpReg);
Control control(Op,funct,RegDst,Branch,MemRead,MemToReg,ALUop,MemWrite,ALUSrc,RegWrite,bne,jump,jumpReg);

//module Mux3to_1_d(x,y,z,S,out);

assign rs1 = inst[25:21];
assign rs2 = inst[20:16];
assign rd = inst[15:11];
Mux3to_1_d WR_Mux(rs2,rd,5'b11111,RegDst,writeRegisterNum);
defparam WR_Mux.n=5;



//module Registers(Rr1,Rr2,WriteRegister,regWrite,WriteData,Rd1,Rd2);
Registers Rf(clk,reset,rs1,rs2,writeRegisterNum,RegWrite,write_data_RF,ReadData1,ReadData2);





//module Mux3to_1_d(x,y,z,S,out);
Mux3to_1_d ALU_src_mux(ReadData2,SE_imm ,ZeroExt_imm,ALUSrc,ALU_data2);



//module ALUcontrol(ALUop,funct,ALUout);
ALUcontrol aluControl(ALUop,funct,ALUout);

assign shamt = inst[10:6];
//module Alu(x,y,ALUout,ZeroF,result);
Alu alu(shamt,ReadData1 , ALU_data2 , ALUout, ZeroF, ALU_result);


//branchSelect
wire branchSelect = (~ZeroF && bne) || (ZeroF && Branch) ;

   
//module Data_Memory(Addr,WriteData,MemRead,MemWrite,ReadData);
Data_Memory data_mem(clk,ALU_result,ReadData2,MemRead,MemWrite,ReadDatamem);

//module Mux3to_1_d(x,y,z,S,out);
Mux3to_1_d writeDatamux(ALU_result,ReadDatamem,pc_plus_1,MemToReg,write_data_RF);

//module Mux2_to1(x,y,S,out);
Mux2_to1 branch_or_pcPlus1(pc_plus_1,target_address,branchSelect, muxaddrs1);
Mux2_to1 branch_or_pcPlus1_or_jump(muxaddrs1,ZE_jumpaddrs,jump, muxaddrs2);
Mux2_to1 branch_or_pcPlus1_or_jump_or_jr(muxaddrs2,ReadData1,jumpReg, pc_next);

endmodule 
