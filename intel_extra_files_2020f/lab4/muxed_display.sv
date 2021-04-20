//
// This module makes the DE10-Lite seven segment displays behave
// like they are time division multiplexed on the Basys3 board.
//
module muxed_display (output logic [7:0] hex3, hex2, hex1, hex0,
	input logic [3:0] an, input logic [6:0] cathode);

	always_comb begin
		// defaults - turn off display
		hex0 = 8'b11111111;
		hex1 = 8'b11111111;
		hex2 = 8'b11111111;
		hex3 = 8'b11111111;
		// DE10 are active low, Basys3 are active low
		// Anode is active low on Basys3
		if (an[0] == 1'b0) hex0[6:0] = cathode;
		if (an[1] == 1'b0) hex1[6:0] = cathode;
		if (an[2] == 1'b0) hex2[6:0] = cathode;
		if (an[3] == 1'b0) hex3[6:0] = cathode;
	end

endmodule
