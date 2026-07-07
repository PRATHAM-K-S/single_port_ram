class ram_transaction;

	// ram input signals
	rand bit [`DATA_WIDTH-1:0] data_in;
	rand bit write_enb;
	rand bit read_enb;
	rand bit [ADDR_WIDTH-1:0] address;

	constraint rd_wr_constraint {
		{read_enb, write_enb} inside {[0:2]};
	}

	function ram_transaction copy();
		copy = new();
		copy.data_in = this.data_in;
		copy.write_enb = this.write_enb;
		copy.read_enb = this.read_enb;
		copy.address = this.address;
	endfunction

	function void print(string str="[RAM TRANSACTION]");
		$display(str, $time, "data_in=%0h | write_enb=%0b | read_enb=%0b | address=%0h",
			this.data_in,
			this.write_enb,
			this.read_enb,
			this.address
		);
	endfunction

endclass
