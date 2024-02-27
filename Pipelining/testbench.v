`timescale 1ns/1ps
module testbench;

	reg clk, reset;
	
	wire [31:0] instruction_D, AluResult_M, ALU_Result_Mout,  wB_Data_final;
	
	wire [4:0] Pc_D, Pc_E;
	
	wire [1:0]  ForwardA, ForwardB;
	
	wire IF_ID_write_HDU, RegWrite_WB, flush, flush_hit, flush_JRout, selectCorrectPcPlus1;
	
	wire stall_HDU, real_Value_E, prediction_E, ForwardRs1, ForwardRs2;
	
	assign instruction_D = uut.instruction_D;
	
	assign Pc_D = uut.Pc_D ;
	
	assign IF_ID_write_HDU = uut.IF_ID_write_HDU;
	
	assign RegWrite_WB = uut.RegWrite_WB;
	
	assign AluResult_M = uut.AluResult_M;
	
	assign flush = uut.flush;
	
	assign flush_hit = uut.flush_hit;
	
	assign flush_JRout = uut.flush_JRout;
	
	assign selectCorrectPcPlus1 = uut.selectCorrectPcPlus1;
	
	assign stall_HDU = uut.stall_HDU;
	
	assign ForwardA = uut.ForwardA;
	
	assign ForwardB = uut.ForwardB;
	
	assign ALU_Result_Mout = uut.ALU_Result_Mout;
		
	assign wB_Data_final = uut.wB_Data_final;
	
	assign Pc_E = uut.Pc_E;
	
	assign prediction_E = uut.prediction_E;
	
	assign real_Value_E = uut.real_Value_E;
	
	assign ForwardRs1 = uut.ForwardRs1;
	
	assign ForwardRs2 = uut.ForwardRs2;
	
	pipeline_TopLevel uut(clk , reset);
	
	initial begin
	
		reset = 1'b1;
		
		#2 reset = 1'b0;
		
	end
	
	initial begin
	
		clk = 1'b0;
	
		forever #1 clk = ~clk;
	
	end
	
	initial # 1000 $finish;


endmodule
