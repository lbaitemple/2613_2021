`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module lab6_top_io_wrapper(
	output logic [6:0] seg,
	output logic [3:0] an,
	output logic [8:0] led,
	input logic [11:0] sw
	);

	// only one digit on
	assign an = 4'b1110;

	// replicate the lower 8 switches on the led's
	assign led[7:0] = sw[7:0];

	// Instantiate the top module
	lab6_alu_1 u1 (.sw, .c_out(led[8]), .cathode(seg));

endmodule
