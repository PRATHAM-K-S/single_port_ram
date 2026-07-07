class ram_driver;

	// ram_transaction handle
	ram_transaction tr;

	// mailboxes from the generator and to the reference model
	mailbox #(ram_transaction) mbx_gen_drv;
	mailbox #(ram_transaction) mbx_drv_ref;

	// virtual interface
	virtual ram_interface.DRV vif;

	function new(
		mailbox #(ram_transaction) mbx_gen_drv,
		mailbox #(ram_transaction) mbx_drv_ref,
		virtual ram_interface.DRV vif
	);
		this.mbx_gen_drv = mbx_gen_drv;
		this.mbx_drv_ref = mbx_drv_ref;
		this.vif = vif;
	endfunction

	task run();
		repeat(`num_transactions) begin
			@(vif.drv_cb);
			mbx_gen_drv.get(tr);
			$display("[DRIVER/Mailbox_Object]", $time," %p", tr);
		end
	endtask

endclass
