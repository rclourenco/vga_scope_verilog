`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:38:30 11/21/2015 
// Design Name: 
// Module Name:    charRomX 
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
module charRomX(
    input [11:0] address,
    output reg [7:0] data
    );

wire [3:0] partial;
assign partial[3:0] = address[3:0];

always @(partial) begin
    case (partial)
            0: data = 48;
            1: data = 49;
            2: data = 50;
            3: data = 51;
            4: data = 52;
            5: data = 53;
            6: data = 54;
            7: data = 55;
            8: data = 56;
            9: data = 57;
           10: data = 65;
           11: data = 66;
           12: data = 67;
           13: data = 68;
           14: data = 69;
           15: data = 70;
		endcase
end

endmodule
