module IntsrucMem(instrAddr, reset, instr);
	input [31:0] instrAddr;
	input reset;
	output [31:0] instr;
	//creating the Memory
	reg [31:0] Memory [63:0]; //Memory consists of 64 registers of 32 bits
	integer i;
	assign instr=Memory[instrAddr];    

	always @(posedge reset) begin
		for (i=0;i<64;i=i+1) 
			Memory[i]<=32'h0;
	end

endmodule
