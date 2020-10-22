`timescale 1ns / 1ps

module display_driver( output logic [6:0] cathode, output logic [3:0] anode,
	output logic [1:0] anode_sel,
	input logic [3:0] digit3, input logic [3:0] digit2, input logic [3:0] digit1,
	input logic [3:0] digit0, input logic display_on, input logic rst, input logic clk);

	// internal signals
	logic [3:0] bcd_in; // output of mux, input to seven segment decoder

	// digit multiplexer


	// instantiate the modules


endmodule
