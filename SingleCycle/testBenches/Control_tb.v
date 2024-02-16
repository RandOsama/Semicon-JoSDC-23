`timescale 1ns/1ps
module Control_tb;
	reg [5:0] Op;
	reg [5:0] funct;
	wire Branch, MemRead, MemWrite, RegWrite, bne, jump, jumpReg;
	wire [1:0] RegDst,MemToReg,ALUSrc;
	wire [2:0] ALUop;
	
	
	Control con(
    .Op(Op),
    .funct(funct),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .bne(bne),
    .jump(jump),
    .jumpReg(jumpReg),
    .RegDst(RegDst),
    .MemToReg(MemToReg),
    .ALUop(ALUop)
  );
  
	initial begin
		Op = 6'b000000;
		funct = 6'b001000;//JR 
		#10 funct = 6'bXXXXXX; // R-type default
		#10 Op = 6'b100011;// load
		#10 Op = 6'b101011; // store
		#10 Op = 6'b000100; // beq
		#10 Op = 6'b000101; // bne
		#10 Op = 6'b001100; // andi 
		#10 Op = 6'b001000; // addi
		#10 Op = 6'b001101; // ori
		#10 Op = 6'b000011; // JAL
		#10 Op = 6'b000010; // JUMP
		#10 Op = 6'b111111; // default
		#10
		$finish;
		
	end
endmodule