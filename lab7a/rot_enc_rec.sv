`timescale 1ns / 1ps

module rot_enc_rec (output logic [1:0] quad_ctl, input logic q_a, input logic q_b,
	input logic clk);

	// d flip flops
	logic sync0_a, sync1_a;	// a channel synchronizers
	logic sync0_b, sync1_b;	// b channel synchronizers
	logic q_prev_a, q_now_a;	// a channel previous and now
	logic q_prev_b, q_now_b;	// b channel previous and now

	// put all back to back d flip flops in one always block
	always_ff @(posedge clk) begin
		sync0_a <= q_a;	// the input signals
		sync0_b <= q_b;
		sync1_a <= sync0_a;	// synchronization of input signals
		sync1_b <= sync0_b;
		q_now_a <= sync1_a;	// store current a quad signal
		q_now_b <= sync1_b;	// store current b quad signal
		q_prev_a <= q_now_a;	// store prevous a quad signal
		q_prev_b <= q_now_b;	// store prevous b quad signal
	end

	// recode the 4 quad inputs into an output control signal
	always_comb begin
		case ({q_prev_a,q_prev_b,q_now_a,q_now_b})
			// hold
			4'b0000, 4'b0101, 4'b1010, 4'b1111: quad_ctl = 2'b00;
			// count up
			4'b0001, 4'b0111, 4'b1000, 4'b1110: quad_ctl = 2'b01;
			// count down
			4'b0010, 4'b0100, 4'b1011, 4'b1101: quad_ctl = 2'b10;
			// all the rest - error
			default: quad_ctl = 2'b11;
		endcase
	end

endmodule
