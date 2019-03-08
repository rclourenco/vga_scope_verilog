`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:16:15 11/21/2015 
// Design Name: 
// Module Name:    VideoTextRam 
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
module VideoTextRam(
		input [11:0] wraddr,
		input [7:0] wrdata,
		input we,
		input clk,
		input [11:0] rdaddr,
		output reg [7:0] rddata
    );

reg [7:0] mem[0:2399];

always @(posedge clk) begin
	if(we)
		mem[wraddr] <= wrdata;
end

always @(*) begin
	rddata = mem[rdaddr];
end

endmodule
