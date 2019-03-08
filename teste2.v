`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:48:57 11/21/2015
// Design Name:   i2s_clkgen
// Module Name:   /home/renato/prose/vga_scope/teste2.v
// Project Name:  vga_scope
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: i2s_clkgen
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module teste2;

	// Inputs
	reg clk;
	reg resetn;
	reg enable;
	reg tick;
	reg [0:7] bclk_div_rate;
	reg [0:7] lrclk_div_rate;

	// Outputs
	wire bclk;
	wire lrclk;
	wire channel_sync;
	wire frame_sync;

parameter p1 = 4;
	// Instantiate the Unit Under Test (UUT)
	i2s_clkgen uut (
		.clk(clk), 
		.resetn(resetn), 
		.enable(enable), 
		.tick(tick), 
		.bclk_div_rate(p1), 
		.lrclk_div_rate(1'd1), 
		.bclk(bclk), 
		.lrclk(lrclk), 
		.channel_sync(channel_sync), 
		.frame_sync(frame_sync)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		resetn = 1;
		enable = 0;
		tick = 0;
		bclk_div_rate = 8'b00100000;
		lrclk_div_rate = 8'b11111111;

		// Wait 100 ns for global reset to finish
		#100;
		resetn = 0;
		enable = 1;
        
		// Add stimulus here

	end
      
	always #40
		clk = ~clk;
		
endmodule

