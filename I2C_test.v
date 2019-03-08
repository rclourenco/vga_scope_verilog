`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:12:55 11/27/2015 
// Design Name: 
// Module Name:    I2C_test 
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
`define SpReset 0
`define SeReset 1
`define SpPowerUp1 2
`define SePowerUp1 3
`define SpLeftCh 4
`define SpLeftCh 5
`define SpRightCh 6
`define SpRightCh 7

`define SsmResetAddr  7'd9
`define SsmResetValue 9'd0


module I2C_test(
	 input clk,
    input reset,
	 output mclk,
    inout SDL,
    inout SCL,
	 output reg led1,
	 output reg led2,
	 output reg led3,
	 output reg led4,
	 output bclk,
	 output pblrc,
	 output reclrc,
	 output pbdata,
	 input recdat,
	 output mute
	 
    );

//wire reset;
//wire clk;
wire i2c_clk;

reg [6:0]register;
reg [8:0]din;
wire [8:0]dout;
reg enable;
reg rw;
wire rdy;
wire err;
wire isclk; 
wire isdak;
wire stt;
//reg pbdata;

GenI2CClk i2cclk(.clk(clk),.rst(reset),.sclk(i2c_clk));

I2CMaster i2c_audio(
		.clk(i2c_clk), 
		.reset(reset), 
		.deviceID(7'b0011010), 
		.register(register), 
		.din(din), 
		.enable(enable),
		.rw(rw),
		.rdy(rdy), 
		.dout(dout), 
		.err(err), 
		.scl(SCL), 
		.sda(SDL), 
		.isclk(isclk), 
		.isdak(isdak),
		.stt(stt)
    );

reg [3:0]state;

reg sndout;
reg mute;
reg [23:0]pause;

always @(posedge clk or posedge reset) begin
	if(reset) begin
		led1 <= 0;
		led4 <= 0;
		state <= 0;
		enable <= 0;
		rw     <= 0;
		sndout <= 0;
		mute <= 0;
	end else begin
		case(state)
			0: begin
					register <= 7'd6;
					din      <= 9'd0;
					enable   <= 1;
					state    <= 1;
				end
			1: begin
					if(rdy) begin
						state  <= 2;
						enable <= 0;
					end
					if(err) begin
						led1 <= 1;
						enable <= 0;
					end
				end
			2: begin
					register <= 7'd0;
					din      <= 9'b000010111;
					enable   <= 1;
					state    <= 3;			
			end
			3: begin
					if(rdy) begin
						state  <= 4;
						enable <= 0;
					end
					if(err) begin
						led1 <= 1;
						enable <= 0;
					end
				end
			4: begin
					register <= 7'd1;
					din      <= 9'b000010111;
					enable   <= 1;
					state    <= 5;			
			end
			5: begin
					if(rdy) begin
						state  <= 6;
						enable <= 0;
					end
					if(err) begin
						led1 <= 1;
						enable <= 0;
					end
			end
			6: begin
					register <= 7'd4;
					din      <= 9'd2;
					enable   <= 1;
					state    <= 7;			
			end
			7: begin
					if(rdy) begin
						state  <= 8;
						enable <= 0;
					end
					if(err) begin
						led1 <= 1;
						enable <= 0;
					end
			end			
			8: begin
					register <= 7'd7;
					din      <= 9'b001001010;
					enable   <= 1;
					state    <= 9;			
			end
			9: begin
					if(rdy) begin
						state  <= 10;
						enable <= 0;
						pause    <= 16'h0FFFFF;
					end
					if(err) begin
						led1 <= 1;
						enable <= 0;
					end
			end			

			10: begin
				pause <= pause - 16'd1;
				if(pause<2) begin
					state <= 11;
				end
			end
			
			11: begin
					register <= 7'd9;
					din      <= 9'd1;
					enable   <= 1;
					state    <= 12;
			end
			12: begin
					if(rdy) begin
						state  <= 13;
						enable <= 0;
					end
					if(err) begin
						led1 <= 1;
						enable <= 0;
					end
			end
			
			13: begin
				led4 <= 1;
				sndout <= 1;
				mute <= 1;
			end
		endcase
	end
end

reg [23:0] sndPlayL;
reg [23:0] sndPlayR;
wire [23:0] sndCapL;
wire [23:0] sndCapR;
wire sampleclk;


	I2S uut (
		.bclk(bclk), 
		.pbdata(pbdata), 
		.pblrc(pblrc), 
		.recdat(recdat), 
		.reclrc(reclrc), 
		.mclk(mclk), 
		.sysclk(clk), 
		.reset(reset), 
		.sndCapL(sndCapL), 
		.sndCapR(sndCapR), 
		.sndPlayL(sndPlayL), 
		.sndPlayR(sndPlayR), 
		.sampleclk(sampleclk),
		.enable(sndout)
	);

reg [16:0]counterx;

always @(posedge bclk or posedge reset) begin
		if(reset) begin
			sndPlayL <= 0;
			sndPlayR <= 0;
			led2 <= 0;
			counterx <= 0;
			led3 <= 0;
		end else if (sndout) begin
			counterx <= counterx + 17'd1;
			led2 <= 1;
			if(recdat && counterx > 10000 ) begin
				led3 <= 1;
			end
		end
end

//assign led4 = 

endmodule
