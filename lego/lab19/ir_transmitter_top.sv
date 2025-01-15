`timescale 1ns/1ps

module ir_transmitter_top (output logic emitter,
	input logic clk, input logic [10:0] sw,
	input logic rst, btnL);

	logic tc_modulator, sw_modulator, dp_rst;
	logic [1:0] mod_sel;
	logic strt, dbt;
	logic btn_in, btn1;
	logic next_bit, bits_done, bit_value;

// this is the transmitter section
	ir_emitter_fsm u_fsm (.sw_modulator, .mod_sel, .dp_rst, .next_bit,
		.clk, .rst, .strt, .tc_modulator, .bits_done, .bit_value);

	ir_emitter_dp u_dp (.emitter_out(emitter), .tc_modulator,
		.clk, .rst(dp_rst), .ena(1'b1), .mod_sel,
		.sw_modulator);

	sw_decode u_sd (.bits_done, .bit_value, .next_bit, .sw,
		.clk, .rst);

	pulse_button_debounce u_bdb (.zero_to_one(strt), .one_to_zero(), .clk,
		.rst, .dbt, .btn_in);

	// divider to create 0.01 sec - divide by 1,000,000 - 20 bits
	divider #(.BIT_SIZE(20)) u_dbt (.tc(dbt), .count(), .clk, .rst, .ena(1'b1),
					.init_count(20'd499999));

	// synchronizer for start button
	always_ff @(posedge clk) begin
		btn1 <= btnL;	// first ff
		btn_in <= btn1;	// second ff
	end

endmodule
