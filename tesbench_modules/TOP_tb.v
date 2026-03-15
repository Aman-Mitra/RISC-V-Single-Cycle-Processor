
module Pipeline_Processor_Tb();
    
    reg clk,rst;

    TOP Top(.clk(clk), .rst(rst));

    initial begin
        $dumpfile("Pipeline.vcd");
        $dumpvars(0);
    end

    always #50 clk = ~ clk;
               
    initial
    begin
        rst <= 1'b0;
        #150;

        rst <=1'b1;
        #450;
        $finish;
    end
endmodule