`timescale 1ns/1ps
module Registers_tb;

	reg [4:0] Rr1, Rr2, WriteRegister;
	reg [31:0] WriteData;
	reg regWrite ,clk;
	wire [31:0] Rd1,Rd2;
	
	Registers register (
		.clk(clk),
		.Rr1(Rr1),
		.Rr2(Rr2),
		.WriteRegister(WriteRegister),
		.WriteData(WriteData),
		.regWrite(regWrite),
		.Rd1(Rd1),
		.Rd2(Rd2)
	);
	
	always 
		begin
			#5 clk = ~clk;
		end
		
	initial begin
		clk = 0;
		Rr1 = 5'b00011; // 3
		Rr2 = 5'b00010; // 2
		WriteData = 32'h00000002;
		WriteRegister = 5'b00001;
		regWrite = 1;
		#10 
		WriteData = 32'h00000003;
		WriteRegister = 5'b00010;
		#10
		regWrite = 0;
		Rr1 = 5'b00010;
		Rr2 = 5'b00001;
		WriteData = 32'h00000005;
		WriteRegister = 5'b01001;
		#10 
		regWrite = 1;
		WriteData = 32'h0000000F;
		WriteRegister = 5'b00011;
		#10 
		WriteData = 32'h0000000B;
		WriteRegister = 5'b00001;
		
		#10
		regWrite = 0;
		Rr1 = 5'b00001;
		Rr2 = 5'b00011;
		WriteData = 32'h00000005;
		WriteRegister = 5'b01001;
		#10
		$finish;
	end
	
endmodule