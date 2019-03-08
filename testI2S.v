`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:51:59 11/19/2015
// Design Name:   I2S
// Module Name:   /home/renato/prose/vga_scope/testI2S.v
// Project Name:  vga_scope
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: I2S
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testI2S;

	// Inputs
//	reg recdat;
	reg sysclk;
	reg reset;
	reg [23:0] sndPlayL;
	reg [23:0] sndPlayR;

	// Outputs
	wire bclk;
	wire pbdata;
	wire pblrc;
	wire reclrc;
	wire mclk;
	wire [23:0] sndCapL;
	wire [23:0] sndCapR;
	wire sampleclk;
	wire [5:0] st;
	
	// Instantiate the Unit Under Test (UUT)
	I2S uut (
		.bclk(bclk), 
		.pbdata(pbdata), 
		.pblrc(pblrc), 
		.recdat(recdat), 
		.reclrc(reclrc), 
		.mclk(mclk), 
		.sysclk(sysclk), 
		.reset(reset), 
		.sndCapL(sndCapL), 
		.sndCapR(sndCapR), 
		.sndPlayL(sndPlayL), 
		.sndPlayR(sndPlayR), 
		.sampleclk(sampleclk)
	);

	initial begin
		// Initialize Inputs
		//recdat = 0;
		sysclk = 0;
		reset = 0;
		sndPlayL = 24'hAA5A5A;
		sndPlayR = 24'h805A51;

		// Wait 100 ns for global reset to finish
		#100;
		
      reset = 1;
		#100;
		reset = 0;
		// Add stimulus here

	end
	
	always #4
		sysclk = ~sysclk;
		
endmodule

