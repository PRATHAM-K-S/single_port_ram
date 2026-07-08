`include "ram_package.sv"
`include "ram_interface.sv"
`include "ram_test.sv"
`include "../rtl/ram.v"

module ram_top;

	bit clk;
	bit reset;

	always #5 clk = ~clk;

	initial begin
		reset = 0;
		repeat(2) @(posedge clk);
		reset =1;
	end

	ram_interface infc(clk,reset);

	RAM DUV(
		.clk(clk),
		.reset(reset),
		.data_in(infc.data_in),
		.write_enb(infc.write_enb),
		.read_enb(infc.read_enb),
		.address(infc.address),
		.data_out(infc.data_out)
	);

	ram_test test1(infc);

endmodule
