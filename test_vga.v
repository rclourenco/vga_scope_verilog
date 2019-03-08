`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:15:29 11/16/2015
// Design Name:   VgaModule
// Module Name:   /home/renato/prose/vga_scope/test_vga.v
// Project Name:  vga_scope
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: VgaModule
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_vga;

	// Inputs
	reg pclk;
	reg rst;
	reg pixel;

	// Outputs
	wire [2:0] r;
	wire [2:0] g;
	wire [2:0] b;
	wire vsync;
	wire hsync;
	wire [9:0] px;
	wire [9:0] py;
	wire [9:0] plcnt;
	wire [9:0] lncnt;
	
	wire drawon;
	wire borderon;

	// Instantiate the Unit Under Test (UUT)
	VgaModule uut (
		.pclk(pclk), 
		.rst(rst), 
		.pixel(pixel), 
		.r(r), 
		.g(g), 
		.b(b), 
		.vsync(vsync), 
		.hsync(hsync), 
		.px(px), 
		.py(py), 
		.drawon(drawon),
		.borderon(borderon),
		.plcnt(plcnt),
		.lncnt(lncnt)
	);

	initial begin
		// Initialize Inputs
		pclk = 0;
		rst = 1;
		pixel = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 0;  
		// Add stimulus here

	end
	
	always #20
		pclk <= ~pclk;
      
endmodule

