//
// lab2 : version 06/12/2020
// 
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module lab2_top_io_wrapper(
	output logic [6:0] seg,
	output logic dp,
	output logic [3:0] an,
	output logic [7:0] led,
	input logic [3:0] sw
	);
	 
	// --------- outputs ----------
	// shut everything off as a default
	// seven segment decoder with decimal point
	assign seg = 7'b1111111;	// low is on
	assign dp = 4'b1111;	// low is on
	// anodes for each digit
	assign an = 4'b1111;	// low is on
	// regular leds
	assign led[7] = 0;
	
	// Instantiate the top module
	hamming7_4_encode U1 (.e(led[6:0]), .d(sw[3:0]));

endmodule
