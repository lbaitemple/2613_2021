`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module top_latch (output logic qa, output logic qb, output logic q_lvl,
	output logic q_latch, output logic q_ff,
	input logic s, input logic r, input logic d, input logic ck);

	sr_latch u_sr (.qa, .qb, .s, .r);
	lvl_sen_sr_latch u_lvl_sen (.q(q_lvl), .s, .r, .c(ck));
	transparent_d_latch u_tra (.q(q_latch), .d, .c(ck));
	d_flip_flop u_dff (.q(q_ff), .d, .clk(ck));

endmodule
