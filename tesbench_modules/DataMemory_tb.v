`timescale 1ns/1ps

module Data_Memory_tb();

    reg clk;
    reg reset;
    reg MemRead;
    reg MemWrite;
    reg [31:0] Address;
    reg [31:0] WrdataM;
    wire [31:0] ReadDataM;

    // Instantiate DUT
    Data_Memory dut (.clk(clk),.reset(reset),.Address(Address),
        .WrdataM(WrdataM),.MemRead(MemRead),.MemWrite(MemWrite),
        .ReadDataM(ReadDataM));

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 0;
        MemRead = 0;
        MemWrite = 0;
        Address = 0;
        WrdataM = 0;

        $display("===== DATA MEMORY TEST START =====");

        //--------------------------------
        // TEST 1: RESET MEMORY
        //--------------------------------
        reset = 1;
        #10;
        reset = 0;

        //--------------------------------
        // TEST 2: WRITE TO ADDRESS 3
        //--------------------------------
        Address = 32'd3;
        WrdataM = 32'hDEADBEEF;
        MemWrite = 1;
        #10;
        MemWrite = 0;

        //--------------------------------
        // TEST 3: READ FROM ADDRESS 3
        //--------------------------------
        MemRead = 1;
        #5;
        $display("Read Addr 3 = %h (Expected DEADBEEF)", ReadDataM);

        //--------------------------------
        // TEST 4: WRITE TO ADDRESS 10
        //--------------------------------
        MemRead = 0;
        Address = 32'd10;
        WrdataM = 32'h12345678;
        MemWrite = 1;
        #10;
        MemWrite = 0;

        //--------------------------------
        // TEST 5: READ FROM ADDRESS 10
        //--------------------------------
        MemRead = 1;
        #5;
        $display("Read Addr 10 = %h (Expected 12345678)", ReadDataM);

        //--------------------------------
        // TEST 6: MemRead disabled
        //--------------------------------
        MemRead = 0;
        #5;
        $display("MemRead OFF = %h (Expected 00000000)", ReadDataM);

        //--------------------------------
        // TEST 7: RESET AGAIN
        //--------------------------------
        reset = 1;
        #10;
        reset = 0;
        MemRead = 1;
        Address = 32'd3;
        #5;
        $display("After Reset Addr 3 = %h (Expected 00000000)", ReadDataM);

        $display("===== DATA MEMORY TEST END =====");

        $stop;

    end

endmodule
