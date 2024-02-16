module Global_History_Register(clk , reset , realValue_E, branch_E, bne_E, GHR_value);
	input clk ,reset ;
	input realValue_E ; /* this signal come from excuation cycle and this is to test if the two registers is equal or not
	                       we don't take it from decode cycle bcz of the length of the critical path*/
	input branch_E, bne_E ; 
	output [3:0] GHR_value ; // the history of the branch (last four times)
	
	
	reg [3:0] GHR_Reg ;
	
	always @(posedge clk)begin	
		if(reset)
			GHR_Reg <= 4'b0000 ;
		else begin
			if(branch_E || bne_E) 
				GHR_Reg <= {GHR_Reg[2:0],realValue_E} ;
		end
	end 
		
	assign GHR_value = GHR_Reg ; 	
	
	
endmodule