`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:09:05 11/27/2015 
// Design Name: 
// Module Name:    I2CMaster 
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
module I2CMaster(
    input clk,
    input reset,
    input [6:0] deviceID,
    input [6:0] register,
    input [8:0] din,
    input  enable,
	 input rw,
    output reg rdy,
    output [7:0] dout,
    output reg err,
	 inout scl,
	 inout sda,
	 output reg isclk,
	 output reg isdak,
	 output [3:0]stt
    );

reg [1:0] sclst;

reg isdak_prev;

always @(posedge clk or posedge reset) begin
	if(reset) begin
		isclk <= 1;
		isdak <= 1;
		isdak_prev <= 1;
		sclst <= 0;
	end else begin
		isdak_prev <= isdak;
		case(sclst)
			0: begin
					isclk <= 0;
					sclst <= 1;
					isdak <= 0;
				end
			1: begin
					isclk <= 0;
					sclst <= 2;
					isdak <= 1;
					end
			2: begin
					isclk <= 1;
					sclst <= 3;
					isdak <= 1;
			end
			3: begin
					if(!scl) begin
						sclst <= 2;
					end else begin
						isclk <= 1;
						sclst <= 0;
						isdak <= 0;
					end
			end
		endcase
	end
end


reg [3:0]state;
reg [3:0]cnt;
parameter [3:0]
	s2Ready        = 4'd0,
	s2Start        = 4'd1,
	s2DeviceAddr   = 4'd2,
	s2RegisterAddr = 4'd3,
	s2Data         = 4'd4,
	s2Stop         = 4'd5,
	s2Ack1         = 4'd6,
	s2Ack2         = 4'd7,
	s2Ack3         = 4'd8;
	
reg sdi;
reg clken;

reg [7:0]b1;
reg [7:0]b2;
reg [7:0]b3;
	
always @(posedge isdak or posedge reset) begin
	if(reset) begin
		sdi   <= 1;
		state <= s2Ready;
		rdy   <= 0;
		cnt   <= 7;
		b1 <= 0;
		b2 <= 0;
		b3 <= 0;
	end 
	else
	//if(isdak_prev==0 && isdak==1)
	begin
		case(state)
			s2Ready: begin
					if(enable) begin
						rdy <= 0;
						state <= s2Start;
						b1 <= {deviceID,1'b0};
						b2 <= {register,din[8]};
						b3 <= din[7:0];
					end else begin
						rdy <= 0;
						state <= s2Ready;
					end
				end
			s2Start: begin
					state <= s2DeviceAddr;
					rdy   <= 0;
					sdi   <= b1[cnt];
				end
			s2DeviceAddr: begin
					if(cnt==0) begin
						cnt   <= 7;
						sdi   <= 1;
						rdy   <= 0;
						state <= s2Ack1;
					end else begin
						cnt <= cnt - 1;
						sdi <= b1[cnt-1];
					end
				end
			s2Ack1: begin
					state <= s2RegisterAddr;
					rdy   <= 0;
					sdi   <= b2[cnt];
			end
			s2RegisterAddr: begin
					if(cnt==0) begin
						cnt   <= 7;
						sdi   <= 1;
						rdy   <= 0;
						state <= s2Ack2;
					end else begin
						cnt <= cnt - 1;
						sdi <= b2[cnt-1];
					end			
				end
			s2Ack2: begin
					state <= s2Data;
					rdy   <= 0;
					sdi   <= b3[cnt];
			end				
			s2Data: begin
					if(cnt==0) begin
						cnt   <= 7;
						sdi   <= 1;
						rdy   <= 0;
						state <= s2Ack3;
					end else begin
						cnt <= cnt - 1;
						sdi <= b3[cnt-1];
					end						
				end
			s2Ack3: begin
					state <= s2Stop;
			end								
			s2Stop: begin
					rdy <= 1;
					state <= s2Ready;
				end
		endcase
//	end else if(isdak_prev==1 && isdak==0) begin
	end
end

always @(negedge isdak or posedge reset) begin
	if(reset) begin
			clken <= 0;
			err   <= 0;
	end else begin
		case(state)
			s2Start: begin
					if(!clken) begin
						clken <= 1;
					end
					err <= 0;
				end
			s2Ack1: if(sda) begin
						err <= 1;
					end
			s2Ack2: if(sda) begin
						err <= 1;
					end
			s2Ack3:  if(sda) begin 
						err <= 1;
					end
			s2Stop: begin
					clken <= 0;
				end
		endcase		
	end
end


reg sdan;
always @(*) begin
	if(state == s2Start) begin
		sdan = isdak;
	end else if (state == s2Stop) begin
		sdan = ~isdak;
	end else begin
		sdan = sdi;
	end
end


assign scl =  (clken && isclk==0) ? 1'b0 : 1'bz; 
assign sda =  (sdan==0) ? 1'b0 : 1'bz; 

assign stt = state;

endmodule
