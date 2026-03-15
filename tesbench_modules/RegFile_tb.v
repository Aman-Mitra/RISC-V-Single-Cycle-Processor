
`timescale 1ns/1ps

module tb_RegisterFile;

    reg clk;
    reg reset;
    reg RegWrite;

    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;

    reg [31:0] WriteD;

    wire [31:0] ReadData1;
    wire [31:0] ReadData2;

    // Instantiate DUT
    RegisterFile dut (
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .WriteD(WriteD),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .RegWrite(RegWrite)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 0;
        RegWrite = 0;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        WriteD = 0;

        $display("========== REGISTER FILE VERIFICATION START ==========");

        //-----------------------------------------
        // TEST 1: RESET
        //-----------------------------------------
        reset = 1;
        #10;
        reset = 0;

        rs1 = 5;
        rs2 = 10;
        #5;

        $display("After reset ReadData1 = %h (Expected 00000000)", ReadData1);
        $display("After reset ReadData2 = %h (Expected 00000000)", ReadData2);

        //-----------------------------------------
        // TEST 2: WRITE TO REGISTER 5
        //-----------------------------------------
        rd = 5;
        WriteD = 32'hAABBCCDD;
        RegWrite = 1;
        #10;
        RegWrite = 0;

        //-----------------------------------------
        // TEST 3: READ FROM REGISTER 5
        //-----------------------------------------
        rs1 = 5;
        #5;
        $display("Read Reg[5] = %h (Expected AABBCCDD)", ReadData1);

        //-----------------------------------------
        // TEST 4: WRITE TO REGISTER 10
        //-----------------------------------------
        rd = 10;
        WriteD = 32'h12345678;
        RegWrite = 1;
        #10;
        RegWrite = 0;

        //-----------------------------------------
        // TEST 5: READ BOTH REGISTERS
        //-----------------------------------------
        rs1 = 5;
        rs2 = 10;
        #5;

        $display("Read Reg[5]  = %h (Expected AABBCCDD)", ReadData1);
        $display("Read Reg[10] = %h (Expected 12345678)", ReadData2);

        //-----------------------------------------
        // TEST 6: WRITE DISABLED CHECK
        //-----------------------------------------
        rd = 5;
        WriteD = 32'hFFFFFFFF;
        RegWrite = 0;
        #10;

        rs1 = 5;
        #5;

        $display("Write disabled Reg[5] = %h (Expected AABBCCDD)", ReadData1);

        //-----------------------------------------
        // TEST 7: RESET AGAIN
        //-----------------------------------------
        reset = 1;
        #10;
        reset = 0;

        rs1 = 5;
        #5;

        $display("After reset Reg[5] = %h (Expected 00000000)", ReadData1);

        $display("========== REGISTER FILE VERIFICATION END ==========");

        $stop;

    end

endmodule