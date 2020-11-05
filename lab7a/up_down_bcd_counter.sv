`timescale 1ns / 1ps

module up_down_bcd_counter (output logic [3:0] bcd, output logic carry_out,
	input logic carry_in, input logic up_down, input logic rst, input logic clk);

	logic [3:0] next_bcd;

	// sequential logic
	always_ff @(posedge clk) begin
		bcd <= next_bcd;
	end

	// combinational logic
	always_comb begin
		next_bcd = bcd;	// hold counter
		carry_out = 1'b0;	// default carry out value
		// only count if carry_in is active
		if (carry_in == 1'b1) begin
			if (up_down == 1'b1) begin	// count up
				next_bcd = bcd + 1;
				if (bcd == 4'd9) begin
					next_bcd = 0;
					carry_out = 1'b1;	// set carry out
				end
			end else begin	// count down
				next_bcd = bcd - 1;
				if (bcd == 4'd0) begin
					next_bcd = 4'd9;
					carry_out = 1'b1;	// set carry out
				end
			end
		end
		// take care of reset
		if (rst == 1'b1) next_bcd = 0;
	end

endmodule
