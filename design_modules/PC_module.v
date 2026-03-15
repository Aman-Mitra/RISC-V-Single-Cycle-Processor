module PC(clk, PC_in, reset, PC_out);
	input clk;
	input [31:0] PC_in;
	input reset;
	output reg [31:0] PC_out;
	always @(posedge clk or posedge reset) begin
		if (reset) 
			PC_out<=32'h0;
		else 
			PC_out<=PC_in;
	end
endmodule
