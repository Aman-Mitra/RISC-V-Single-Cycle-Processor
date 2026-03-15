module ALU_cont(ALUOp, func7, func3, ALUOut);
	input [1:0] ALUOp;
	input [31:25] func7;
	input [14:12] func3;
	output reg [3:0] ALUOut;

	always @(*) begin 
		case ({ALUOp,func7,func3})  
			12'b00_xxxxxxx_xxx:begin ALUOut = 4'b0010; //lw/sw instruction
			end
			12'bx1_xxxxxxx_xxx:begin ALUOut = 4'b0110;
			end
			12'b1x_0000000_000:begin ALUOut = 4'b0010;
			end	
			12'b1x_0100000_000:begin ALUOut = 4'b0110;
			end	
			12'b1x_0000000_111:begin ALUOut = 4'b0000;
			end	
			12'b1x_0000000_110:begin ALUOut = 4'b0001;
			end	
		endcase
	end

endmodule
