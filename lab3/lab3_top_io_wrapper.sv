//
// lab3 : version 06/12/2020
// 
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module lab3_top_io_wrapper(
	output logic [6:0] seg,
	output logic dp,
	output logic [3:0] an,
	output logic [7:0] led,
	input logic [7:0] sw
	);
	 
	// --------- outputs ----------
	// shut everything off as a default
	assign dp = 1'b1;	// low is on
	// regular leds
	assign led[7:1] = 7'b0000000;	// high is on
	// assign the left over switch to minimize warnings
	assign led[0] = sw[7];
	
	// Instantiate the top module
	lab3_decoder u1 (.sw(sw[6:0]), .an, .cathode(seg));

endmodule
