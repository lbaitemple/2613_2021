`timescale 1ns / 1ps
module tb_divider;

	bit clk, rst, ena;	// input signals
	real last_time;
	logic tc;

	divider #(.BIT_SIZE(4)) uut (.*, .count(), .init_count(4'd9));

	// set up clock signal
	always begin
		clk = 0;
		#5;	// 5 nsec
		clk = 1;
		#5;	// 5 nsec
	end
	
	always @(posedge tc) begin
		$display ("Time for tc going high: %f nsec",$realtime);
	end
	
	always @(negedge tc) begin
		$display ("Time for tc going  low: %f nsec",$realtime);
	end

	initial begin
		$dumpfile("tb_divider.vcd");
		$dumpvars();
		// set up time format
		$timeformat(-9, 0, " ns", 4);
		$display("Testing divide by 10 - view and analyze timing diagram.");
		last_time = 0.0;
		rst = 1;	// start with reset active
		ena = 1;	// and enable on

		#10;	// wait 20 nsec

		rst = 0;	// reset inactive

		#390;	// wait 

		ena = 0;	// run a little with enable off
		#100;	// wait 

		ena = 1;	// and back on
		#400;	// wait 

		$display("Simulation complete!!!");
		$finish;
	end
endmodule
