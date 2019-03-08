`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:10:06 11/17/2015 
// Design Name: 
// Module Name:    VDU 
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
module VDU(
    input clk,
    input rst,
    output [4:0] red,
    output [5:0] green,
    output [4:0] blue,
    output hsync,
    output vsync,
	 
    input [9:0] wraddr1,
    input [8:0] wrdata1,
    input we1,
	 input wclk1,

    input [9:0] wraddr2,
    input [8:0] wrdata2,
    input we2,
	 input wclk2,
	 
	 input [11:0] charRamAddr,
	 input [7:0]  charRamData,
	 input wchar,
	 input wcharclk,
	 
	 input linked,
	 input gridOn,
	 input textOff
    );


	wire vduclock;
	reg  [7:0] color;
	wire [9:0] hc;
	wire [9:0] vc;	
	
	GenVduClock uut (
		.sysclk(clk), 
		.rst(rst), 
		.vduclk(vduclk)
	);
	

vga640x480 vga_2(
	.dclk(vduclk),			//pixel clock: 25MHz
	.clr(rst),			//asynchronous reset
	.hsync(hsync),		//horizontal sync out
	.vsync(vsync),		//vertical sync out
	.red(red),	//red vga output
	.green(green), //green vga output
	.blue(blue),	//blue vga output
	.color(color),
	.hc(hc),
	.vc(vc)
	);
	

wire [2:0] charPoint;
wire [10:0] charRomLine;
wire [7:0] selCharLine;

wire [9:0] px;
wire [9:0] py;
wire [11:0] readCharRamAddr;
wire [7:0]  selChar;
assign px = hc-10'd144;
assign py = vc-10'd31;


assign readCharRamAddr = ((py/16)%30)*80+(px/8)%80;

//charRomX text(
//	.address(readCharRamAddr),
//	.data(selChar)
//);

VideoTextRam vtr (
	.wraddr(charRamAddr),
	.wrdata(charRamData),
	.we(wchar),
	.clk(wcharclk),
	.rdaddr(readCharRamAddr),
	.rddata(selChar)
);



//assign selChar   = charRam[readCharRamAddr];
assign charPoint = px%8;
assign charRomLine  = (selChar%256)*16+py%16;


 char_rom cr1 (
		.address(charRomLine),
		.data(selCharLine)
    );

wire charOn;
assign charOn = selCharLine[7-charPoint];

wire [8:0] valueOne;
wire [8:0] valueTwo;

wire [8:0] valueOneNext;
wire [8:0] valueTwoNext;

wire [8:0] valueOnePrev;
wire [8:0] valueTwoPrev;


WaveBuffer buffer1(
	.wraddr(wraddr1),
	.wrdata(wrdata1),
	.we(we1),
	.clk(wclk1),
	.rdaddr(px),
	.rddata(valueOne),
	.rddataAfter(valueOneNext),
	.rddataBefore(valueOnePrev)
);

wire eOneUp;
wire [8:0]oneStep;
assign eOneUp   = px < 639 && valueOneNext > valueOne;
assign eOneDown = px < 639 && valueOneNext < valueOne;
assign oneStep =    valueOne + (valueOneNext - valueOne)/2;

wire eOneUpPrev;
wire [8:0]oneStepPrev;
assign eOneUpPrev   = px > 0 && valueOnePrev > valueOne;
assign eOneDownPrev = px > 0 && valueOnePrev < valueOne;
assign oneStepPrev =  valueOne + (valueOnePrev - valueOne)/2;


WaveBuffer buffer2(
	.wraddr(wraddr2),
	.wrdata(wrdata2),
	.we(we2),
	.clk(wclk2),
	.rdaddr(px),
	.rddata(valueTwo),
	.rddataAfter(valueTwoNext),
	.rddataBefore(valueTwoPrev)
);



wire eTwoUp;
wire [8:0]twoStep;
assign eTwoUp   = px < 639 && valueTwoNext > valueTwo;
assign eTwoDown = px < 639 && valueTwoNext < valueTwo;
assign twoStep = valueTwo + (valueTwoNext - valueTwo)/2;

wire eTwoUpPrev;
wire [8:0]twoStepPrev;
assign eTwoUpPrev   = px > 0 && valueTwoPrev > valueTwo;
assign eTwoDownPrev = px > 0 && valueTwoPrev < valueTwo;
assign twoStepPrev  = valueTwo + (valueTwoPrev - valueTwo)/2;


wire [8:0]valueY1     = 120 + 64 - valueOne/4;
wire [8:0]midToNext1  = 120 + 64 - oneStep/4;
wire [8:0]midToPrev1  = 120 + 64 - oneStepPrev/4;

wire condDotY1   = (py == valueY1);

wire condLineToNext1 = eOneUp   && ( py >= midToNext1 && py < valueY1 ) ||
						     eOneDown && ( py >= valueY1 && py < midToNext1 );

wire condLineToPrev1 = eOneUpPrev   && ( py >= midToPrev1 && py < valueY1 ) ||
						     eOneDownPrev && ( py >= valueY1 && py < midToPrev1 );
						 
wire condY1 = condDotY1 || linked && ( condLineToNext1 || condLineToPrev1 );



wire [8:0]valueY2     = 360 + 64 - valueTwo/4;
wire [8:0]midToNext2  = 360 + 64 - twoStep/4;
wire [8:0]midToPrev2  = 360 + 64 - twoStepPrev/4;

wire condDotY2   = (py == valueY2);

wire condLineToNext2 = eTwoUp   && ( py >= midToNext2 && py < valueY2 ) ||
						     eTwoDown && ( py >= valueY2 && py < midToNext2 );
							  
wire condLineToPrev2 = eTwoUpPrev   && ( py >= midToPrev2 && py < valueY2 ) ||
						     eTwoDownPrev && ( py >= valueY2 && py < midToPrev2 );
							  
wire condY2 = condDotY2 || linked && ( condLineToNext2 || condLineToPrev2);						 


always @(*)
begin
	if(px<640 && py<480)
	begin
		if(charOn && ~textOff) begin
			color = 8'd4;
		end else if (condY1) begin
			color = 8'd2;
		end else	if (condY2) begin
			color = 8'd3;
		end else if ( gridOn && ( py == 120 || py == 360 ) ) begin
			color = 8'd7;
		end else if ( gridOn && ( px%16==0 || py%16==8 ) && py >= 56 && py <= 184 ) begin
			color = 8'd1;
		end else if ( gridOn && ( px%16==0 || py%16==8 ) && py >= 296 && py <= 424 ) begin
			color = 8'd1;			
		end else	begin
			color = 8'd0;
		end
	end
	else
	begin
		color = 8'd0;
	end
end


endmodule
