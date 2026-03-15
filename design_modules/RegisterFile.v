module RegisterFile(clk,reset, rs1, rs2, rd, WriteD, ReadData1, ReadData2, RegWrite );
	input clk,reset;
	input [19:15] rs1;		//Source register 1
	input [24:20] rs2;		//Source register 2
	input [11:7] rd;		//Destination Register
	input RegWrite;			//1-bit Control Signal
	input [31:0] WriteD;	//Data Write Back
	integer k;
	reg [31:0] Register [31:0];  //Creating the Register file 
	output [31:0] ReadData1,ReadData2; 
	
	assign ReadData1=Register[rs1];
	assign ReadData2=Register[rs2];
			
	always @(posedge clk) begin 
		if (reset) begin
			for (k=0;k<32;k=k+1) begin 
				Register[k]=32'h0;		
			end
		end
		else if (RegWrite) begin	
			Register[rd]=WriteD;
		end
	end

endmodule
