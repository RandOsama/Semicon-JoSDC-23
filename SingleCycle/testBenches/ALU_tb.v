`timescale 1ns/1ps

module ALU_tb ;
	reg [31:0] x , y;
	reg [4:0]shamt;
	reg [3:0] ALUout;
	wire ZeroF;
	wire [31:0] result;
	
	Alu a ( 
		.x(x),
		.y(y),
		.shamt(shamt),
		.ALUout(ALUout),
		.ZeroF(ZeroF),
		.result(result)
	);
	
	initial begin
		x = 32'hFFFFFFFF; // and
		y = 32'h00000001; 
		shamt = 5'bxxxxx;
		ALUout= 4'h0;
		// 1
		
		#10
		x = 32'hFFFFFFFF; // or
		y = 32'h00000001;
		ALUout= 4'h1;
		// FFFFFFFF
		
		#10 // add signed
		x = 32'hFFFFFFFC; //-4
		y = 32'h00000003; // 3
		ALUout= 4'h2;
		// -1
		
		#10 // add unsigned
		x = 32'h00000001;
		y = 32'h00000001;
		ALUout = 4'hA;
		// 2
		
		#10 // sub signed
		x = 32'hFFFFFFFC; // -4
		y = 32'h00000008; // 8 
		ALUout= 4'h6;
		// -4
		
		#10 // sub unsigned
		x = 32'h00000004; // 4
		y = 32'h00000002; // 2
		ALUout = 4'hE;
		// 2
		
		#10 // XOR
		x = 32'h00000000;
		y = 32'h00000001;
		ALUout= 4'h5;
		// 1
		
		#10 // NOR
		x = 32'hFFFFFFFF;
		y = 32'h00000001;
		ALUout = 4'hC;
		// 0
		
		#10 // slt
		x = 32'h00000008; // 8
		y = 32'h00000001; // 1
		ALUout= 4'h7;
		// 0 
		
		#10// shift right logical
		x = 32'hxxxxxxxx;
		y = 32'h00000008;
		shamt = 5'b00010;
		ALUout= 4'h8;
		//2
		
		#10 //shift left logical 
		y = 32'h00000002;
		shamt = 5'b00010;
		ALUout = 4'hF;
		//8
		
		#10
		
		$finish;
	end
	
	
endmodule
