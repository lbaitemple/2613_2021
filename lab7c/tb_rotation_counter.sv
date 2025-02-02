`timescale 1ns / 1ps

module tb_rotation_counter;

    // Function to convert 7-segment display to hex
    function [3:0] svn_seg_to_hex;
        input [6:0] svn_seg;
        begin
            case (svn_seg)
                7'b1000000: svn_seg_to_hex = 0;
                7'b1111001: svn_seg_to_hex = 1;
                7'b0100100: svn_seg_to_hex = 2;
                7'b0110000: svn_seg_to_hex = 3;
                7'b0011001: svn_seg_to_hex = 4;
                7'b0010010: svn_seg_to_hex = 5;
                7'b0000010: svn_seg_to_hex = 6;
                7'b1111000: svn_seg_to_hex = 7;
                7'b0000000: svn_seg_to_hex = 8;
                7'b0010000: svn_seg_to_hex = 9;
                7'b0100000: svn_seg_to_hex = 10;
                7'b0000011: svn_seg_to_hex = 11;
                7'b1000110: svn_seg_to_hex = 12;
                7'b0100001: svn_seg_to_hex = 13;
                7'b0000110: svn_seg_to_hex = 14;
                7'b0001110: svn_seg_to_hex = 15;
                default: svn_seg_to_hex = 4'bxxxx;
            endcase
        end
    endfunction

    // Parameters for the test bench
    parameter ROWS = 12, INPUTS = 3, OUTPUTS = 29;
    logic [INPUTS-1:0] data_in;
    logic [OUTPUTS-1:0] expected_out;
    logic [INPUTS+OUTPUTS-1:0] test_vectors [0:ROWS-1];
    integer i;          // Loop index
    integer mm_count;   // Mismatch count

    // Inputs
    logic clk;

    // Outputs
    logic [6:0] hex0, hex1, hex2, hex3;
    logic error;

    // Instantiate the Unit Under Test (UUT)
    rotation_counter uut (
        .clk(clk),
        .rst(data_in[2]),
        .q_a(data_in[1]),
        .q_b(data_in[0]),
        .hex0(hex0),
        .hex1(hex1),
        .hex2(hex2),
        .hex3(hex3),
        .error(error)
    );

    // Clock generation
    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    // Timeout section
    initial begin
        #11000000; // Wait 11 ms
        $display("Simulation error - timeout");
        $display("Probably not seeing anode_sel signal changing");
        $display("Simulation stopping!!");
        $finish;
    end

    // Test bench logic
    initial begin
        $dumpfile("tb_rotation_counter.vcd");
        $dumpvars();
        $timeformat(-9, 0, " ns", 4);

        mm_count = 0; // Zero mismatch count

        // Read test vectors from file
        $readmemb("tb_rotation_counter.txt", test_vectors);

        // Apply reset
        data_in = 3'b100; // Activate reset
        repeat (4) @(negedge clk); // Wait for 4 clock cycles to flush the system
        //data_in = 3'b000; // Deactivate reset

        // Apply test vectors
        for (i = 0; i < ROWS; i = i + 1) begin
            {data_in, expected_out} = test_vectors[i]; // Apply input and expected output
            repeat (5) @(negedge clk); // Wait for next negative clock edge

            // Wait for outputs to stabiliz
            // Display simulation results
            $display("Loop index i: %d; Input: %b  Simulated: %b %b",
                i, data_in, {hex3, hex2, hex1,hex0}, error);

            // Compare outputs
            if ({hex3, hex2, hex1, hex0} !== expected_out[28:1]) begin
                $display("Mismatch--loop index i: %d; Input: %b, Expected: %b, Simulated: %b",
                    i, data_in, expected_out[28:1], {hex3, hex2, hex1,hex0});
                mm_count = mm_count + 1; // Increment mismatch count
            end
        end

        // Simulation complete
        if (mm_count == 0) begin
            $display("Simulation complete - no mismatches!!!");
        end else begin
            $display("Simulation complete - %d mismatches!!!", mm_count);
        end
        $finish;
    end
endmodule
