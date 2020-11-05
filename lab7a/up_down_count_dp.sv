`timescale 1ns / 1ps

module up_down_count_dp (output logic [3:0] digit3, output logic [3:0] digit2,
	output logic [3:0] digit1, output logic [3:0] digit0,
	input logic enable, input logic up_down, input logic rst, input clk);

	logic c_out0, c_out1, c_out2;	// internal carry out signals

	// instantiate the 4 binary coded decimal counters
	up_down_bcd_counter u_bcd0 (.bcd(digit0), .carry_out(c_out0),
		.carry_in(enable), .up_down, .rst, .clk);

	up_down_bcd_counter u_bcd1 (.bcd(digit1), .carry_out(c_out1),
		.carry_in(c_out0), .up_down, .rst, .clk);

	up_down_bcd_counter u_bcd2 (.bcd(digit2), .carry_out(c_out2),
		.carry_in(c_out1), .up_down, .rst, .clk);

	up_down_bcd_counter u_bcd3 (.bcd(digit3), .carry_out(c_out3),
		.carry_in(c_out2), .up_down, .rst, .clk);

endmodule
