`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:55:35 11/17/2015
// Design Name:   GenVduClock
// Module Name:   /home/renato/prose/vga_scope/TestGenVduClock.v
// Project Name:  vga_scope
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: GenVduClock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestGenVduClock;

	// Inputs
	reg sysclk;
	reg rst;

	// Outputs
	wire vduclk;

	// Instantiate the Unit Under Test (UUT)
	GenVduClock uut (
		.sysclk(sysclk), 
		.rst(rst), 
		.vduclk(vduclk)
	);

	initial begin
		// Initialize Inputs
		sysclk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#90;
		rst = 0;
      	  
		// Add stimulus here

	end
	
		always #20
			sysclk <= ~sysclk;
	
      
endmodule

