class ram_monitor;

	// ram_transaction handle
	ram_transaction tr;

	// mailbox declerations
	mailbox #(ram_transaction) mbx_mon_scr;

	// virtual interface decleration
	virtual ram_interface.MON vif;

	function new(
		mailbox #(ram_transaction) mbx_mon_scr,
		virtual ram_interface.MON vif
	);
		this.mbx_mon_scr = mbx_mon_scr;
		this.vif = vif;
	endfunction

	task run();
		repeat (`num_transactions) begin
			tr = new;
		 	@(vif.mon_cb);
			tr.data_in = vif.mon_cb.data_in;
			tr.write_enb = vif.mon_cb.write_enb;
			tr.read_enb = vif.mon_cb.read_enb;
			tr.address = vif.mon_cb.address;
	  	@(vif.mon_cb);
			tr.data_out = vif.mon_cb.data_out;
			mbx_mon_scr.put(tr);
			$display("[MONITOR]", $time, " %p",tr);
		end
	endtask

endclass
