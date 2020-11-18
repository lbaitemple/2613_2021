//
// only need the clock as a top level input as
// all of the other signals are connected through
// the jtag interface
// 
module hf_top(input logic max10_clk1_50);

	// Peripheral interconnect signals
	logic [9:0] leds;	// output signal to the LED's
	// output signals to the seven segment digits
	logic [7:0] seg7_0, seg7_1, seg7_2, seg7_3, seg7_4, seg7_5;
	logic [9:0] sws;	// input signals from the switches
	logic [1:0] pbs;	// input signals from the pushbuttons
	
	// Parameter interconnect signals
	logic [31:0] param1, param2, param3;

	// User instantiates design below
	// instantiate the design
	DE10_LITE_Temple_Top u_design (.ledr(leds), .key(pbs), .sw(sws[2:0]));

	// tie up all of the unused outputs
	assign seg7_0 = 8'b11111111;
	assign seg7_1 = 8'b11111111;
	assign seg7_2 = 8'b11111111;
	assign seg7_3 = 8'b11111111;
	assign seg7_4 = 8'b11111111;
	assign seg7_5 = 8'b11111111;

	// IP to allow simple user design interfacing with developent kit					
	pin_ip platform_designer_pin_ip (.clock(max10_clk1_50), .leds,
		.seg7_0, .seg7_1, .seg7_2, .seg7_3, .seg7_4, .seg7_5,
		.sws, .pbs, .param1, .param2, .param3);

endmodule
