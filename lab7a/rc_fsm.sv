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
		enable = 0;
		up_down = 0;
		error = 0;
		next_state = state;	// hold as default
		// main logic
		case (state)
			HOLD: begin	// hold state
				case (quad_ctl)
					2'b00: next_state = HOLD;
					2'b01: next_state = UP;
					2'b10: next_state = DOWN;
					default: next_state = ERROR;
				endcase
			end
			UP: begin	// up state
				enable = 1;	// set outputs
				up_down = 1;
				case (quad_ctl)
					2'b00: next_state = HOLD;
					2'b10: next_state = DOWN;
					default: next_state = ERROR;
				endcase
			end
			DOWN: begin	// down state
				enable = 1;	// set output
				case (quad_ctl)
					2'b00: next_state = HOLD;
					2'b01: next_state = UP;
					default: next_state = ERROR;
				endcase
			end
			default: begin	// error state
				// hold in this state and set the error signal
				error = 1;
			end
		endcase
		if (rst == 1'b1) begin	// priority logic
			next_state = HOLD;
		end
	end

endmodule
