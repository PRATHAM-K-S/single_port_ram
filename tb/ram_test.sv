program automatic ram_test(ram_interface vif);

	import ram_package::*;

	// ram_environment handle
	ram_environment env;

	initial begin
		env = new(vif.DRV, vif.REF, vif.MON);
		env.build();
		env.run();
		repeat(2) @(vif.mon_cb);
		$finish;
	end

endprogram
