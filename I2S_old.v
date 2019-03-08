`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:50:20 11/19/2015 
// Design Name: 
// Module Name:    I2S 
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
module I2S(
		output wire bclk,
		output reg pbdata,
		output wire pblrc,
		input recdat,
		output wire reclrc,
		output wire mclk,
		input  sysclk,
		input  reset,
		output reg [23:0] sndCapL,
		output reg [23:0] sndCapR,
		input  [23:0] sndPlayL,
		input  [23:0] sndPlayR,
		output reg sampleclk
    );


reg frameclk;
assign pblrc  = frameclk;
assign reclrc = frameclk;

reg [3:0] clockdiv;
reg [8:0] clockcounter;

always @(posedge sysclk or posedge reset)
begin
	if(reset)
	begin
		clockdiv     <= 4'd0;
		clockcounter <= 4'b0;
	end
	else
	begin
		if(clockdiv == 4'd4)
		begin
			clockdiv     <= 4'b0;
			clockcounter <= clockcounter+4'b1;
		end
		else
		begin
			clockdiv <= clockdiv + 1;
		end
	end
	
end

assign mclk = clockcounter[0];
assign bclk = clockcounter[2];
wire lr;
assign lr = clockcounter[8];
reg os;

//always @(negedge bclk or posedge reset) begin
//	if(reset) begin
//		os <= lr;
//		frameclk <= 1;
//	end else begin
//		frameclk <= ( (os ^ lr)&lr );
//		os <= lr;
//	end
//end

always @(negedge bclk or posedge reset) begin
	if(reset) begin
		frameclk <= 1;
	end else begin
		frameclk <= lr;
	end
end

//
/*reg [5:0]st;
reg [5:0] countLeft;
reg [5:0] countRight;

reg [23:0] shiftRegLeft;
reg [23:0] shiftRegRight;
*/
reg [5:0] counter;
/*// receiver version one
always @(posedge bclk or posedge reset) begin
	if(reset) begin
		os <= frameclk;
		countLeft  <= 24;
		countRight <= 24;
		shiftRegLeft   <= sndPlayL;
		shiftRegRight  <= sndPlayR;
		sndCapL <= 24'd0;
		sndCapR <= 24'd0;
	end else begin
		os <= frameclk;
		
		if( os == frameclk && !frameclk ) begin
			reclrc <= 0;
			
			if(countLeft>0) begin
				countLeft <= countLeft-1;
				pbdata <= shiftRegLeft[23];
				shiftRegLeft[23:1] <= shiftRegLeft[22:0];
				sndCapL[0]    <= shiftRegLeft[23];
				sndCapL[23:1] <= sndCapL[22:0];
			end
			
		end else begin
			shiftRegLeft  <= sndPlayL;
			countLeft <= 24;
		end
		
		if( os == frameclk && frameclk ) begin
			reclrc <= 1;
			if(countRight>0) begin
				countRight <= countRight-1;
				pbdata <= shiftRegRight[23];
				shiftRegRight[23:1] <= shiftRegRight[22:0];
				sndCapR[0] <= shiftRegRight[23];
				sndCapR[23:1] <= sndCapR[22:0];
				
			end			
			
		end else begin
			shiftRegRight  <= sndPlayR;
			countRight <= 24;
		end
	end	
end
*/

reg [1:0] valid;
// receiver version two
always @(posedge bclk or posedge reset) begin
	if(reset) begin
		pbdata <= 0;
		os <= frameclk;
		counter  <= 0;
		sndCapL <= 24'd0;
		sndCapR <= 24'd0;
		sampleclk <= 0;
		valid <= 0;
	end else begin
		os <= frameclk;
		if(!frameclk) begin
			if( os!=frameclk ) begin
				counter<=24;
				sampleclk <= 0;
				valid <= 1;
			end else if( counter>0 ) begin
				counter <= counter - 1;
				sndCapL[0]    <= recdat;
				sndCapL[23:1] <= sndCapL[22:0];				
			end
		end
		
		if(frameclk) begin
			if( os!=frameclk ) begin
				counter<=24;
				valid <= valid + 1;
			end else if(counter>0) begin
				counter <= counter - 1;
				sndCapR[0]    <= recdat;
				sndCapR[23:1] <= sndCapR[22:0];				
			end else begin
				if(valid>=2) begin
					sampleclk <= 1;
				end
				valid <= 0;
			end
		end
		
	end	
end


endmodule
