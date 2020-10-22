`timescale 1ns / 1ps

module d_counter (output logic [1:0] ms_bits, input logic clk, input logic rst);

	// signals for 17 bit counter
	logic [16:0] count, next_count;

	// assign the most significant bits
	assign ms_bits = count[16:15];

	// synchronous logic


	// combinational logic

endmodule
