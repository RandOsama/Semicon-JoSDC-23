`timescale 1ns/1ps
module TestBench;

	reg clk, reset;
	
	//Fetch
	wire [31:0]instruction_D;
	wire [4:0] rs1_D, rs2_D;
	wire [15:0] imm_D;
	wire flush, flush_hit, flush_JRout, selectCorrectPcPlus1;
	wire IF_ID_write_HDU;
	
	//Decode
	wire [4:0] Pc_D;
	wire stall_HDU;
	wire [31:0] Read_Data1_E ,Read_Data2_E;
	
	wire RegWrite_WB, ForwardRs1, ForwardRs2;
	
	
	//ex
	wire [4:0] Pc_E;
	wire [1:0] ForwardA, ForwardB;
	wire ALUSrc_E, RegDst_E, RegWrite_E;
	wire [2:0] ALUop_E;
	wire real_Value_E,branch_E,bne_E,selectCorrectTarget,prediction_E;
	//wire [5:0] targetAddress_E;
	//Memory
	wire [4:0] Pc_M;
	wire MemRead_M, MemWrite_M;
	wire [31:0] loadData_WB, AluResult_WB ; 
	
	//WB
	wire [4:0] Pc_WB;
	wire MemToReg_WB;
	wire [4:0] Rdfinal ;
	wire [31:0]wB_Data_final;
	
	
	assign instruction_D = pip.instruction_D;
	//assign Op_D = pip.Op_D;
	assign rs1_D = pip.rs1_D;
	assign rs2_D = pip.rs2_D;
	//assign rd_D = pip.rd_D;
	assign imm_D = pip.imm_D;
	assign stall_HDU = pip.stall_HDU;
	assign flush = pip.flush;
	
	assign flush_hit = pip.flush_hit;
	assign flush_JRout = pip.flush_JRout;
	assign selectCorrectPcPlus1 = pip.selectCorrectPcPlus1;
	assign IF_ID_write_HDU = pip.IF_ID_write_HDU;
	
	assign Pc_D = pip.Pc_D;
	assign Read_Data1_E = pip.Read_Data1_E;
	assign Read_Data2_E = pip.Read_Data2_E;
	assign RegWrite_WB = pip.RegWrite_WB;
	assign ForwardRs1 = pip.ForwardRs1;
	assign ForwardRs2 = pip.ForwardRs2;
	assign Pc_E = pip.Pc_E;
	assign ALUSrc_E = pip.ALUSrc_E;
	assign RegDst_E = pip.RegDst_E;
	assign RegWrite_E = pip.RegWrite_E;
	assign ALUop_E = pip.ALUop_E;
	assign real_Value_E = pip.real_Value_E;
	assign branch_E = pip.branch_E;
	assign bne_E = pip.bne_E;
	assign selectCorrectTarget = pip.selectCorrectTarget;
	assign prediction_E = pip.prediction_E;
	//sassign targetAddress_E = pip.targetAddress_E;
	assign ForwardA = pip.ForwardA;
	assign ForwardB = pip.ForwardB;
	assign Pc_M = pip.Pc_M;
	assign MemRead_M = pip.MemRead_M;
	assign MemWrite_M = pip.MemWrite_M;
	assign loadData_WB = pip.loadData_WB;
	assign AluResult_WB = pip.AluResult_WB;
	assign Pc_WB = pip.Pc_WB;
	assign MemToReg_WB = pip.MemToReg_WB;
	assign Rdfinal = pip.Rdfinal;
	assign wB_Data_final = pip.wB_Data_final;
	
	
	pipeline_TopLevel pip(clk , reset);
	
	
	initial begin
	
		reset = 1'b1;
		
		#2 reset = 1'b0;
		
	end
	
	initial begin
	
		clk = 1'b0;
	
		forever #1 clk = ~clk;
	
	end
	
	initial # 1400 $finish;
	initial begin
		$monitor("Time %0t: Register[8] = %h ", $time, pip.D_c.rf.mem[8]);
	end


endmodule
