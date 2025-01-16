`timescale 1ns / 1ps

module tb_wrap_ir_emitter_dp;

	bit clk, rst, ena;	// input signals
	logic emitter_out;
	real last_time;
	integer i;

	wrap_ir_emitter_dp uut (.emitter_out, .clk, .rst, .ena);

	// set up clock signal
	always begin
		// 20 nsec period = 50 MHz
		clk = 0;
		#10;	// 10 nsec
		clk = 1;
		#10;	// 10 nsec
	end

	// timeout loop
	initial begin
		#3000000;	// timeout time
		$display("Simulation timeout!!!");
		$display("Likely error is there is no emitter_out signal.");
		$finish;
	end

	initial begin
		$dumpfile("tb_wrap_ir_emitter_dp.vcd");
		$dumpvars();
		// set up time format
		$timeformat(-9, 0, " ns", 4);
		last_time = 10.0;
		i = 0;	// to clean up unknowns

		rst = 1;	// start with reset active
		ena = 1;	// and enable on

		#10;	// wait 10 nsec

		rst = 0;	// reset inactive

		wait(emitter_out == 1'b1);
		wait(emitter_out == 1'b0);	// wait for emitter_out to toggle to low
		last_time = $realtime;	// save last_time for first iteration
		for (i=1; i < 21; i = i + 1) begin
			wait(emitter_out == 1'b1);
			wait(emitter_out == 1'b0);	// wait for emitter_out to toggle to low
			$display("Index %4d: Frequency %.2f kHz, Period %.4f msec",
				i, 1000000.0/($realtime - last_time),
				($realtime - last_time)/1000000.0);
			last_time = $realtime;	// save last_time for next loop
		end

		#1000;	// wait

		$display("Simulation complete!!!");
		$finish;
	end
endmodule
