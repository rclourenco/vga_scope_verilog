`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:15:04 11/22/2015 
// Design Name: 
// Module Name:    RTC 
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
module RTC(
    input clk,
    input rst,
    output [6:0] sec,
    output [6:0] min,
    output [6:0] hour,
    output reg [31:0] timestamp
    );

reg [25:0] clockdiv;
reg sclk;

always @(posedge clk or posedge rst) begin
	if(rst) begin
		clockdiv <= 26'd0;
		sclk     <= 1'b0;
	end else begin
		if(clockdiv == 26'd62_499_999) 	begin
			clockdiv <=26'b0;
			sclk     <= ~sclk;
		end else begin
			clockdiv <= clockdiv + 1;
		end
	end
end

assign sec =  timestamp % 60;
assign min =  (timestamp/60) % 60;
assign hour = (timestamp/3600) % 24;

always @(posedge sclk or posedge rst) begin
	if(rst) begin
		timestamp <= 0;
	end else begin
		timestamp <= timestamp + 1;
	end
end

endmodule
