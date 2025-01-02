`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

module tb_memory_display;

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

	// Inputs
	logic rst;
	logic clk;
	logic m_write;
	logic [9:0] sw;
	logic [3:0] w_data;

	// Outputs
	logic [6:0] cathode;
	logic [3:0] anode;


	// parameters of test vectors (outputs = columns - inputs)
	parameter COLUMNS = 26, INPUTS = 11, ROWS = 10;

	// this is how you declare a two dimensional test vector
	logic [0:COLUMNS-1] test_vector [0:ROWS-1];
	// we need a single vector also to make things easy
	logic [0:COLUMNS-1] single_vector;
	logic [0:3] ru_data, rs_data;
	integer i;	// and define a variable for an index
	integer mm_count;	// define a variable to count mismatches
	
	// need to declare these because the simulator does not output the 2d memory array q_regfile
	logic [3:0] mem_loc0, mem_loc1, mem_loc2, mem_loc3, mem_loc4, mem_loc5, mem_loc6, mem_loc7;

	// Instantiate the Unit Under Test (UUT)
	memory_display uut (.*, .rs_data, .ru_data, .w_ena(m_write), .w_data(w_data), .sw);

	// set up the clock
	always begin
		#5;	// 10 ns period
		clk = ~clk;
	end
	always @(negedge clk) begin
		// need to assign these because the simulator does not output the 2d memory array q_regfile
		mem_loc0 = uut.u_rf.q_regfile[0];
		mem_loc1 = uut.u_rf.q_regfile[1];
		mem_loc2 = uut.u_rf.q_regfile[2];
		mem_loc3 = uut.u_rf.q_regfile[3];
		mem_loc4 = uut.u_rf.q_regfile[4];
		mem_loc5 = uut.u_rf.q_regfile[5];
		mem_loc6 = uut.u_rf.q_regfile[6];
		mem_loc7 = uut.u_rf.q_regfile[7];
	end

	initial begin	// timeout loop
		#50000000;
		$display("Timeout error - check the anode signals!");
		$finish;
	end

	initial begin
`ifdef DUMP
		$dumpfile("tb_memory_display.vcd");
//		$dumpvars();
		$dumpvars(0,tb_memory_display);
`endif
		// take care of memory elements if the simulator will allow - need to do all of them
		//$dumpvars(0, uut.u_rf.q_regfile[0]);
		// Initialize Inputs
		rst = 1;
		clk = 0;
		m_write = 0;
		sw = 10'b0;

		mm_count = 0;	// zero mismatch count

		// first read all of the test vectors from a file into array: test_vector
		$readmemb("tb_memory_display.txt", test_vector);

		@(negedge clk);	// wait for negative edge to synchronize the loop
		rst = 0;

		// need to loop over all of the rows using a for loop
		for (i=0; i<ROWS; i=i+1) begin
			// put the vector to test this loop into single_vector
			single_vector = test_vector [i];
			
			// now apply the stimuli from the vector to the input signals
			m_write = single_vector[0];
			sw = single_vector[1:INPUTS-1];
			w_data = single_vector[1:4];

			//$display("loop index i: %d %b %b %b", i, m_write, sw[5], w_data);			
			@(negedge clk);	// wait for negative edge
			@(negedge clk);	// wait for negative edge
			@(negedge clk);	// wait for negative edge


			//$display("loop: %0d | anode: %b <|> %b ", i, {anode, cathode}, single_vector[INPUTS:COLUMNS-1]);
			// compare to expected value
			if ({rs_data,ru_data,cathode} !== single_vector[INPUTS:COLUMNS-1]) begin
				// display mismatch
				$display("Mismatch %d,  %b.  %b\n", i, {rs_data, ru_data}, cathode);
			//	$display("%b\n", single_vector[INPUTS:COLUMNS-1]);
				/*$display("Mismatch--loop index i: %d; anode, cathode expected: %b_%b %h, received: %b_%b %h",
					i,
					single_vector[COLUMNS-11:COLUMNS-8],
					single_vector[COLUMNS-7:COLUMNS-1],
					svn_seg_to_hex(single_vector[COLUMNS-7:COLUMNS-1]),
					anode, cathode, svn_seg_to_hex(cathode));
				*/
				mm_count = mm_count + 1;	// increment mismatch count
			end else begin
				$display("Match--loop index i: %d", i);
			end
		//	@(negedge clk);	// wait for negative edge
		//	@(negedge clk);	// wait for negative edge
		//	@(negedge clk);	// wait for negative edge
			//@(anode);	// wait for change in anode
			//@(single_vector[COLUMNS-11:COLUMNS-8]);

		end	// end of for loop

		// tell designer we're done with the simulation
		if (mm_count == 0) begin
			$display("Simulation complete - no mismatches!!!");
		end else begin
			$display("Simulation complete - %d mismatches!!!", mm_count);
		end
		$finish;

	end
endmodule
