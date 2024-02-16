module Hazard_Detection_Unit(
    input [4:0] Rd_E, Rs1_D, Rs2_D,
    input memread_E,Branch_D,bne_D,stall_EX,MemRead_M,prediction_E ,real_Value_E ,branch_E,bne_E,
	 input hit_E , 
    output stall, pcwrite, IF_ID_write ,
	 output reg flush ,flush_hit , selectCorrectTarget , selectCorrectPcPlus1 ,select_hit
);
	
    reg x;

    always @(*) begin
			x = 0 ;
        if (((Rd_E == Rs1_D) || (Rd_E == Rs2_D)) && (Rd_E != 5'b00000) && memread_E )//load use data hazard
            x = 1;
        else if (((Rd_E == Rs1_D) || (Rd_E == Rs2_D)) && (Rd_E != 5'b00000) && (~memread_E ) &&  (Branch_D || bne_D)) // for branch (before)  
            x = 1;
		  else if (stall_EX && (Branch_D || bne_D) && MemRead_M )  // for branch (before) :stall number 2 in case the instruction before branch is load  
				x = 1;
		  else 
				x = 0 ;
    end
	 
	 always @(*)begin
		selectCorrectTarget = 1'b0 ;
	   selectCorrectPcPlus1 = 1'b0 ;
		flush = 1'b0 ;
		select_hit = 1'b0 ;
		flush_hit = 1'b0;
		if(branch_E || bne_E)begin
			if(hit_E && (prediction_E != real_Value_E))
				flush = 1'b1 ;
			else 
				flush = 1'b0 ;
		
         if(prediction_E == 1'b0 && real_Value_E == 1'b1)begin
				selectCorrectTarget = 1'b1 ;
				select_hit = 1'b1 ;
			end else begin
				selectCorrectTarget = 1'b0 ;
				select_hit = 1'b0 ;
			end
			if(prediction_E == 1'b1 && real_Value_E == 1'b0)
				selectCorrectPcPlus1 = 1'b1 ;
			else 
				selectCorrectPcPlus1 = 1'b0 ;	
				
		end else	
			   flush = 1'b0 ;
		if(hit_E == 1'b0 && real_Value_E)begin
			   flush_hit = 1'b1;
				select_hit = 1'b1 ;
		end else begin 
				flush_hit = 1'b0;
				select_hit = 1'b0;
		end		
			
	 end

    // Assign outputs based on data hazard condition
    assign stall = x;
    assign pcwrite = (x==0) ? 1'b1 : ~x;
    assign IF_ID_write = (x==0) ? 1'b1 : ~x;
	 	
endmodule