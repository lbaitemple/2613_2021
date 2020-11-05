`timescale 1ns / 1ps

module rc_fsm (output logic enable, output logic up_down,
	output logic error, input logic [1:0] quad_ctl,
	input logic rst, input logic clk);

	enum logic [1:0] {HOLD, UP, DOWN, ERROR} state, next_state;

	// sequential logic
	always_ff @(posedge clk) begin
		state <= next_state;
	end

	// combinational logic
	always_comb begin
		// defaults
		// main logic
		if (rst == 1'b1) begin	// priority logic
		end
	end

endmodule
