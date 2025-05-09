`timescale 1ns / 1ps

module tb_sequence_generator;

    reg clk;
    reg rst;
    wire [3:0] out;

    // Instantiate the sequence generator
    sequence_generator uut (
        .clk(clk),
        .rst(rst),
        .out(out)
    );

    // Clock generation: 10ns period (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus block
    initial begin
        // Initialize
        rst = 1;
        #10;
        rst = 0;

        // Run long enough to see the pattern repeat
        #100;

        $finish;
    end

    // Monitor console output
    initial begin
        $monitor("Time = %0t | Reset = %b | Output = %d", $time, rst, out);
    end

    // Waveform dump
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_sequence_generator);
    end

endmodule
