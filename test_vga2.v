`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:10:34 11/18/2015
// Design Name:   vga640x480
// Module Name:   /home/renato/prose/vga_scope/test_vga2.v
// Project Name:  vga_scope
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga640x480
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_vga2;

	// Inputs
	reg dclk;
	reg clr;

	// Outputs
	wire hsync;
	wire vsync;
	wire [4:0] red;
	wire [5:0] green;
	wire [4:0] blue;
	wire [7:0] color;
	wire [9:0] vc;
	wire [9:0] hc;

	// Instantiate the Unit Under Test (UUT)
	vga640x480 uut (
		.dclk(dclk), 
		.clr(clr), 
		.hsync(hsync), 
		.vsync(vsync), 
		.red(red), 
		.green(green), 
		.blue(blue),
		.color(color),
		.hc(hc),
		.vc(vc)
	);

assign color = hc%32;

	initial begin
		// Initialize Inputs
		dclk = 0;
		clr = 1;

		// Wait 100 ns for global reset to finish
		#90;
       clr = 0; 
		// Add stimulus here
		#10;
	end
always #20
	dclk = ~dclk;
      
endmodule

