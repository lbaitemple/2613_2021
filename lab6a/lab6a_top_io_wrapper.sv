`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module lab6a_top_io_wrapper(
	output [7:0] led,
	output [6:0] seg,
	output [3:0] an,
	output [2:0] JA,
	input [0:0] btnC,
	input [15:0] sw,
	input clk
	);

	assign led = 8'b00000000;	// disable the LED's
	 
	// Instantiate the top module ... todo pmod connections
	display_driver u1 (.cathode(seg), .anode(an), .anode_sel(JA[1:0]),
		.digit3(sw[15:12]), .digit2(sw[11:8]), .digit1(sw[7:4]),
		.digit0(sw[3:0]), .display_on(1'b1), .rst(btnC[0]), .clk);
	
endmodule
