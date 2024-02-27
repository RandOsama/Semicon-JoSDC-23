module Branch_Target_Buffer(clk,reset,opcode , 
									Pc_F ,Pc_D , Pc_E,Target_Addrs_D , 
									hit ,hit_ifReadfromE, Target_Addrs_F,
									Target_Addrs_E_out);
									
	input clk ,reset ;
	input [5:0] opcode ;
	input [4:0]  Pc_D , Pc_F ,Pc_E;  /* lower 5 bits of Program counter 
	                               _D from the decode cycle to fill the table with the Target address 
											 in the first excuation of different branches, _F from fetch cycle
											 to access the Target address that has been calculated */
	input [31:0]Target_Addrs_D ;
	output [31:0] Target_Addrs_F,Target_Addrs_E_out ; 
	output  hit ,hit_ifReadfromE;  // to determine if there is an calculated address in this location or not  
	
	reg [32:0] BTB_Table [15:0]; // the width is 33 bits lower 32 bits for Target Address and MSB for hit bit
	
	integer i ;
	always @(posedge clk)begin
				if (reset)begin
					for (i=0 ; i<16 ; i=i+1)begin
						BTB_Table [i] = 0 ;
 					end
				end 
				else begin
				if(opcode == 6'b000100 || opcode == 6'b000101)
					BTB_Table [Pc_D] <= {1'b1,Target_Addrs_D} ;
				else 
					BTB_Table [Pc_D] <= 33'd0 ;
				end 
	end
	
	wire [32:0] tt_F = BTB_Table [Pc_F] ; 
	assign Target_Addrs_F = tt_F [31:0];
	assign hit = tt_F[32] ;	
	
	wire [32:0] tt_E = BTB_Table [Pc_E] ;
	assign Target_Addrs_E_out = tt_E[31:0] ;
	assign hit_ifReadfromE = tt_E[32] ;
	
endmodule