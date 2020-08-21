//
// lab5 : version 06/12/2020
// 
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module lab5_top_io_wrapper(
	output logic [6:0] seg,
	output logic [3:0] an,
	output logic [7:0] led,
	input logic [10:0] sw
	);

	// shut off the seven segment decoder
	assign an = 4'b1111;
	assign seg = 7'b1111111;

	// Instantiate the top module
	comb_shifters u1 (.data_out(led), .select(sw[10:8]), .data_in(sw[7:0]));

endmodule
