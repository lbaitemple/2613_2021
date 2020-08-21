//
// lab6 : version 06/12/2020
// 
`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

module tb_lab6_alu_1;

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

function [6:0] hex_to_svn_seg;
	input [3:0] hex;
	begin
		case (hex)
		0: hex_to_svn_seg = 7'b1000000;
		1: hex_to_svn_seg = 7'b1111001;
		2: hex_to_svn_seg = 7'b0100100;
		3: hex_to_svn_seg = 7'b0110000;
		4: hex_to_svn_seg = 7'b0011001;
		5: hex_to_svn_seg = 7'b0010010;
		6: hex_to_svn_seg = 7'b0000010;
		7: hex_to_svn_seg = 7'b1111000;
		8: hex_to_svn_seg = 7'b0000000;
		9: hex_to_svn_seg = 7'b0010000;
		10: hex_to_svn_seg = 7'b0100000;
		11: hex_to_svn_seg = 7'b0000011;
		12: hex_to_svn_seg = 7'b1000110;
		13: hex_to_svn_seg = 7'b0100001;
		14: hex_to_svn_seg = 7'b0000110;
		15: hex_to_svn_seg = 7'b0001110;
		default: hex_to_svn_seg = 7'bxxxxxxx;
		endcase
	end
endfunction

	// Inputs
	logic [11:0] sw;

	// Outputs
	logic [6:0] cathode;
	logic c_out;

	// Instantiate the Unit Under Test (UUT)
	lab6_alu_1 uut (.*);
	
	// parameters of test vectors (outputs = columns - inputs)
	parameter COLUMNS = 17, INPUTS = 12, ROWS = 4096;

	// this is how you declare a two dimensional test vector
	logic [COLUMNS-1:0] test_vector [0:ROWS-1];
	// we need a single vector also to make things easy
	logic [COLUMNS-1:0] single_vector;
	integer i;	// and define a variable for an index
	integer mm_count;	// define a variable to count mismatches

	initial begin
		$dumpfile("tb_lab6_alu_1.vcd");
		$dumpvars();

		mm_count = 0;	// zero mismatch count

		// first read all of the test vectors from a file into array: test_vector
		$readmemb("tb_alu_1.txt", test_vector);
		
		// need to loop over all of the rows using a for loop
		for (i=0; i<ROWS; i=i+1) begin
			// put the vector to test this loop into single_vector
			single_vector = test_vector [i];
			
			// now apply the stimuli to from the vector to the input signals
			{sw[11:9], sw[3:0], sw[7:4], sw[8]} = single_vector[COLUMNS-1:COLUMNS-INPUTS];
			#10;	// wait 10 ns for inputs to settle
			// compare to expected value
			if ({c_out, cathode} !==
				{single_vector[COLUMNS-INPUTS-1],
				hex_to_svn_seg(single_vector[COLUMNS-INPUTS-2:0])}) begin
				// display mismatch
				$display("Mismatch--loop index i: %d; input: sel=%b a=%b b=%b c_in=%b expected: {c_out,f}=%b, received: %b",
					i, sw[11:9], sw[3:0], sw[7:4], sw[8], single_vector[COLUMNS-INPUTS-1:0],
					{c_out,svn_seg_to_hex(cathode)});

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
