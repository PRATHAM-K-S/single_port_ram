class ram_environment;

	// mailbox declerations
	mailbox #(ram_transaction) mbx_gen_drv;
	mailbox #(ram_transaction) mbx_drv_ref;
	mailbox #(ram_transaction) mbx_ref_scr;
	mailbox #(ram_transaction) mbx_mon_scr;

	// testbench components handle declerations
	ram_generator gen;
	ram_driver drv;
	ram_reference_model refmdl;
	ram_monitor mon;

	// virtual interface declerations
	virtual ram_interface.DRV vif_drv;
	virtual ram_interface.REF vif_ref;
	virtual ram_interface.MON vif_mon;

	function new(
		virtual ram_interface.DRV vif_drv,
		virtual ram_interface.REF vif_ref,
		virtual ram_interface.MON vif_mon
	);
		this.vif_drv = vif_drv;
		this.vif_ref = vif_ref;
		this.vif_mon = vif_mon;
	endfunction

	// environment configuration
	task build();
		
		// object creation for mailboxes
		mbx_gen_drv = new;
		mbx_drv_ref = new;
		mbx_ref_scr = new;
		mbx_mon_scr = new;

		// object creation for testbench components
		gen = new(mbx_gen_drv);
		drv = new(mbx_gen_drv, mbx_drv_ref, vif_drv);
		refmdl = new(mbx_drv_ref, mbx_ref_scr, vif_ref);
		mon = new(mbx_mon_scr, vif_mon);

	endtask

	// run environment
	task run();
		fork
			gen.run();
			drv.run();
			refmdl.run();
			mon.run();
		join
	endtask

endclass
