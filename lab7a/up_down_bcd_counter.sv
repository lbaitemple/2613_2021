`timescale 1ns / 1ps

module up_down_bcd_counter (output logic [3:0] bcd, output logic carry_out,
	input logic carry_in, input logic up_down, input logic rst, input logic clk);

	logic [3:0] next_bcd;

	// sequential logic
	always_ff @(posedge clk) begin

	end

	// combinational logic
	always_comb begin

	end

endmodule
