`timescale 1ns/1ps
module ALUcontrol_tb;
	reg [2:0] ALUop;
	reg [5:0] funct;
	wire [3:0] ALUout;
	
	ALUcontrol aluControl(
    .ALUop(ALUop),
    .funct(funct),
    .ALUout(ALUout)
   );
	
	initial begin
		ALUop = 3'b000; //load and store (add)
		funct = 6'bxxxxxx;
		
		#10 ALUop = 3'b001; //  branch
		#10 ALUop = 3'b011; //  ori
		#10 ALUop = 3'b100; //  andi
		
		// R-Format
		#10 ALUop = 3'b010; funct = 6'b100000; //  add 
		#10 ALUop = 3'b010; funct = 6'b100001; // and unsigned 
		#10 ALUop = 3'b010; funct = 6'b100100; //  and 
		#10 ALUop = 3'b010; funct = 6'b100010; // sub
		#10 ALUop = 3'b010; funct = 6'b100011; // sub unsigned
		#10 ALUop = 3'b010; funct = 6'b000000; // sll
		#10 ALUop = 3'b010; funct = 6'b000010; // srl
		#10 ALUop = 3'b010; funct = 6'b100111; // NOR
		#10 ALUop = 3'b010; funct = 6'b100110; // XOR
		#10 ALUop = 3'b010; funct = 6'b100101; // OR
		#10 ALUop = 3'b010; funct = 6'b101010; // slt 
		#10
		
		
		
		$finish;
	end
endmodule