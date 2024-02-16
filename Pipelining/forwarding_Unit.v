module forwarding_Unit(
    input [4:0] rd_M, rd_WB, rs1_E, rs2_E, rs1_D ,rs2_D,
    input RegWrite_M, RegWrite_WB, Branch_D ,bne_D, // Branch_D ,bne_D --> output of control unit
    output reg [1:0] ForwardA, ForwardB,
	 output reg Forward_rs1, Forward_rs2
);

    
		always @(*) begin
        // Forwarding logic for input 1 of ALU
        if (RegWrite_M && (rd_M == rs1_E) && (rd_M != 5'b00000))
            ForwardA = 2'b10;
        else if (RegWrite_WB && (rd_WB == rs1_E) && (rd_WB != 5'b00000))
            ForwardA = 2'b01;
        else
            ForwardA = 2'b00;

        // Forwarding logic for input 2 of ALU
        if (RegWrite_M && (rd_M == rs2_E) && (rd_M != 5'b00000))
            ForwardB = 2'b10;
        else if (RegWrite_WB && (rd_WB == rs2_E) && (rd_WB != 5'b00000))
            ForwardB = 2'b01;
        else
            ForwardB = 2'b00;
    end
	 
	 
	 // branch forward -->
	 always @(*) begin
        // Forwarding logic for rs1
        if (RegWrite_M && (Branch_D || bne_D) && (rd_M == rs1_D) && (rd_M != 5'b00000))
            Forward_rs1 = 1'b1; //rs
        else
            Forward_rs1 = 1'b0;

        // Forwarding logic for rs2
        if (RegWrite_M && (Branch_D || bne_D) && (rd_M == rs2_D) && (rd_M != 5'b00000))
            Forward_rs2 = 1'b1; //rt
        else
            Forward_rs2 = 1'b0;
    end
	 
	 

endmodule