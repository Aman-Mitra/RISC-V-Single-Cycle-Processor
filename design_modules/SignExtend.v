module SignExtend(inputData, OutputData);
	input [15:0] inputData;
	output [31:0] OutputData;
	
	assign OutputData={{15{inputData[15]}},inputData};	//for now keeping this module simple
							    	//will add immediate generation control signal later
endmodule	
