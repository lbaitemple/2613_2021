//
// This module makes the DE10-Lite seven segment displays behave
// like they are time division multiplexed on the Basys3 board.
// Added latching for better performance when all 4 digits working.
//
module muxed_display_w_latch (output logic [7:0] hex3, hex2, hex1, hex0,
	input logic [3:0] an, input logic [6:0] cathode,
	input logic max10_clk1_50);

	always_ff @(posedge max10_clk1_50) begin
		// DE10 are active low, Basys3 are active low
		// Anode is active low on Basys3
		if (an[0] == 1'b0) hex0 = {1'b1,cathode};
		if (an[1] == 1'b0) hex1 = {1'b1,cathode};
		if (an[2] == 1'b0) hex2 = {1'b1,cathode};
		if (an[3] == 1'b0) hex3 = {1'b1,cathode};
	end

endmodule
