package ram_package;
	// ram specs
	`define DATA_WIDTH 8
	`define DATA_DEPTH 32

	`define num_transactions 8

	// function to calculate address bit width
	function int log2(int n);
		log2 = 0;
		while(n>1) begin
			n = n >> 1;
			log2++;
		end
	endfunction

	// address bit width
	parameter ADDR_WIDTH = log2(`DATA_DEPTH);
	
	// testbench blocks
	`include "ram_transaction.sv"
	`include "ram_generator.sv"
	`include "ram_driver.sv"
	`include "ram_environment.sv"
endpackage
