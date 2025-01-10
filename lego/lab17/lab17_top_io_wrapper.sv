`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module lab7_top_io_wrapper(
	output logic [7:0] led,
	output logic [6:0] seg,
	output logic [3:0] an,
	output logic JA4, JA2, JA1,
	input logic JA3,
	input logic btnC,
	input logic [0:0] sw,
	input logic clk
	);

	assign led = 8'b00000000;	// disable the LED's
	assign an = 4'b1111;	// disable the seven segment decoders
	assign seg = 7'b1111111;

	assign JA1 = JA3;	// pin JA1
	assign JA2 = JA4;	// pin JA2

	wrap_ir_emitter_dp u1 (.emitter_out(JA4), .clk, .rst(btnC), .ena(sw[0]));

endmodule
