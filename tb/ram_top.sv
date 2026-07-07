`include "ram_package.sv"
`include "ram_interface.sv"
`include "ram_test.sv"

module ram_top;

	bit clk;
	bit reset;

	always #5 clk = ~clk;

	ram_interface infc(clk,reset);

	ram_test test1(infc);

endmodule
