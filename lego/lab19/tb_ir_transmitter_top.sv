`timescale 1ns / 1ps

module tb_ir_transmitter_top;

	logic clk;	// input signals
	logic [10:0] sw;
	logic btnC, btnL;
	logic emitter;
	real last_time, delta_time;
	logic mark;

	ir_transmitter_top uut (.emitter,
		.clk, .sw, .rst(btnC), .btnL(btnL));

	// set up clock signal
	always begin
		// 20 nsec period = 50 MHz
		clk = 0;
		#10;	// 5 nsec
		clk = 1;
		#10;	// 5 nsec
	end

	always @(posedge emitter) begin

		if (mark != 0) begin
			delta_time = ($realtime - last_time)/1000.0;
			$write("Bit length: %.4f usec - ", delta_time);
			if (delta_time > 1200.0) $display("Start/Stop bit");
			else if (delta_time > 526.0) $display("High bit");
			else if (delta_time > 316.0) $display("Low bit");
		end
		last_time = $realtime;	// save for the next loop
		#160000;	// wait for mark = 6 * 38 KHz - approximately 160 microsec
		mark = 1;
	end

	// take care of the last stop bit
	always begin
		// wait and check every microsec.
		if (mark != 0) begin
			delta_time = ($realtime - last_time)/1000.0;
			if (delta_time > 1200.0) begin
				$write("Bit length: %.4f usec - ", delta_time);
				$display("Start/Stop bit");
				mark = 0;
			end
		end
		#10000;	// delay 10 microsecs
	end

	initial begin
		// set up time format
		$timeformat(-9, 0, " ns", 4);
		$dumpfile("tb_ir_transmitter_top.vcd");
		$dumpvars();
		// set up time format
		$timeformat(-9, 0, " ns", 4);
		// use these to select only some of the signals
//		$dumpvars(1,tb_ir_emitter_top);
//		$dumpvars(1,tb_ir_emitter_top.uut);
//		$dumpvars(1,tb_ir_emitter_top.uut.u_fsm);
//		$dumplimit(15000000);

		last_time = 0.0;	// initialize last time
		mark = 0;

		btnC = 1;	// start with reset active
		btnL = 0;
		sw = 11'b101_1010_0101;

		#20;	// wait 20 nsec

		btnC = 0;	// reset inactive
		#600;	// wait a little bit
		btnL = 1;	// press button
		#21000000;	// wait 0.021 sec
		btnL = 0;

		#12000000;	// wait for transmission 

		$display("Simulation complete!!!");
		$finish;
	end

endmodule
