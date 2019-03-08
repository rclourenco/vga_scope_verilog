`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:12:00 11/19/2015 
// Design Name: 
// Module Name:    GenSamplingClk 
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
module GenI2CClk(
    input clk,
    input rst,
    output reg sclk
    );

reg [16:0] clockdiv;

always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		clockdiv <= 17'd0;
		sclk     <= 1'b0;
	end
	else
	begin
		if(clockdiv == 17'd500)
		begin
			clockdiv <=17'b0;
			sclk     <=1'b1;
		end
		else
		begin
			clockdiv <= clockdiv + 1;
			sclk     <= 1'b0;
		end
	end
end

endmodule
