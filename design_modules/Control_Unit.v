module Cont_Unit(OpCode,Branch,MemRd,MemtoReg,ALUOp,MemWrite,
		ALUSrc,RegWrite);
	input [6:0] OpCode;
	output reg Branch,MemRd,MemtoReg,MemWrite,ALUSrc,RegWrite;
	output reg [1:0] ALUOp;

	always @(*) begin
		case (OpCode)
			7'b0110011:begin	//R-type instruction
				Branch<=0;MemRd<=0;MemtoReg<=0;
				MemWrite<=0;ALUSrc<=0;RegWrite<=1;
				ALUOp<=2'b10;
			end
			7'b0000011:begin	//lw instruction
				Branch<=0;MemRd<=1;MemtoReg<=1;
				MemWrite<=0;ALUSrc<=1;RegWrite<=1;
				ALUOp<=2'b00;
			end
			7'b0100011:begin	//sw instruction
				Branch<=0;MemRd<=0;MemtoReg<=1'bx;
				MemWrite<=1;ALUSrc<=1;RegWrite<=0;
				ALUOp<=2'b00;
			end
			7'b1100011:begin	//beq instruction
				Branch<=1;MemRd<=0;MemtoReg<=1'bx;
				MemWrite<=0;ALUSrc<=0;RegWrite<=0;
				ALUOp<=2'b01;
			end
		endcase 
	end

endmodule
