//
// This module makes the DE10-Lite seven segment displays behave
// like they are time division multiplexed on the Basys3 board.
// Added latching for better performance when all 4 digits working.
//


module muxed_display_w_latch (output logic [7:0] hex5, hex4, hex3, hex2, hex1, hex0,
	input logic [3:0] an, input logic [6:0] cathode, input logic [4:0] w_data, 
	input logic [4:0] w_addr,
	input logic max10_clk1_50);
	
	
	function [6:0] svn_seg_to_bin;
	input [3:0] svn_seg;
	begin
		case (svn_seg)
		4'd0: svn_seg_to_bin = 7'b1000000;
		4'd1: svn_seg_to_bin = 7'b1111001;
		4'd2: svn_seg_to_bin = 7'b0100100;
		4'd3: svn_seg_to_bin = 7'b0110000;
		4'd4: svn_seg_to_bin = 7'b0011001;
		4'd5: svn_seg_to_bin = 7'b0010010;
		4'd6: svn_seg_to_bin = 7'b0000010;
		4'd7: svn_seg_to_bin = 7'b1111000;
		4'd8: svn_seg_to_bin = 7'b0000000;
		4'd9: svn_seg_to_bin = 7'b0010000;
		4'hA: svn_seg_to_bin = 7'b0100000;
		4'hB: svn_seg_to_bin = 7'b0000011;
		4'hC: svn_seg_to_bin = 7'b1000110;
		4'hD: svn_seg_to_bin = 7'b0100001;
		4'hE: svn_seg_to_bin = 7'b0000110;
		4'hF: svn_seg_to_bin = 7'b0001110;
		default: svn_seg_to_bin = 7'bxxxxxxx;
		endcase
	end
endfunction

	always_ff @(posedge max10_clk1_50) begin
		// DE10 are active low, Basys3 are active low
		// Anode is active low on Basys3
		if (an[0] == 1'b0) hex0 = {1'b1,cathode};
		if (an[1] == 1'b0) hex1 = {1'b1,cathode};
		if (an[2] == 1'b0) hex2 = {1'b1,cathode};
		if (an[3] == 1'b0) hex3 = {1'b1,cathode};
	end
	
	always_comb begin
	 	hex5 = {1'b1,svn_seg_to_bin(w_data)};
	 	
	 	case (w_addr[4])
	 	1'b0:	hex4 = {1'b1,svn_seg_to_bin({2'b00, w_addr[1:0]})};
	 	1'b1:	hex4 = {1'b1,svn_seg_to_bin({2'b01, w_addr[3:2]})};
	 	endcase
	end
endmodule
