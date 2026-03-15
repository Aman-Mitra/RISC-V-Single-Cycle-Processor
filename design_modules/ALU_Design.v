 module ALU(a, b, zero, func, out);
	input [31:0] a;
	input [31:0] b;
	input [3:0] func;	//for now considering a 4-bit ALU
	output reg zero;	//with only 4 working functions 
	output reg [31:0] out;	//can modify later if required
	
	always @(*) begin
		case (func)
			4'b0000:out<=a & b;
			4'b0001:out<=a | b;
			4'b0010:out<=a + b;
			4'b0011:out<=a - b;
			default: out<=a & b;
		endcase
		zero<=1'b0;
	end

endmodule
