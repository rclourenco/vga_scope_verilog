`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:52:58 11/18/2015 
// Design Name: 
// Module Name:    OscDataProc 
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
module OscDataProc(
    input clk,
    input rst,
    output [4:0] red,
    output [5:0] green,
    output [4:0] blue,
    output hsync,
    output vsync	 
    );

wire sclk;

	GenSamplingClk samplingClk2 (
		.clk(clk), 
		.rst(rst), 
		.sclk(sclk)
	);

reg wr;
reg [9:0] wrAddr;
wire [8:0] valueOne;
wire [8:0] valueTwo;

VDU vdu2(
	.clk(clk),
	.rst(rst),
	.red(red),	//red vga output
	.green(green), //green vga output
	.blue(blue),	//blue vga output
	.hsync(hsync),		//horizontal sync out
	.vsync(vsync),		//vertical sync out
	
	.wraddr1(wrAddr),
	.wrdata1(valueOne),
	.we1(wr),
	.wclk1(sclk),
	
	.wraddr2(wrAddr),
	.wrdata2(valueTwo),
	.we2(wr),
	.wclk2(sclk)
);

reg [9:0] romAddr;
reg [10:0] romAddr2;

wire [9:0] dv;
assign dv = romAddr2>>1;

WaveRomOne rom1(
	.address(dv),
	.data(valueOne)
);

WaveRomTwo rom2(
	.address(romAddr),
	.data(valueTwo)
);


always @(posedge sclk or posedge rst)
begin
	if(rst)
	begin
		wrAddr   <= 10'd0;
		romAddr  <= 10'd0;
		romAddr2 <= 10'd0;
		wr       <= 0;
	end
	else
	begin
		if (!wr)
		begin
			wr <= 1;
			wrAddr   <= wrAddr + 10'd1;
			romAddr  <= romAddr + 10'd1;
			romAddr2 <= romAddr2 + 10'd1;
			if(wrAddr == 639)
				wrAddr <= 10'd0;
			if(romAddr == 1023)
				romAddr <= 10'd0;
			if(romAddr2 == 2047)
				romAddr <= 10'd0;
		end
		else
		begin
			wr <= 0;
		end
	end
end

endmodule