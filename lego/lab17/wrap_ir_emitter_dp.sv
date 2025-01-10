 `timescale 1ns/1ps

module wrap_ir_emitter_dp (output logic emitter_out,
	input logic clk, input logic rst, input logic ena);

	logic [2:0] count;
	logic [1:0] mod_sel;
	logic tc_modulator, sw_modulator;

	ir_emitter_dp u_dp (.emitter_out, .tc_modulator, .clk,
		.rst, .ena, .mod_sel, .sw_modulator);

	// divider for testing
	divider #(.BIT_SIZE(3)) u1 (.tc(), .count, .init_count(3'd5),
		.clk, .rst, .ena(tc_modulator));

	// encoder for control signals
	always_comb begin
		sw_modulator = 0;
		mod_sel = 2'b00;
		case (count)
			3'd5: begin
				sw_modulator = 1;
				mod_sel = 2'b11;
			end
			3'd3: begin
				sw_modulator = 1;
				mod_sel = 2'b01;
			end
			3'd1: begin
				sw_modulator = 1;
				mod_sel = 2'b10;
			end
			default: ;
		endcase
	end
endmodule
