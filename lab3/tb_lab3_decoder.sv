`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

module tb_lab3_decoder;

	// Inputs
	logic display_on;
	logic [3:0] in_code;
	logic [1:0] anode_switch;

	// Outputs
	logic [6:0] cathode_out;
	logic [3:0] anode_out;

	// Instantiate the Unit Under Test (UUT)
	lab3_decoder uut (.an(anode_out), .cathode(cathode_out), .sw({display_on,anode_switch,in_code}));
	
	// parameters of test vectors (outputs = columns - inputs)
	parameter COLUMNS = 18, INPUTS = 7, ROWS = 128;
	parameter OUTPUTS = COLUMNS - INPUTS;

	// this is how you declare a two dimensional test vector
	logic [COLUMNS-1:0] test_vector [0:ROWS-1];
	// we need a single vector also to make things easy
	logic [COLUMNS-1:0] single_vector;
	integer index;	// and define a variable for an index
	integer mm_count;	// define a variable to count mismatches

	initial begin
		$dumpfile("tb_lab3_decoder.vcd");
		$dumpvars();

		mm_count = 0;	// zero mismatch count

		// first read all of the test vectors from a file into array: test_vector
		$readmemb("tb_lab3_decoder.txt", test_vector);
		
		// need to loop over all of the rows using a for loop
		for (index=0; index<ROWS; index=index+1) begin
			// put the vector to test this loop into single_vector
			single_vector = test_vector [index];
			
			// now apply the stimuli to from the vector to the input signals
			display_on = single_vector[COLUMNS-1];
			in_code = single_vector[COLUMNS-2:COLUMNS-5];
			anode_switch = single_vector[COLUMNS-6:COLUMNS-INPUTS];
			#10;	// wait 10 ns for inputs to settle
			// compare to expected value
			if (({cathode_out,anode_out} !== single_vector[OUTPUTS-1:0]) ||
				({cathode_out,anode_out} === 11'bxxxxxxxxxxx)) begin
				// display mismatch
				$display("Mismatch--loop index: %d; input: %b_%b_%b, expected: %b_%b, received: %b_%b",
					index, display_on, in_code, anode_switch, single_vector[OUTPUTS-1:4],
					single_vector[3:0], cathode_out, anode_out);

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
