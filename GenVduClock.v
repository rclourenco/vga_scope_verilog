`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:52:08 11/17/2015 
// Design Name: 
// Module Name:    GenVduClock 
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
module GenVduClock(
    input sysclk,
    input rst,
    output reg vduclk
    ); 

reg [2:0] clockdiv;

always @(posedge sysclk or posedge rst)
begin
	if(rst)
	begin
		clockdiv <= 3'd0;
		vduclk   <= 1'b0;
	end
	else
	begin
		if(clockdiv == 3'd4)
		begin
			clockdiv <=3'b0;
			vduclk   <=1'b1;
		end
		else
		begin
			clockdiv <= clockdiv + 1;
			vduclk   <= 1'b0;
		end
	end
end


endmodule
