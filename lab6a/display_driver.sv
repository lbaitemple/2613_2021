`timescale 1ns / 1ps

module display_driver( output logic [6:0] cathode, output logic [3:0] anode,
	output logic [1:0] anode_sel,
	input logic [3:0] digit3, input logic [3:0] digit2, input logic [3:0] digit1,
	input logic [3:0] digit0, input logic display_on, input logic rst, input logic clk);

	// internal signals
	logic [3:0] bcd_in; // output of mux, input to seven segment decoder

	// digit multiplexer
	always_comb begin
		case (anode_sel)
			2'b00: bcd_in = digit0;
			2'b01: bcd_in = digit1;
			2'b10: bcd_in = digit2;
			default: bcd_in = digit3;
		endcase
	end

	// instantiate the modules
	svn_seg_decoder u_sd (.seg_out(cathode), .bcd_in, .display_on);
	anode_decoder u_ad (.anode, .switch_in(anode_sel));
	d_counter u_dc (.ms_bits(anode_sel), .clk, .rst);

endmodule
