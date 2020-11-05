`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module lab7a_top_io_wrapper(
	output [7:0] led,
	output [6:0] seg,
	output [3:0] an,
	input [2:1] JA,
	input [0:0] btnC,
	input [2:0] sw,
	input clk
	);

	logic q_a, q_b;

	assign led[7:6] = 2'b00;	// disable the LED's

	assign led[2:0] = sw[2:0];	// replicate 3 switches
	assign led[5:4] = JA[2:1];	// show state of JA pins on led's

	// create two muxes
	assign q_a = sw[2] ? JA[1] : sw[0];
	assign q_b = sw[2] ? JA[2] : sw[1];

	// Instantiate the top module
	rotation_counter u1 (.cathode(seg), .anode(an), .error(led[3]), .q_a, .q_b, .rst(btnC), .clk);

endmodule
