interface ram_interface(input bit clk, input bit reset);

	import ram_package::*;

	// ram input signls
	logic [`DATA_WIDTH-1:0] data_in;
	logic write_enb;
	logic read_enb;
	logic [ADDR_WIDTH-1:0] address;

	// ram output signals
	logic [`DATA_WIDTH-1:0] data_out;

	// driver clocking block
	clocking drv_cb @(posedge clk);
		
		// input and output skew
		default output #2;

		// signal directions
		output data_in;
		output write_enb;
		output read_enb;
		output address;

	endclocking

	// monitor clocking block
	clocking mon_cb @(posedge clk);
		
		// input skew
		default input #2;

		// signal directions
		input data_in;
		input write_enb;
		input read_enb;
		input address;

	endclocking

	// signal direction rules
	modport DRV(clocking drv_cb, input reset);
	modport MON(clocking mon_cb, input reset);

endinterface
