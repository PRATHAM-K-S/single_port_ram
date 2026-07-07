class ram_generator;

	// ram_transaction handle
	ram_transaction tr;

	// mailbox for generator to driver
	mailbox #(ram_transaction) mbx_gen_drv;

	function new(mailbox #(ram_transaction) mbx_gen_drv);
		this.mbx_gen_drv = mbx_gen_drv;
		tr = new();
	endfunction

	task run();
		repeat(`num_transactions) begin
			if(tr.randomize())
				$display("[GENERATOR/Transaction_Object]", $time, "%p", tr);
				mbx_gen_drv.put(tr.copy());
		end
	endtask

	task print();
		repeat(`num_transactions) begin
			mbx_gen_drv.get(tr);
			$display("%p",tr);
		end
	endtask

endclass
