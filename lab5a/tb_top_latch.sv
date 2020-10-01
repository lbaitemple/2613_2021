`timescale 1ns / 1ps
module tb_top_latch ();	// this is the top level testbench wrapper

	// ----- fill in the number of rows, inputs and outputs in the text file -----
	parameter ROWS=30, INPUTS=4, OUTPUTS=5;
	logic [INPUTS-1:0] data_in;
	logic [OUTPUTS-1:0] expected_out;
	logic [OUTPUTS-1:0] sim_out;	// signal containing the simulated output;
	logic [INPUTS+OUTPUTS-1:0] test_vectors [0:ROWS-1];
	integer i;	// variable for loop index
	integer mm_count;	// variable to hold the mismatch count

	// instantiate the unit under test
	top_latch uut (.qa(sim_out[0]), .qb(sim_out[1]), .q_lvl(sim_out[2]),
	 	.q_latch(sim_out[3]), .q_ff(sim_out[4]),
		.s(data_in[0]), .r(data_in[1]), .d(data_in[2]), .ck(data_in[3]));

	initial begin
		$dumpfile("tb_top_latch.vcd");
		$dumpvars();

		mm_count = 0;   // zero mismatch count

 		// read all of the test vectors from a file into
		// array: test_vectors
		$readmemb("tb_top_latch.txt", test_vectors);

		for (i=0; i<ROWS; i=i+1) begin
			// read each vector (row) into the input data and
			// expected output variables – at this time the
			// data_in is applied to the unit under test
			{data_in, expected_out} = test_vectors [i];

			#10;    // artificial wait 10 ns for inputs to settle
			// now compare the output from uut to expected value
			if (sim_out !== expected_out) begin
				// display mismatch
				$display("Mismatch--loop index i: %d; input: %b, expected: %b, received: %b",
					i, data_in, expected_out, sim_out);

				mm_count = mm_count + 1;        // increment mismatch count

			end	// end of if
			#10;    // add 10 ns for symmetry
		end	// end of for loop

		// tell designer we're done with the simulation
		if (mm_count == 0) begin
			$display("Simulation complete - no mismatches!!!");
		end else begin
			$display("Simulation complete - %d mismatches!!!",
				mm_count);
		end
		$finish;
	end	// end of initial block

endmodule
