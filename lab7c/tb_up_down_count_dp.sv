`timescale 1ns / 1ps

module tb_up_down_count_dp ();	// this is the top level testbench wrapper

	// ----- fill in the number of rows, inputs and outputs in the text file -----
	parameter ROWS=30, INPUTS=3, OUTPUTS=16;
	logic [INPUTS-1:0] data_in;
	logic [OUTPUTS-1:0] expected_out;
	logic [OUTPUTS-1:0] sim_out;	// signal containing the simulated output;
	logic [INPUTS+OUTPUTS-1:0] test_vectors [0:ROWS-1];
	integer i;	// variable for loop index
	integer mm_count;	// variable to hold the mismatch count

	logic clk;	// clock signal

	// instantiate the unit under test
	up_down_count_dp uut (.digit3(sim_out[15:12]), .digit2(sim_out[11:8]),
		.digit1(sim_out[7:4]), .digit0(sim_out[3:0]),
		.enable(data_in[1]), .up_down(data_in[0]), .rst(data_in[2]), .clk);

	always begin
		clk = 1;
		#5;
		clk = 0;
		#5;
	end

	initial begin
		$dumpfile("tb_up_down_count_dp.vcd");
		$dumpvars();

		mm_count = 0;   // zero mismatch count

 		// read all of the test vectors from a file into
		// array: test_vectors
		$readmemb("tb_up_down_count_dp.txt", test_vectors);

		@(negedge clk);	// wait for negative edge

		for (i=0; i<ROWS; i=i+1) begin

			// read each vector (row) into the input data and
			// expected output variables – at this time the
			// data_in is applied to the unit under test
			{data_in, expected_out} = test_vectors [i];

			@(negedge clk);	// wait for the next positive-negative cycle

			// now compare the output from uut to expected value
			if (sim_out !== expected_out) begin
				// display mismatch
				$display("Mismatch--loop index i: %d; input: %b, expected: %b, received: %b",
					i, data_in, expected_out, sim_out);

				mm_count = mm_count + 1;        // increment mismatch count

			end	// end of if
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
