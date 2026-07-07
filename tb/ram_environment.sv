class ram_environment;

	// mailbox declerations
	mailbox #(ram_transaction) mbx_gen_drv;
	mailbox #(ram_transaction) mbx_drv_ref;

	// testbench components handle declerations
	ram_generator gen;
	ram_driver drv;

	// virtual interface declerations
	virtual ram_interface.DRV vif_drv;

	function new(
		virtual ram_interface.DRV vif_drv
	);
		this.vif_drv = vif_drv;
	endfunction

	// environment configuration
	task build();
		
		// object creation for mailboxes
		mbx_gen_drv = new;
		mbx_drv_ref = new;

		// object creation for testbench components
		gen = new(mbx_gen_drv);
		drv = new(mbx_gen_drv, mbx_drv_ref, vif_drv);

	endtask

	// run environment
	task run();
		fork
			gen.run();
			drv.run();
		join
	endtask

endclass
