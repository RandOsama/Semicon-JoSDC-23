module Register_File(
    input clk,reset ,
    input [4:0] Rr1, Rr2, WriteRegister,
    input [31:0] WriteData,
    input regWrite,
    output [31:0] Rd1, Rd2
);

    reg [31:0] mem[31:0];

    integer i; 
     

    always @(negedge clk) begin
		  if(reset)begin
				for (i=0 ; i<32 ; i= i +1)
					mem [i] = 0 ;
				//mem[28] = 5;
		  end
        else if (regWrite && (WriteRegister != 5'b00000)) begin
            mem[WriteRegister] <= WriteData;
        end
    end
	 
	 assign Rd1 = (Rr1 == WriteRegister && WriteRegister != 5'b00000 && regWrite) ? WriteData : mem[Rr1];
    assign Rd2 = (Rr2 == WriteRegister && WriteRegister != 5'b00000 && regWrite) ? WriteData : mem[Rr2];

endmodule