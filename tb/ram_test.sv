program automatic ram_test(ram_interface vif);

	import ram_package::*;

	// ram_environment handle
	ram_environment env;

	initial begin
		env = new(vif.DRV);
		env.build();
		env.run();
		$finish;
	end

endprogram
