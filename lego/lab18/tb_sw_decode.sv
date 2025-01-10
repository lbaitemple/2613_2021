`timescale 1ns / 1ps
module tb_sw_decode;

	logic bits_done, bit_value;	// output signals
	logic next_bit, clk, rst;	// input signals
	logic [10:0] sw;

	// parameters of test vectors (outputs = columns - inputs)
	parameter COLUMNS = 14, INPUTS = 12, ROWS = 67;

	// this is how you declare a two dimensional test vector
	logic [COLUMNS-1:0] test_vector [0:ROWS-1];
	// we need a single vector also to make things easy
	logic [COLUMNS-1:0] single_vector;
	integer i;	// and define a variable for an index
	integer mm_count;	// define a variable to count mismatches

	sw_decode uut (.bits_done, .bit_value,
		.next_bit, .sw, .clk, .rst);

	// set up clock signal
	always begin
		// 10 nsec period = 100 MHz
		clk = 0;
		#5;	// 5 nsec
		clk = 1;
		#5;	// 5 nsec
	end

	initial begin
		// set up time format
		$timeformat(-9, 0, " ns", 4);
		$dumpfile("tb_sw_decode.vcd");
		$dumpvars();

		// first read all of the test vectors from a file into array: test_vector
		$readmemb("tb_sw_decode.txt", test_vector);

		rst = 1;	// start with reset active
		#10;	// wait 10 nsec
		rst = 0;	// reset inactive

		// need to loop over all of the rows using a for loop
		mm_count = 0;
		for (i=0; i<ROWS; i=i+1) begin
			// put the vector to test this loop into single_vector
			single_vector = test_vector [i];
			
			// now apply the stimuli to from the vector to the input signals
			next_bit = single_vector[COLUMNS-1];
			sw = single_vector[COLUMNS-2:COLUMNS-INPUTS];
			#2;	// wait a little bit

			// compare to expected value
			if ({bits_done, bit_value} !== single_vector[COLUMNS-INPUTS-1:0]) begin
				// display mismatch
				$display("Mismatch--index i: %4d; input vector: %b_%11b; expected: %b_%b, received: %b_%b",
					i, single_vector[COLUMNS-1], single_vector[COLUMNS-2:COLUMNS-INPUTS],
					single_vector[COLUMNS-INPUTS-1], single_vector[0], bits_done, bit_value);

				mm_count = mm_count + 1;	// increment mismatch count

			end
			@(negedge clk);	// wait for negative edge
		end	// end of for loop

		// tell designer we're done with the simulation
		if (mm_count == 0) begin
			$display("Simulation complete - no mismatches!!!");
		end else begin
			$display("Simulation complete - %d mismatches!!!", mm_count);
		end
		$finish;


		$display("Simulation complete!!!");
		$finish;
	end

endmodule
