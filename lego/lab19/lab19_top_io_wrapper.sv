`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module lab10_top_io_wrapper(
	output logic [15:0] led,
	output logic [6:0] seg,
	output logic [3:0] an,
	output logic JA4,
	output logic JA2,
	output logic JA1,
	input logic JA3,
	input logic btnC, btnL,
	input logic [10:0] sw,
	input logic clk
	);

	assign an = 4'b1111;	// disable the seven segment decoders
	assign seg = 7'b1111111;
	assign led[15:11] = 5'd0;	// shut off unused leds
	// map lower leds to switches
	assign led[10:0] = sw;

	assign JA1 = JA3;	// pin JA1 - duplicate input
	assign JA2 = JA4;	// pin JA2 - duplicate output

	ir_transmitter_top u_top (.emitter(JA4),
		.clk, .sw, .rst(btnC), .btnL);

endmodule
