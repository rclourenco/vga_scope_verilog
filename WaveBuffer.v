`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:43:54 11/18/2015 
// Design Name: 
// Module Name:    WaveBuffer 
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
module WaveBuffer(
    input [9:0] wraddr,
    input [8:0] wrdata,
    input we,
    input clk,
    input [9:0] rdaddr,
    output reg [8:0] rddata,
	 output reg [8:0] rddataAfter,
	 output reg [8:0] rddataBefore
    );

reg [8:0] mem[0:1023];

always @(posedge clk)
begin
	if(we)
		mem[wraddr] <= wrdata;
end

always @(*)
begin
	rddata       = mem[rdaddr];
	rddataBefore = rdaddr > 0    ? mem[rdaddr-1] : 0;
	rddataAfter  = rdaddr < 1023 ? mem[rdaddr+1] : 0;
end
endmodule
