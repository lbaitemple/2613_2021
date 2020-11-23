//
// only need the clock as a top level input as
// all of the other signals are connected through
// the jtag interface
// 
module hf_top(input logic max10_clk1_50);

	// Peripheral interconnect signals
	logic [9:0] ledr;	// output signal to the LED's
	// output signals to the seven segment digits
	logic [7:0] hex0, hex1, hex2, hex3, hex4, hex5;
	logic [9:0] sw;	// input signals from the switches
	logic [1:0] key;	// input signals from the pushbuttons
	
	// Parameter interconnect signals
	logic [31:0] param1, param2, param3;

	// User instantiates design below
	// instantiate the design
	DE10_LITE_Temple_Top u_design (.ledr, .key, .sw);

	// tie up all of the unused outputs
	assign hex0 = 8'b11111111;
	assign hex1 = 8'b11111111;
	assign hex2 = 8'b11111111;
	assign hex3 = 8'b11111111;
	assign hex4 = 8'b11111111;
	assign hex5 = 8'b11111111;

	// IP to allow simple user design interfacing with developent kit					
	pin_ip platform_designer_pin_ip (.clock(max10_clk1_50), .leds(ledr),
		.seg7_0(hex0), .seg7_1(hex1), .seg7_2(hex2), .seg7_3(hex3),
		.seg7_4(hex4), .seg7_5(hex5), .sws(sw), .pbs(key), .param1,
		.param2, .param3);

endmodule
