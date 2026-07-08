class ram_reference_model;

	// ram_transaction handle
	ram_transaction tr;

	// mailbox declerations
	mailbox #(ram_transaction) mbx_drv_ref;
	mailbox #(ram_transaction) mbx_ref_scr;

	// virtual interface declerations
	virtual ram_interface.REF vif;

	// ram memory decleration
	reg [`DATA_WIDTH-1:0] mem [`DATA_DEPTH-1:0];

	function new(
		mailbox #(ram_transaction) mbx_drv_ref,
		mailbox #(ram_transaction) mbx_ref_scr,
		virtual ram_interface.REF vif
	);
		this.mbx_drv_ref = mbx_drv_ref;
		this.mbx_ref_scr = mbx_ref_scr;
		this.vif = vif;
	endfunction

	task run();
		repeat(`num_transactions) begin
			mbx_drv_ref.get(tr);
			if(!vif.reset) begin
				tr.data_out = {`DATA_WIDTH{1'bz}};
				$display("[REFERENCE/RESET", $time, " %p", tr);
			end
			else begin
				if(tr.write_enb) begin
					mem[tr.address] = tr.data_in;
					$display("[REFERENCE/READ", $time, " %p", tr);
				end
				else if(tr.read_enb) begin
					tr.data_out = mem[tr.address];
					$display("[REFERENCE/READ", $time, " %p", tr);
				end
			end
			mbx_ref_scr.put(tr);
		end
	endtask

endclass
