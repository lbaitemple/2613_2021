module pin_ip(input logic clock, input logic [9:0] leds,
	input logic [7:0] seg7_0, seg7_1, seg7_2, seg7_3, seg7_4, seg7_5,
	output logic [9:0] sws, output [1:0] pbs,
	output logic [31:0] param1, param2, param3);

	//Reset makes time to connect to JTAG lower
	parameter reset_timeout = 2**8-1;
	logic [7:0] reset_count = 8'b0;

	//Allow device reset to be active for many clock cycles			
	always@(posedge clock)
		if(reset_count != (reset_timeout))
			reset_count = reset_count + 8'd1;

	internal_pin_if	i1 (.clk_clk(clock), .led31_to_0_export({seg7_1, seg7_0, 6'b0, leds}),
		.reset_reset_n(reset_count == reset_timeout),
		.pbs11_to_10_sws9_to_0_export({pbs, sws}),
		.led63_to_32_export({seg7_5, seg7_4, seg7_3, seg7_2}),
		.param1_export(param1),
		.param2_export(param2),
		.param3_export(param3));

endmodule
