`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

module tb_gates;

	// Inputs
	logic [1:0] d_in;

	// Outputs
	logic [3:0] d_out;

	// Instantiate the Unit Under Test (UUT)
	gates uut (
		.a0(d_in[0]), .b0(d_in[1]), .f0(d_out[0]), .a1(d_in[0]), .b1(d_in[1]), .f1(d_out[1]),
		.a2(d_in[0]), .b2(d_in[1]), .f2(d_out[2]), .a3(d_in[0]), .b3(d_in[1]), .f3(d_out[3])
	);
	
	// parameters of test vectors (outputs = columns - inputs)
	parameter COLUMNS = 6, INPUTS = 2, ROWS = 4;

	// this is how you declare a two dimensional test vector
	logic [COLUMNS-1:0] test_vector [0:ROWS-1];
	// we need a single vector also to make things easy
	logic [COLUMNS-1:0] single_vector;
	integer i;	// and define a variable for an index
	integer mm_count;	// define a variable to count mismatches

	initial begin
		$dumpfile("tb_gates.vcd");
		$dumpvars();

		mm_count = 0;	// zero mismatch count

		// first read all of the test vectors from a file into array: test_vector
		$readmemb("tb_gates.txt", test_vector);
		
		// need to loop over all of the rows using a for loop
		for (i=0; i<ROWS; i=i+1) begin
			// put the vector to test this loop into single_vector
			single_vector = test_vector [i];
			
			// now apply the stimuli to from the vector to the input signals
			d_in = single_vector[COLUMNS-1:COLUMNS-INPUTS];
			#10;	// wait 10 ns for inputs to settle
			// compare to expected value
			if ({d_out[3],d_out[2],d_out[1],d_out[0]} !== single_vector[COLUMNS-INPUTS-1:0]) begin
				// display mismatch
				$display("Mismatch--loop index i: %d; input: %b, expected: %b, received: %b",
					i, d_in, single_vector[COLUMNS-INPUTS-1:0], {d_out[3],d_out[2],d_out[1],d_out[0]});

				mm_count = mm_count + 1;	// increment mismatch count

			end
			#10;	// add 10 ns for symmetry
		end	// end of for loop

		// tell designer we're done with the simulation
		if (mm_count == 0) begin
			$display("Simulation complete - no mismatches!!!");
		end else begin
			$display("Simulation complete - %d mismatches!!!", mm_count);
		end
		$finish;
		
	end	// end of initial block
endmodule
