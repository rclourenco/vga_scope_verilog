`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:42:38 11/22/2015 
// Design Name: 
// Module Name:    StringsRom 
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
module StringsRom(
    input [10:0] address,
    output reg [7:0] value
    );

always @(*) begin
	case(address)
		0:  value = "!";
		1:  value = "M";
		2:  value = "A";
		3:  value = "S";
		4:  value = "T";
		5:  value = "E";
		6:  value = "R";
		7:  value = " ";
		8:  value = "S";
		9:  value = "C";
		10: value = "O";
		11: value = "P";
		12: value = "E";
		13: value = "!";
		14: value = "";
		15: value = "C";
		16: value = "h";
		17: value = "1";
		18: value = " ";
		19: value = "V";
		20: value = "d";
		21: value = "i";
		22: value = "v";
		23: value = ":";
		24: value = "";
		25: value = "C";
		26: value = "h";
		27: value = "2";
		28: value = " ";
		29: value = "V";
		30: value = "d";
		31: value = "i";
		32: value = "v";
		33: value = ":";
		34: value = "";
		35: value = "T";
		36: value = "i";
		37: value = "m";
		38: value = "e";
		39: value = " ";
		40: value = "D";
		41: value = "i";
		42: value = "v";
		43: value = ":";
		44: value = "";
		default: value = 0;
	endcase
end

endmodule
