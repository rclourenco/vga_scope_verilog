`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:11 11/16/2015 
// Design Name: 
// Module Name:    VgaModule 
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
module VgaModule(
    input pclk,
    input rst,
    input [3:0] pixel,
    output reg [4:0] r,
    output reg [5:0] g,
    output reg [4:0] b,
    output reg vsync,
    output reg hsync,
    output reg [9:0] px,
    output reg [9:0] py,
	 output reg drawon,
	 output reg borderon,
	 output reg [9:0] plcnt,
	 output reg [9:0] lncnt
    );


localparam VSyncStart = 2;
localparam VSyncEnd   = VSyncStart + 2;
localparam TopBorderStart = VSyncEnd + 25;
localparam TopBorderEnd   = TopBorderStart + 8;
localparam STARTLINE      = TopBorderEnd;
localparam ENDLINE        = STARTLINE + 480;
localparam BottomBorderStart = ENDLINE;
localparam BottomBorderEnd   = BottomBorderStart + 8;

localparam HSyncStart = 8;
localparam HSyncEnd        = HSyncStart + 96;
localparam LeftBorderStart = HSyncEnd + 40;
localparam LeftBorderEnd   = LeftBorderStart + 8;
localparam STARTDRAW       = LeftBorderEnd;
localparam ENDDRAW          = STARTDRAW + 640;
localparam RightBorderStart = ENDDRAW;
localparam RightBorderEnd   = RightBorderStart + 8;


always @(posedge pclk or posedge rst)
begin
	if (rst == 1)
	begin
		plcnt <= 0;
		lncnt <= 0;
		px    <= 0;
		py    <= 0;
		drawon <= 0;
		vsync <= 1;
		hsync <= 1;
		r     <= 0;
		g     <= 0;
		b     <= 0;
		borderon <= 0;
	end
	else 
	begin
		if (plcnt>=799)
		begin
			 plcnt <= 0;
			 lncnt <= lncnt + 1;			
			 px    <= 0;
			 if (lncnt+1>=VSyncStart && lncnt+1< VSyncEnd)
				vsync <= 0;
			 else
				vsync <= 1;
			 
			//count drawarea
			 if (lncnt+1>=STARTLINE && lncnt+1<ENDLINE)
			 begin
				 py <= py + 1;
			 end
			 else
			 begin
				py     <= 0;
				drawon <= 0;
			 end
			
			if(lncnt>=524)
			begin
				lncnt <= 0;
			end
		end
		else
		begin
			 plcnt <= plcnt + 1;
			 if( lncnt >= TopBorderStart && lncnt < BottomBorderEnd )
			 begin
				if (plcnt+1>=HSyncStart && plcnt+1< HSyncEnd)
					hsync <= 0;
				else
					hsync <= 1;
			 end
			 
			 if (lncnt>=STARTLINE && lncnt<ENDLINE)
			 begin
				 if (plcnt>=STARTDRAW && plcnt<ENDDRAW)
					px <= px + 1;
					
				 if (plcnt+1>=STARTDRAW && plcnt+1<ENDDRAW)
				 begin
					drawon <= 1;
					case(pixel)
						0: begin
								r <= 0;
								g <= 0;
								b <= 0;
							end
						1: begin
								r <= 5'h00;
								g <= 6'h00;
								b <= 5'h0F;
							end
						2: begin
								r <= 5'h00;
								g <= 6'h1F;
								b <= 5'h00;
							end
						3: begin
								r <= 5'h0F;
								g <= 6'h00;
								b <= 5'h00;
							end						
						4: begin
								r <= 5'h00;
								g <= 6'h1F;
								b <= 5'h0F;
							end						
						5: begin
								r <= 5'h0F;
								g <= 6'h00;
								b <= 5'h0F;
							end						
						6: begin
								r <= 5'h0F;
								g <= 6'h1F;
								b <= 5'h00;
							end						
						7: begin
								r <= 5'h0F;
								g <= 6'h1F;
								b <= 5'h0F;
							end						
						8: begin
								r <= 5'h07;
								g <= 6'h0F;
								b <= 5'h07;
							end						
						9: begin
								r <= 5'h00;
								g <= 6'h00;
								b <= 5'h1F;
							end						
						10: begin
								r <= 5'h00;
								g <= 6'h3F;
								b <= 5'h00;
							end						
						11: begin
								r <= 5'h1F;
								g <= 6'h00;
								b <= 5'h00;
							end						
						12: begin
								r <= 5'h00;
								g <= 6'h3F;
								b <= 5'h1F;
							end						
						13: begin
								r <= 5'h1F;
								g <= 6'h00;
								b <= 5'h1F;
							end						
						14: begin
								r <= 5'h1F;
								g <= 6'h3F;
								b <= 5'h00;
							end						
						15: begin
								r <= 5'h1F;
								g <= 6'h3F;
								b <= 5'h1F;
							end						
					endcase
				 end
				 else
				 begin
				   drawon <= 0;
					r <= 0;
					g <= 0;
					b <= 0;
				 end
			 end
			 else
			 begin
				drawon <= 0;
			 end
		end	 
			 
			 
	end
end // always



endmodule
