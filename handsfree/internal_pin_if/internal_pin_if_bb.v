
module internal_pin_if (
	clk_clk,
	led31_to_0_export,
	led63_to_32_export,
	pbs11_to_10_sws9_to_0_export,
	reset_reset_n,
	param1_export,
	param2_export,
	param3_export);	

	input		clk_clk;
	input	[31:0]	led31_to_0_export;
	input	[31:0]	led63_to_32_export;
	output	[11:0]	pbs11_to_10_sws9_to_0_export;
	input		reset_reset_n;
	output	[31:0]	param1_export;
	output	[31:0]	param2_export;
	output	[31:0]	param3_export;
endmodule
