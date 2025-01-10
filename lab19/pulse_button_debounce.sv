`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module pulse_button_debounce(
	output logic zero_to_one, output logic one_to_zero,
	input logic clk, input logic rst, input logic dbt, input logic btn_in
);

	// enumerate and define the state variables
	enum logic [2:0] {S0, S0A, S1, S1A, ZR21, ON20} state, next_state;

	always_ff @(posedge clk) begin
		state <= next_state;
	end

	always_comb begin
		// defaults
		next_state = state;
		zero_to_one = 0;
		one_to_zero = 0;
		// main logic
		case (state)
			S0: begin
				if ((btn_in == 1) && (dbt == 1)) next_state = S0A;
			end
			S0A: begin
				if (dbt == 1) begin
					if (btn_in == 1) next_state = ZR21;
					else next_state = S0;
				end
			end
			ZR21: begin
				next_state = S1;
				zero_to_one = 1;
			end
			S1: begin
				if ((btn_in == 0) && (dbt == 1)) next_state = S1A;
			end
			S1A: begin
				if (dbt == 1) begin
					if (btn_in == 1) next_state = S1;
					else next_state = ON20;
				end
			end
			ON20: begin
				next_state = S0;
				one_to_zero = 1;
			end
			default: begin
				next_state = S0;
			end
		endcase

		// priority logic
		if (rst == 1) begin
			next_state = S0;
			zero_to_one = 0;
			one_to_zero = 0;
		end

	end

endmodule
