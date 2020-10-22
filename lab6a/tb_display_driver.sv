`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

module tb_display_driver;

	// Inputs
	logic display_on, rst, clk;
	logic [3:0] digit3, digit2, digit1, digit0;

	// Outputs
	logic [6:0] cathode;
	logic [3:0] anode;
	logic [1:0] anode_sel;
	
	// parameters of test vectors (outputs = columns - inputs)
	parameter COLUMNS = 30, INPUTS = 17, ROWS = 10;

	// this is how you declare a two dimensional test vector
	logic [COLUMNS-1:0] test_vector [0:ROWS-1];
	// we need a single vector also to make things easy
	logic [COLUMNS-1:0] single_vector;
	integer i;	// and define a variable for an index
	integer mm_count;	// define a variable to count mismatches

	// Instantiate the Unit Under Test (UUT)
	display_driver uut (.*);

	always begin
		clk = 1;
		#5;
		clk = 0;
		#5;
	end

	// timeout section
	always begin
		#11000000;	// wait 11 msec.
		$display("Simulation error - timeout");
		$display("Probably not seeing anode_sel signal changing");
		$display("Simulation stopping!!");
		$finish;
	end

	initial begin
		$dumpfile("tb_display_driver.vcd");
		$dumpvars();
		// set up time format
		$timeformat(-9, 0, " ns", 4);

		mm_count = 0;	// zero mismatch count

		// first read all of the test vectors from a file into array: test_vector
		$readmemb("tb_display_driver.txt", test_vector);

		rst = 1;
		display_on = 0;
		digit3 = 0;
		digit2 = 0;
		digit1 = 0;
		digit0 = 0;
		@(negedge clk);	// wait for negative edge
		@(negedge clk);	// wait for negative edge
		rst = 0;
		
		// need to loop over all of the rows using a for loop
		for (i=0; i<ROWS; i=i+1) begin
			@(negedge clk);	// wait for negative edge
			// put the vector to test this loop into single_vector
			single_vector = test_vector [i];
			
			// now apply the stimuli to from the vector to the input signals
			display_on = single_vector[COLUMNS-1];
			digit3 = single_vector[COLUMNS-2:COLUMNS-5];
			digit2 = single_vector[COLUMNS-6:COLUMNS-9];
			digit1 = single_vector[COLUMNS-10:COLUMNS-13];
			digit0 = single_vector[COLUMNS-14:COLUMNS-17];

			@(negedge clk);	// wait for negative edge

			// compare to expected value
			if ({cathode,anode,anode_sel} !== single_vector[COLUMNS-INPUTS-1:0]) begin
				// display mismatch
				$display("Mismatch--loop index i: %d; expected: %b_%b_%b, received: %b_%b_%b",
					i, single_vector[COLUMNS-18:COLUMNS-24],
					single_vector[COLUMNS-25:COLUMNS-28],
					single_vector[COLUMNS-29:COLUMNS-30],
					cathode, anode, anode_sel);

				mm_count = mm_count + 1;	// increment mismatch count

			end

			@((posedge anode_sel[0]) or (negedge anode_sel[0]));	// wait here for anode select change
			$display("Time: %t",$realtime);
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
