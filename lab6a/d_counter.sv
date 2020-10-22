`timescale 1ns / 1ps

module d_counter (output logic [1:0] ms_bits, input logic clk, input logic rst);

	// signals for 17 bit counter
	logic [16:0] count, next_count;

	// assign the most significant bits
	assign ms_bits = count[16:15];

	// synchronous logic
	always_ff @(posedge clk) begin
		count <= next_count;
	end

	// combinational logic
	always_comb begin
		next_count = count + 1;
		if (rst == 1'b1) next_count = 0;
	end

endmodule
