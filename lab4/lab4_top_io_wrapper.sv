`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module lab4_top_io_wrapper(
	output logic [6:0] seg,
	output logic [3:0] an,
	output logic [3:0] led,
	input logic [6:0] sw
	);
	 
	// Instantiate the top module
	lab4_decoder u1 (.led(led[3:0]), .an, .cathode(seg), .sw(sw[6:0]));

endmodule
