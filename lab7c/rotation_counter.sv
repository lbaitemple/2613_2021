`timescale 1ns / 1ps

module rotation_counter (output logic [6:0] hex0, output logic [6:0] hex1,
	output logic [6:0] hex2, output logic [6:0] hex3,
	output logic error, input logic q_a, q_b, input logic rst, input logic clk);


	// digit signals
	logic [3:0] digit3, digit2, digit1, digit0;
	logic enable, up_down;
	logic [1:0] quad_ctl;

	// instantiate  seven segment display for each digit 
	svn_seg_decoder u_sd0 (.seg_out(hex0), .bcd_in(digit0), .display_on(1'b1));
	svn_seg_decoder u_sd1 (.seg_out(hex1), .bcd_in(digit1), .display_on(1'b1));
	svn_seg_decoder u_sd2 (.seg_out(hex2), .bcd_in(digit2), .display_on(1'b1));
	svn_seg_decoder u_sd3 (.seg_out(hex3), .bcd_in(digit3), .display_on(1'b1));

	// instantiate up-down counter data path


	// instantiate rotation counter finite state machine
	

	// instantiate rotary encoder recoder
	rot_enc_rec u_rot (.quad_ctl, .q_a, .q_b, .clk);

endmodule
