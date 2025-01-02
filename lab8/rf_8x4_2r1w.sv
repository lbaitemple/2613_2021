//
// lab11 : version 06/12/2020
// 
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 8 word x 4 bit 2 read, 1 write register file
//
// Frank P. Higgins
//////////////////////////////////////////////////////////////////////////////////
module rf_8x4_2r1w(
	output logic [3:0] rs_data,
	output logic [3:0] ru_data,
	input logic clk,
	input logic [3:0] w_data,
	input logic [2:0] w_addr,
	input logic w_wr,
	input logic [2:0] rs_addr,
	input logic [2:0] ru_addr
	);

	logic [3:0] q_regfile [7:0];	// storage

	// synchronous logic
	always_ff @(posedge clk) begin
		if (w_wr == 1'b1) begin
			q_regfile[w_addr] <= w_data;
		end
	end
  

	// output multiplexer
	assign rs_data = q_regfile[rs_addr];
	assign ru_data = q_regfile[ru_addr];
	

endmodule
