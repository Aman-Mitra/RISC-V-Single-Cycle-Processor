
`timescale 1ns/1ps

module tb_ALU;

    reg  [31:0] a;
    reg  [31:0] b;
    reg  [3:0]  func;
    wire        zero;
    wire [31:0] out;

    // DUT instantiation
    ALU dut (
        .a(a),
        .b(b),
        .func(func),
        .zero(zero),
        .out(out)
    );

    initial begin
        $display("========== ALU VERIFICATION START ==========");

        // AND
        a = 32'd10;     // 1010
        b = 32'd12;     // 1100
        func = 4'b0000;
        #10;
        $display("AND | a=%0d b=%0d out=%0d zero=%b", a, b, out, zero);

        // OR
        func = 4'b0001;
        #10;
        $display("OR  | a=%0d b=%0d out=%0d zero=%b", a, b, out, zero);

        // ADD
        func = 4'b0010;
        #10;
        $display("ADD | a=%0d b=%0d out=%0d zero=%b", a, b, out, zero);

        // SUB (non-zero result)
        func = 4'b0011;
        #10;
        $display("SUB | a=%0d b=%0d out=%0d zero=%b", a, b, out, zero);

        // SUB resulting in zero
        a = 32'd20;
        b = 32'd20;
        func = 4'b0011;
        #10;
        $display("SUB0| a=%0d b=%0d out=%0d zero=%b", a, b, out, zero);

        // ADD overflow sanity (wraparound expected)
        a = 32'hFFFF_FFFF;
        b = 32'd1;
        func = 4'b0010;
        #10;
        $display("OVF | a=%h b=%h out=%h zero=%b", a, b, out, zero);

        // Default case
        func = 4'b1111;
        #10;
        $display("DEF | out=%0d zero=%b", out, zero);

        $display("========== ALU VERIFICATION END ==========");
        $finish();
    end

endmodule
