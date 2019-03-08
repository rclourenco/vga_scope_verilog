`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:00:37 11/02/2015 
// Design Name: 
// Module Name:    debounce 
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
module debounce(
    input clock,
    input inp,
    output reg outp
    );
reg [4:0]count;
reg st;

always @(posedge clock)
begin
	if(st==0)
	begin
		if(~inp)
		begin
			if(count < 31)
				count <= count + 1;
			else
				outp <= 1'b0;
		end
		else
		begin
			st    <= 1'b1;
			count <= 4'b0;
		end
	end
	else
	begin
		if(inp)
			if(count < 31)
				count <= count + 1;
			else
				outp <= 1'b1;
		else
		begin
			st    <= 1'b0;
			count <= 4'b0;
		end	
	end
end

endmodule
