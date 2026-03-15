`timescale 1ns/1ps

module tb_PC;

    reg clk;
    reg reset;
    reg [31:0] PC_in;
    wire [31:0] PC_out;

    // Instantiate DUT
    PC dut (
        .clk(clk),
        .PC_in(PC_in),
        .reset(reset),
        .PC_out(PC_out)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 0;
        PC_in = 0;

        $display("========== PC VERIFICATION START ==========");

        // Test 1: Reset functionality
        reset = 1;
        PC_in = 32'h12345678;
        #10;
        $display("Reset Test: PC_out = %h (Expected: 00000000)", PC_out);

        // Test 2: Release reset, load value
        reset = 0;
        PC_in = 32'h00000004;
        #10;
        $display("Load Test 1: PC_out = %h (Expected: 00000004)", PC_out);

        // Test 3: Load next value
        PC_in = 32'h00000008;
        #10;
        $display("Load Test 2: PC_out = %h (Expected: 00000008)", PC_out);

        // Test 4: Change input without clock edge observation
        PC_in = 32'h0000000C;
        #2;   // no clock edge yet
        $display("Before clock edge: PC_out = %h (Expected: unchanged)", PC_out);

        #8;   // allow clock edge
        $display("After clock edge: PC_out = %h (Expected: 0000000C)", PC_out);

        // Test 5: Reset again
        reset = 1;
        #10;
        $display("Reset Again: PC_out = %h (Expected: 00000000)", PC_out);

        $display("========== PC VERIFICATION END ==========");
        $stop;

    end

endmodule
