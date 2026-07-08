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
			if(vif.reset == 0) begin
				vif.drv_cb.data_in <= {`DATA_WIDTH{1'bz}};
				vif.drv_cb.write_enb <= 1'b0;
				vif.drv_cb.read_enb <= 1'b0;
				vif.drv_cb.address <= {ADDR_WIDTH{1'bz}};
			end
			else begin
				vif.drv_cb.data_in <= tr.data_in;
				vif.drv_cb.write_enb <= tr.write_enb;
				vif.drv_cb.read_enb <= tr.read_enb;
				vif.drv_cb.address <= tr.address;
		   	@(vif.drv_cb);	
			end
			mbx_drv_ref.put(tr);
			$display("[DRIVER/Mailbox_Object]", $time," %p", tr);
		end
	endtask

endclass
