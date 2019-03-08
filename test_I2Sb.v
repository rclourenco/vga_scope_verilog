`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:54:35 11/21/2015
// Design Name:   I2Sb
// Module Name:   /home/renato/prose/vga_scope/test_I2Sb.v
// Project Name:  vga_scope
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: I2Sb
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_I2Sb;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] din;
	reg wd;
	reg [1:0] A;
	reg [15:0] I;

	// Outputs
	wire [7:0] dout;
	wire mck;
	wire sck;
	wire lrck;
	wire sd;

	// Instantiate the Unit Under Test (UUT)
	I2Sb uut (
		.clk(clk), 
		.reset(reset), 
		.din(din), 
		.dout(dout), 
		.wd(wd), 
		.A(A), 
		.mck(mck), 
		.sck(sck), 
		.lrck(lrck), 
		.sd(sd), 
		.I(I)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		din = 0;
		wd = 0;
		A = 0;
		I = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset=0;
        
		// Add stimulus here

	end
	
   always #20
		clk <= ~clk;
		
endmodule

