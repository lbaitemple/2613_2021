`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module lab5a_top_io_wrapper(
	output logic [4:0] led,
	input logic btnC,
	input logic [2:0] sw);

	// instantiate the top level module and connect the switches and led's
	top_latch u_top (.qa(led[0]), .qb(led[1]), .q_lvl(led[2]), .q_latch(led[3]), .q_ff(led[4]),
		.s(sw[0]), .r(sw[1]), .d(sw[2]), .ck(btnC));

endmodule
