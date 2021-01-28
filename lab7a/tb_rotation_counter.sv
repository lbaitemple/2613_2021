`timescale 1ns / 1ps

module tb_rotation_counter;

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

	// ----- fill in the number of rows, inputs and outputs in the text file -----
	parameter ROWS=40, INPUTS=3, OUTPUTS=5;
	logic [INPUTS-1:0] data_in;
	logic [OUTPUTS-1:0] expected_out;
	logic [INPUTS+OUTPUTS-1:0] test_vectors [0:ROWS-1];
	integer i;	// variable for loop index
	integer mm_count;	// variable to hold the mismatch count

	// Inputs
	logic clk;

	// simulation outputs
	logic [6:0] cathode;
	logic [3:0] anode;
	logic error;

	// internal signals
	logic [1:0] anode_sel;
	
	// Instantiate the Unit Under Test (UUT)
	rotation_counter uut (.cathode, .anode, .error,
		.q_a(data_in[1]), .q_b(data_in[0]), .rst(data_in[2]), .clk);

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

	assign anode_sel = uut.u_dd.u_dc.ms_bits;

	initial begin
		$dumpfile("tb_rotation_counter.vcd");
		$dumpvars();
		// set up time format
		$timeformat(-9, 0, " ns", 4);

		// force internal anode select signals to lower bits
		// for faster simulation
		force uut.u_dd.u_dc.ms_bits = uut.u_dd.u_dc.count[4:3];

		mm_count = 0;	// zero mismatch count

		// first read all of the test vectors from a file into array: test_vectors
		$readmemb("tb_rotation_counter.txt", test_vectors);

		data_in = 3'b100;	// activate reset to clear the ff's
		// need 4 to flush the quads
		@(negedge clk);	// wait for next negative clock edge
		@(negedge clk);	// wait for next negative clock edge
		@(negedge clk);	// wait for next negative clock edge
		@(negedge clk);	// wait for next negative clock edge
		data_in = 3'b0;	// done with reset

		for (i=0; i<ROWS; i=i+1) begin

			@(negedge clk);	// wait for next negative clock edge

			// read each vector (row) into the input data and
			// expected output variables – at this time the
			// data_in is applied to the unit under test
			{data_in, expected_out} = test_vectors[i];

			// wait for change to ripple through the quads and fsm
			@(negedge clk);	// wait for next negative clock edge
			@(negedge clk);	// wait for next negative clock edge
			@(negedge clk);	// wait for next negative clock edge
			@(negedge clk);	// wait for next negative clock edge
			@(negedge clk);	// wait for next negative clock edge

			// now compare the output from uut to expected value
			if ({svn_seg_to_hex(cathode),error} !== expected_out) begin
				// display mismatch
				$display("Mismatch--loop index i: %d; {rst,q_a,q_b} input: %b, {digit%1d,error} expected: %4b_%1b, simulated: %4b_%1b",
					i, data_in, anode_sel, expected_out[4:1], expected_out[0],
					svn_seg_to_hex(cathode), error);

				mm_count = mm_count + 1;        // increment mismatch count

			end	// end of if

			// wait here for anode select change, or if reset, ignore
			if (data_in[2] == 1'b0) @(anode_sel[0]);

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
