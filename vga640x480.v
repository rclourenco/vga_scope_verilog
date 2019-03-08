`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:38 03/19/2013 
// Design Name: 
// Module Name:    vga640x480 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vga640x480(
	input wire dclk,			//pixel clock: 25MHz
	input wire clr,			//asynchronous reset
	input wire [7:0] color,
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [4:0] red,	//red vga output
	output reg [5:0] green, //green vga output
	output reg [4:0] blue,	//blue vga output
	output reg [9:0] hc,
	output reg [9:0] vc
	);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

// registers for storing the horizontal & vertical counters

// Horizontal & vertical counters --
// this is how we keep track of where we are on the screen.
// ------------------------
// Sequential "always block", which is a block that is
// only triggered on signal transitions or "edges".
// posedge = rising edge  &  negedge = falling edge
// Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge dclk or posedge clr)
begin
	// reset condition
	if (clr == 1)
	begin
		hc <= 0;
		vc <= 0;
	end
	else
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

// display 100% saturation colorbars
// ------------------------
// Combinational "always block", which is a block that is
// triggered when anything in the "sensitivity list" changes.
// The asterisk implies that everything that is capable of triggering the block
// is automatically included in the sensitivty list.  In this case, it would be
// equivalent to the following: always @(hc, vc)
// Assignment statements can only be used on type "reg" and should be of the "blocking" type: =
always @(*)
begin
	// first check if we're within vertical active video range
	if (vc >= vbp && vc < vfp)
	begin
		if(hc>=hbp && hc < (hbp+640))
		begin
			case(color)
			 0: begin  // #00f
				  red   = 5'h00;
				  green = 6'h00;
				  blue  = 5'h00;
				end
			 1: begin  // #00f
				  red   = 5'h00;
				  green = 6'h00;
				  blue  = 5'h1f;
				end
			 2: begin  // #0f0
				  red   = 5'h00;
				  green = 6'h3f;
				  blue  = 5'h00;
				end
			 3: begin  // #be00ff
				  red   = 5'h1f;
				  green = 6'h00;
				  blue  = 5'h00;
				end
			 4: begin  // #f0f
				  red   = 5'h1f;
				  green = 6'h00;
				  blue  = 5'h1f;
				end
			 5: begin  // #ff00be
				  red   = 5'h1f;
				  green = 6'h00;
				  blue  = 5'h17;
				end
			 6: begin  // #ff0082
				  red   = 5'h1f;
				  green = 6'h00;
				  blue  = 5'h10;
				end
			 7: begin  // #ff0041
				  red   = 5'h1f;
				  green = 6'h3f;
				  blue  = 5'h1f;
				end
			 8: begin  // #f00
				  red   = 5'h1f;
				  green = 6'h00;
				  blue  = 5'h00;
				end
			 9: begin  // #ff4100
				  red   = 5'h1f;
				  green = 6'h10;
				  blue  = 5'h00;
				end
			 10: begin  // #ff8200
				  red   = 5'h1f;
				  green = 6'h20;
				  blue  = 5'h00;
				end
			 11: begin  // #ffbe00
				  red   = 5'h1f;
				  green = 6'h2f;
				  blue  = 5'h00;
				end
			 12: begin  // #ff0
				  red   = 5'h1f;
				  green = 6'h3f;
				  blue  = 5'h00;
				end
			 13: begin  // #beff00
				  red   = 5'h17;
				  green = 6'h3f;
				  blue  = 5'h00;
				end
			 14: begin  // #82ff00
				  red   = 5'h10;
				  green = 6'h3f;
				  blue  = 5'h00;
				end
			 15: begin  // #41ff00
				  red   = 5'h08;
				  green = 6'h3f;
				  blue  = 5'h00;
				end
			 16: begin  // #0f0
				  red   = 5'h00;
				  green = 6'h3f;
				  blue  = 5'h00;
				end
			 17: begin  // #00ff41
				  red   = 5'h00;
				  green = 6'h3f;
				  blue  = 5'h08;
				end
			 18: begin  // #00ff82
				  red   = 5'h00;
				  green = 6'h3f;
				  blue  = 5'h10;
				end
			 19: begin  // #00ffbe
				  red   = 5'h00;
				  green = 6'h3f;
				  blue  = 5'h17;
				end
			 20: begin  // #0ff
				  red   = 5'h00;
				  green = 6'h3f;
				  blue  = 5'h1f;
				end
			 21: begin  // #00beff
				  red   = 5'h00;
				  green = 6'h2f;
				  blue  = 5'h1f;
				end
			 22: begin  // #0082ff
				  red   = 5'h00;
				  green = 6'h20;
				  blue  = 5'h1f;
				end
			 23: begin  // #0041ff
				  red   = 5'h00;
				  green = 6'h10;
				  blue  = 5'h1f;
				end
			 24: begin  // #8282ff
				  red   = 5'h10;
				  green = 6'h20;
				  blue  = 5'h1f;
				end
			 25: begin  // #9e82ff
				  red   = 5'h13;
				  green = 6'h20;
				  blue  = 5'h1f;
				end
			 26: begin  // #be82ff
				  red   = 5'h17;
				  green = 6'h20;
				  blue  = 5'h1f;
				end
			 27: begin  // #df82ff
				  red   = 5'h1b;
				  green = 6'h20;
				  blue  = 5'h1f;
				end
			 28: begin  // #ff82ff
				  red   = 5'h1f;
				  green = 6'h20;
				  blue  = 5'h1f;
				end
			 29: begin  // #ff82df
				  red   = 5'h1f;
				  green = 6'h20;
				  blue  = 5'h1b;
				end
			 30: begin  // #ff82be
				  red   = 5'h1f;
				  green = 6'h20;
				  blue  = 5'h17;
				end
			 31: begin  // #ff829e
				  red   = 5'h1f;
				  green = 6'h20;
				  blue  = 5'h13;
				end
			default: begin
				red = 5'd0;
				green = 6'd0;
				blue = 5'd0;
				end
			endcase	
		end
		else
		begin
			red = 5'd0;
			green = 6'd0;
			blue = 5'd0;
		end
	end
	// we're outside active vertical range so display black
	else
	begin
		red = 5'd0;
		green = 6'd0;
		blue = 5'd0;
	end 
end //always

endmodule
