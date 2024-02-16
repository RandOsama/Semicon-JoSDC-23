`timescale 1ns/1ps
module Single_Cycle_TopLevel_tb;
	reg clk,reset;
		
	wire [31:0] pcTop, inst;
	wire [5:0] Op,funct;
	wire [2:0] ALUop;
	wire [1:0] RegDst,MemToReg;
	wire MemRead,MemWrite,RegWrite;
	wire [1:0] ALUSrc;
	wire Branch,bne,jump,jumpReg;
	wire [4:0] writeRegisterNum;
	
	
	wire [31:0]write_data_RF;
	wire [4:0] rs1,rs2;
	wire [31:0] ReadData1,ReadData2,ALU_data2;
	wire [3:0] ALUout;
	wire shamt;
	wire [31:0] ALU_result;
	wire ZeroF ;
	wire [31:0] target_address,pc_next;
	
	
	Single_Cycle_TopLevel ss(
		.reset(reset),
		.clk(clk)
	);
	
	assign pcTop = ss.pcTop;
	assign inst = ss.inst;
	assign Op = ss.Op;
	assign funct = ss.funct;
	assign RegDst = ss.RegDst;
	assign MemRead = ss.MemRead;
	assign MemToReg = ss.MemToReg;
	assign ALUop = ss.ALUop;
	assign MemWrite = ss.MemWrite;
	assign ALUSrc = ss.ALUSrc;
	assign RegWrite = ss.RegWrite;
	assign Branch = ss.Branch;
	assign bne = ss.bne;
	assign jump = ss.jump;
	assign jumpReg = ss.jumpReg;
	
	assign writeRegisterNum = ss.writeRegisterNum;
 	assign write_data_RF = ss.write_data_RF;
	assign rs1 = ss.rs1;
	assign rs2 = ss.rs2;
	assign ReadData1 = ss.ReadData1;
	assign ReadData2 = ss.ReadData2;
	assign ALU_data2 = ss.ALU_data2;
	assign ALUout = ss.ALUout;
	assign shamt = ss.shamt;
	assign ALU_result = ss.ALU_result;	
	assign ZeroF = ss.ZeroF;
	assign target_address = ss.target_address;
	assign pc_next = ss.pc_next;
	
	always #5 clk = ~clk;
	
	
	
	initial begin
		clk = 0;
		reset = 1;
		#10 reset = 0;
		
		#3300 reset = 0;
		
		$finish;
	end
	 
	 
	initial begin
		$monitor("Time %0t: Register[1] = %h ", $time, ss.Rf.mem[1]);
	end
		
endmodule