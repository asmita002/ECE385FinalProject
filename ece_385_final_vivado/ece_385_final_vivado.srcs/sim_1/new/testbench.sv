module testbench_1(); //even though the testbench doesn't create any hardware, it still needs to be a module

	timeunit 10ns;	// This is the amount of time represented by #1 
	timeprecision 1ns;

	// These signals are internal because the processor will be 
	// instantiated as a submodule in testbench.
     logic Clk;
     logic reset_rtl_0;
    
    //USB signals
     logic [0:0] gpio_usb_int_tri_i;
     logic gpio_usb_rst_tri_o;
     logic usb_spi_miso;
     logic usb_spi_mosi;
     logic usb_spi_sclk;
     logic usb_spi_ss;
    
    //UART
     logic uart_rtl_0_rxd;
     logic uart_rtl_0_txd;
    
    //HDMI
     logic hdmi_tmds_clk_n;
     logic hdmi_tmds_clk_p;
     logic [2:0]hdmi_tmds_data_n;
     logic [2:0]hdmi_tmds_data_p;
        
    //HEX displays
     logic [7:0] hex_segA;
     logic [3:0] hex_gridA;
     logic [7:0] hex_segB;
     logic [3:0] hex_gridB;
				
	// Instantiating the DUT (Device Under Test)
	// Make sure the module and signal names match with those in your design
	// Note that if you called the 8-bit version something besides 'Processor'
	// You will need to change the module name
	mb_usb_hdmi_top mb_usb (.*);


	initial begin: CLOCK_INITIALIZATION
		Clk = 1;
	end 

	// Toggle the clock
	// #1 means wait for a delay of 1 timeunit, so simulation clock is 50 MHz technically 
	// half of what it is on the FPGA board 

	// Note: Since we do mostly behavioral simulations, timing is not accounted for in simulation, however
	// this is important because we need to know what the time scale is for how long to run
	// the simulation
	always begin : CLOCK_GENERATION
		#1 Clk = ~Clk;
	end

	// Testing begins here
	// The initial block is not synthesizable on an FPGA
	// Everything happens sequentially inside an initial block
	// as in a software program

	// Note: Even though the testbench happens sequentially,
	// it is recommended to use non-blocking assignments for most assignments because
	// we do not want any dependencies to arise between different assignments in the 
	// same simulation timestep. The exception is for reset, which we want to make sure
	// happens first. 
	initial begin: TEST_VECTORS
        reset_rtl_0 = 0;
        #64 reset_rtl_0 = 1;
        #64 reset_rtl_0 = 0;
        #1024 force mb_usb.ball_instance.keycode = 8'h1A;
        #128 release mb_usb.ball_instance.keycode;
        #1024
        
		$finish(); //this task will end the simulation if the Vivado settings are properly configured
        
//        run_i <= 0;
		
//		sw_i <= 8'hFF;	// Specify sw_i

//		#8 reset_load_clear <= 1;		// Toggle Reset (use blocking operator), because we want to have this happen 'first'

	
//		#8 reset_load_clear <= 0;

//		#16 sw_i <= 8'hFE;	// Change sw_i


//		#8 run_i <= 1;	// Toggle Execute
//		#16 run_i <= 0;

		// Aval is expected to be upper 8 bits of 8'h33 * 8'h55
		// Bval is expected to be lower 8 bits of 8'h33 * 8'h55
		
		//These are called 'immediate' assertions, because they assert if a condition is true
		//at the time of execution.
//		assert (Aval == ans_1a[15:8]) else $display("1st cycle A ERROR: Aval is %h", Aval);
//		assert (Bval == ans_1a[7:4]) else $display("1st cycle B ERROR: Bval is %h", Bval);
//		sw_i <= 8'h22;	           // Specify new sw_i
//		reset_load_clear <= 1;		// Toggle Reset (use blocking operator), because we want to have this happen 'first'

//		repeat (4) @(posedge Clk); //each @(posedge Clk) here means to wait for 1 clock edge, so this waits for 4 clock edges
	
//		reset_load_clear <= 0;

//		@(posedge Clk);
//		sw_i <= 8'h55;	// Change sw_i
   
//		repeat (4) @(posedge Clk); // Wait 4 cycles to let debouncer detect button

//		run_i <= 1;	// Toggle run_i
//		repeat (20) @(posedge Clk);
//		run_i <= 0;

//		ans_2b = (8'h22 * 8'h55); // Expected result of 2nd  cycle
//		// Aval is expected to stay the same
//		// Bval is expected to be the answer of 1st cycle XNOR 8'h55
//		assert (Aval == ans_2b[15:8]) else $display("1st cycle A ERROR: Aval is %h", Aval);
//		assert (Bval == ans_2b[7:4]) else $display("1st cycle B ERROR: Bval is %h", Bval);



	end

endmodule
