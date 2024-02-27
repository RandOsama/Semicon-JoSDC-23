module ALUcontrol(ALUop,funct,ALUout);
		input [2:0] ALUop;
		input [5:0] funct;
		output reg [3:0] ALUout;
		
		always@(*)begin
		case(ALUop)
		3'b000: ALUout <= 4'b0010; // load and store ,the alu function is add so i can use this case to implement addi also  
		3'b001: ALUout <= 4'b0110;  // branch 
		3'b010:case(funct)    // R format 
				 6'b100000: ALUout <= 4'b0010; // add
				 6'b100001: ALUout <= 4'b1010; // add unsigned
				 6'b100100: ALUout <= 4'b0000; // and 
				 6'b100010: ALUout <= 4'b0110; // sub
				 6'b100011: ALUout <= 4'b1110; // sub unsigned 
				 6'b000000: ALUout <= 4'b1111; // sll
				 6'b000010: ALUout <= 4'b1000; // srl
				 6'b100111: ALUout <= 4'b1100; // NOR
				 6'b100110: ALUout <= 4'b0101; // XOR
				 6'b100101: ALUout <= 4'b0001; // OR
				 6'b101010: ALUout <= 4'b0111; //slt
				 default : ALUout <= 4'b0010;
				  endcase
		3'b011: ALUout <= 4'b0001; // ori
		3'b100: ALUout <= 4'b0000; // andi 
		default : ALUout <= 4'b0010;	
		endcase
		end
endmodule


//2'b11 : case(ori_and)
				  //1'b1 : ALUout = 4'b0001;      (another option) --> in this case we need to add new control signal to the main control 
		        //1'b0 : ALUout = 4'b0000;                           and this signal will be 1 when the inst is orri and 0 in other cases.
		