module TOP(clk, reset);
//instantiation of modules 

wire [31:0] InstructionTop;//creating a wire for connecting PC with IR
wire [3:0] ALUContOp;
wire [31:0] ALUOpAddress,WriteDataIp;

PC PC(.clk(clk), .PC_in(), 
      	.reset(reset), .PC_out(InstructionTop));

wire [31:0] Instruction;   //creating a wire for connecting IR with Register File
IntsrucMem InstructionMemory(.InstrAddr(InstructionTop), 
	.reset(reset), .Instr(Instruction));

wire [31:0] data1,data2;

RegisterFile RegFile(.clk(clk), .reset(reset), .rs1(Instruction[19:15]),
	.rs2(Instruction[24:20]),.rd(Instruction[11:7]), 
	.WriteD(WriteDataIp), .ReadData1(data1), 
	.ReadData2(data2), .RegWrite());

ALU ALU(.a(), .b(), .zero(), .func(ALUContOp), .out(ALUOpAddress));

ALU_cont ALU_cont(.ALUOp(), .func7(), .func3(), .ALUOut(ALUContOp));

Data_Memory DataMem(.clk(clk),.reset(reset),.Address(ALUOpAddress), .WrdataM(data2), 
	.MemRead(), .MemWrite(), .ReadDataM());

Cont_Unit CU(.OpCode(Intsruction[31:26]),.Branch(),.MemRd(),
	.MemtoReg(),.ALUOp(),.MemWrite(),
	.ALUSrc(),.RegWrite());

MUX mux1(.A(data2), .B(), .sel(), .out());
MUX mux2(.A(ALUOpAddress), .B(), .sel(), .out(WriteDataIp));

SignExtend(.inputData(), .OutputData());
	
endmodule