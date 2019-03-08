`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:13:40 11/21/2015 
// Design Name: 
// Module Name:    Main 
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
`define procWriteClock   100
`define procWriteString  200
`define procWriteInteger 300

`define strTitle 0
`define ChOneVdiv 15
`define ChTwoVdiv 25
`define TimeDivStr 35

module Main(
		 input clk,
		 input rst,
		 input sw1, //gridOn
		 input sw2, //linked,
		 input sw3, //textOff
		 input sw4, //triggerOn
		 input push1, // change Vdiv ch1
		 input push2, // change Vdiv ch2
		 input push3, // change TimeDiv
		 
		 output [4:0] red,
		 output [5:0] green,
		 output [4:0] blue,
		 output hsync,
		 output vsync,
		 
		 input VAUXP6, 
       input VAUXN6,
       input VAUXP7,
		 input VAUXN7,
		 input VAUXP14, 
       input VAUXN14,
       input VAUXP15,
		 input VAUXN15,
		 
       input VP_IN,
       input VN_IN

    );

wire RESET_IN = rst;
wire DCLK_IN  = clk;

wire dpush1;
wire dpush2;
wire dpush3;
wire linked;
wire gridOn;
wire textOff;
wire triggerOn;

debounce dbPush1(
    .clock(clk),
    .inp(push1),
    .outp(dpush1)
);

debounce dbPush2(
    .clock(clk),
    .inp(push2),
    .outp(dpush2)
);

debounce dbPush3(
    .clock(clk),
    .inp(push3),
    .outp(dpush3)
);

debounce dbSw1(
    .clock(clk),
    .inp(sw1),
    .outp(gridOn)
);

debounce dbSw2(
    .clock(clk),
    .inp(sw2),
    .outp(linked)
);

debounce dbSw3(
    .clock(clk),
    .inp(sw3),
    .outp(textOff)
);

debounce dbSw4(
    .clock(clk),
    .inp(sw4),
    .outp(triggerOn)
);


wire sclk;

	GenSamplingClk samplingClk2 (
		.clk(clk), 
		.rst(rst), 
		.sclk(sclk)
	);


reg wchar;
reg [7:0] wcharValue;
reg [11:0] wcharAddr;

reg wr;
reg [9:0] wrAddr;
reg [8:0] valueOne;
reg [8:0] valueTwo;

reg seqclk;

VDU vdu2(
	.clk(clk),
	.rst(rst),
	.red(red),	//red vga output
	.green(green), //green vga output
	.blue(blue),	//blue vga output
	.hsync(hsync),		//horizontal sync out
	.vsync(vsync),		//vertical sync out
	
	.wraddr1(wrAddr),
	.wrdata1(valueOne),
	.we1(wr),
	.wclk1(seqclk),
	
	.wraddr2(wrAddr),
	.wrdata2(valueTwo),
	.we2(wr),
	.wclk2(seqclk),
	
	.charRamAddr(wcharAddr),
	.charRamData(wcharValue),
	.wchar(wchar),
	.wcharclk(sclk),
	
	.linked(linked),
	.gridOn(gridOn),
	.textOff(textOff)
	
);

reg [9:0] romAddr;
reg [10:0] romAddr2;

wire [9:0] dv;
assign dv = romAddr2>>1;

reg [31:0] Temp;
reg [31:0] MaxChannels;
reg [31:0] Vccint;
reg [31:0] InputX;
reg signed [11:0] Input1;
reg signed [11:0] Input2;

reg signed [11:0] Aux1;
reg signed [11:0] Aux2;


reg [8:0] vreadOne;
reg [8:0] vreadTwo;

reg [3:0]ch1div;
reg [3:0]ch2div;
reg [3:0]timediv;

always @(posedge dpush1 or posedge rst) begin
	if(rst)
		ch1div <= 0;
	else if(ch1div < 4)
		ch1div <= ch1div + 4'd1;
	else
		ch1div <= 0;
end

always @(posedge dpush2 or posedge rst) begin
	if(rst)
		ch2div <= 0;
	else if(ch2div < 4)
		ch2div <= ch2div + 4'd1;
	else
		ch2div <= 0;
end

always @(posedge dpush3 or posedge rst) begin
	if(rst)
		timediv <= 0;
	else if(timediv < 4)
		timediv <= timediv + 4'd1;
	else
		timediv <= 0;
end

always @(*) begin
	case(ch1div)
		0: Aux1 = Input1;
		1: Aux1 = Input1/2;
		2: Aux1 = Input1/4;
		3: Aux1 = Input1/8;
		4: Aux1 = Input1/16;
	endcase
	if(Aux1<-255)
		Aux1=-255;
	if(Aux1>255)
		Aux1=255;
	vreadOne = Aux1 + 9'h100;
end

always @(*) begin
	case(ch2div)
		0: Aux2 = Input2;
		1: Aux2 = Input2/2;
		2: Aux2 = Input2/4;
		3: Aux2 = Input2/8;
		4: Aux2 = Input2/16;
	endcase
	if(Aux2<-255)
		Aux2=-255;
	if(Aux2>255)
		Aux2=255;
	vreadTwo = Aux2 + 9'h100;
end

reg oseq;
reg scanOn;
reg [3:0]scanCounter;

reg [8:0] lastValueOne;

always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		wrAddr   <= 10'd0;
		romAddr  <= 10'd0;
		romAddr2 <= 10'd0;
		wr       <= 0;
		valueOne <= 256;
		valueTwo <= 256;
		lastValueOne <= 256;
		oseq     <= 0;
		scanOn   <= 0;
		scanCounter <= 0;
	end
	else
	begin
		valueOne <= vreadOne;
		valueTwo <= vreadTwo;
		
		if(~seqclk) begin
			oseq <= 0;
		end else if (~oseq && seqclk) begin
		
			if(scanCounter<timediv) begin
				scanCounter <= scanCounter + 1;
			end else begin
				scanCounter <= 0;
			end
		
			if(scanCounter==0) begin
				lastValueOne <= valueOne;
				
				if(scanOn) begin
					wr <= 1;
					if(wrAddr<639) begin
						wrAddr   <= wrAddr + 10'd1;
					end else begin
						wrAddr <= 10'd0;
						if(triggerOn) begin
							scanOn <= 0;
						end
					end
				end else begin
					if(~triggerOn) begin
						wr <= 1;
						scanOn <= 1;
					end else if(lastValueOne<valueOne && valueOne >= 256+8) begin
						wr <= 1;
						scanOn <= 1;
					end
				end
			end
			oseq <= 1;
		end
		else
		begin
			wr <= 0;
		end
	end
end

reg [12:0]  st;       // main state machine - state
reg [12:0] counter;  // general purpose counter
reg [12:0]  rets;     // return state after routine
reg [11:0] writepos; // write offset
reg [10:0] stringAddr;
wire [7:0] currentChar;

reg [31:0] ticksBuffer;
wire [31:0] ticks;
wire [6:0] sec;
wire [6:0] min;
wire [6:0] hour;
reg [7:0]  stringBuffer[0:127];
reg [31:0] num;
reg [7:0]  padBefore;
reg [7:0]  padB;
reg [7:0]  padAfter;
reg [7:0]  padA;


RTC rtc(
    .clk(clk),
    .rst(rst),
    .sec(sec),
    .min(min),
    .hour(hour),
    .timestamp(ticks)
    );

StringsRom strings(
	.address(stringAddr),
	.value(currentChar)
);

wire BUSY_OUT;
wire [4:0]CHANNEL_OUT;
wire EOC_OUT;
wire EOS_OUT;
wire ALARM_OUT;
wire [15:0]DO_OUT;
reg  [6:0]DADDR_IN;
reg  DEN_IN;
reg  [15:0]DI_IN;
reg  DWE_IN;


//reg [15:0] readv1;
//reg [15:0] readv2;

xadc_gen xdacrd
(
      .DADDR_IN(DADDR_IN),
      .DCLK_IN(clk),
      .DEN_IN(DEN_IN),
      .DI_IN(DI_IN),
      .DWE_IN(DWE_IN),
      .RESET_IN(rst),
      .VAUXP6(VAUXP6), 
      .VAUXN6(VAUXN6),
      .VAUXP7(VAUXP7),
      .VAUXN7(VAUXN7),
      .VAUXP14(VAUXP14),
      .VAUXN14(VAUXN14),
      .VAUXP15(VAUXP15),
      .VAUXN15(VAUXN15),
      .BUSY_OUT(BUSY_OUT),
      .CHANNEL_OUT(CHANNEL_OUT),
      .DO_OUT(DO_OUT),
      .DRDY_OUT(DRDY_OUT),
      .EOC_OUT(EOC_OUT),
      .EOS_OUT(EOS_OUT),
      .ALARM_OUT(ALARM_OUT),
      .VP_IN(VP_IN),
      .VN_IN(VN_IN)
);

reg o_eoc;
reg o_eos;
reg o_drdy;
reg [3:0]state_adc;


always @(posedge clk or posedge rst) begin
	if(rst) begin
		DADDR_IN <= {2'b00, CHANNEL_OUT};
		DI_IN    <= 16'b0000000000000000;
		DWE_IN   <= 1'b0;
		DEN_IN   <= 1'b0;
		o_eoc    <= EOC_OUT;
		o_drdy   <= DRDY_OUT;
		state_adc <= 0;
		MaxChannels <= 0;
		seqclk <= 0;
	end else begin
		DADDR_IN <= {2'b00, CHANNEL_OUT};
		DI_IN    <= 16'b0000000000000000;
		DWE_IN   <= 1'b0;
		DEN_IN   <= EOC_OUT;
		o_eoc    <= EOC_OUT;
		o_drdy   <= DRDY_OUT;
		case(state_adc)
			0: begin // wait eoc
				seqclk <= 0;
				if( EOC_OUT == 0 && o_eoc == 1) begin
					state_adc <= 1;
				end
			end
			1: begin // wait rdy
				if( DRDY_OUT == 1 && o_drdy == 0) begin
					state_adc <= 2;
				end
			end
			2: begin
				case(CHANNEL_OUT)
					0: Temp   <= DO_OUT[15:4];
					1: Vccint <= DO_OUT[15:4];
					2: InputX <= DO_OUT[15:4];
					22: Input1 <= DO_OUT[15:4];
					23: begin 
							Input2 <= DO_OUT[15:4];
							seqclk <= 1;
						end
				endcase
				if(CHANNEL_OUT>MaxChannels) begin
					MaxChannels <= CHANNEL_OUT;
				end
				state_adc <= 0;
			end
			
		endcase
	end
end


always @(posedge sclk or posedge rst) begin
	if(rst) begin
		st    <= 0;
		wchar <= 0;
		wcharAddr <= 0;
		wcharValue <= 0;
		counter <= 0;
		rets <= 0;
		
	end else begin
		case(st)
			0: begin // clear screen
				counter <= 0;
				wchar   <= 1;
				wcharAddr <= 0;
				wcharValue <= 0;
				st <= 1;
			end
			1: begin
				wchar <= 1;
				if(counter<2399) begin
					counter <= counter + 1;
					wcharAddr <= wcharAddr + 1;
				end else begin
					counter <= 0;
					//st <= 2;
					st <= 4;
//					wcharValue <= ticks[31:28];
//					wcharAddr  <= 30;
//					ticksBuffer <= ticks<<4;
				end	
			end
			2: begin
				if(counter<7) begin
					counter <= counter + 1;
					wcharAddr <= wcharAddr + 1;
					wcharValue  <=  ticksBuffer[31:28] < 10 ? ticksBuffer[31:28] + 48 : ticksBuffer[31:28] + 55;
					ticksBuffer <= ticksBuffer << 4; 
				end else begin
					wchar <= 0;
					counter <= 0;
					st <= 4;
					wcharValue  <=  ticks[31:28] < 10 ? ticks[31:28] + 48 : ticks[31:28] + 55;
					wcharAddr  <= 30;
					ticksBuffer <= ticks<<4;
				end	
			end
			3: begin
					//wchar <= 1;
					counter <= 0;
					//st <= 2;
					st <= 4;
					//wcharValue <= ticksBuffer[31:28];
					//wcharAddr  <= 30;
					//ticksBuffer <= ticks<<4;
			end
			
			// goto write clock
			4: begin
				st    <= `procWriteClock; // write clock
				wchar <= 0;
				rets  <= 5;
				writepos <= 71;
			end
			
			// goto write string
			5: begin
				writepos <= 1;
				stringAddr <= `strTitle;
				st       <= `procWriteString;
				rets     <= 13; 
			end

			// goto write integer - disabled
			6: begin
				writepos <= 30+80;
				num      <= ticks;
				padBefore <= 8;
				padB      <= "0";
				padAfter  <= 10;
				padA      <= "#";
				st       <= `procWriteInteger;
				rets     <= 7;
			end

			// goto write integer - disabled
			7: begin
				writepos <= 30+80*3;
				num      <= Input1;
				padBefore <= 8;
				padB      <= "0";
				padAfter  <= 10;
				padA      <= "#";
				st       <= `procWriteInteger;
				rets     <= 8;
			end

			// goto write integer - disabled
			8: begin
				writepos <= 30+80*4;
				num      <= (Input1>>ch1div);
				padBefore <= 8;
				padB      <= "0";
				padAfter  <= 10;
				padA      <= "#";
				st       <= `procWriteInteger;
				rets     <= 9;
			end

			9: begin // disabled
				writepos <= 30+80*5;
				num      <= (Input1>>ch1div) % 256;
				padBefore <= 8;
				padB      <= "0";
				padAfter  <= 10;
				padA      <= "#";
				st       <= `procWriteInteger;
				rets     <= 10;
			end


			10: begin // disabled
				writepos <= 30+80*6;
				num      <= vreadOne;
				padBefore <= 8;
				padB      <= "0";
				padAfter  <= 10;
				padA      <= "#";
				st       <= `procWriteInteger;
				rets     <= 11;
			end

			11: begin // disabled
				writepos <= 30+80*7;
				num      <= vreadTwo;
				padBefore <= 8;
				padB      <= "0";
				padAfter  <= 10;
				padA      <= "#";
				st       <= `procWriteInteger;
				rets     <= 12;
			end

			12: begin // disabled
				writepos <= 30+80*9;
				num      <= MaxChannels;
				padBefore <= 8;
				padB      <= "0";
				padAfter  <= 10;
				padA      <= "%";
				st       <= `procWriteInteger;
				rets     <= 13;
			end

			// goto write string
			13: begin
				writepos   <= 80*14+1;
				stringAddr <= `ChOneVdiv;
				st         <= `procWriteString;
				rets       <= 14;
			end


			// goto write string
			14: begin
				writepos   <= 80*29+1;
				stringAddr <= `ChTwoVdiv;
				st         <= `procWriteString;
				rets       <= 15;
			end

			15: begin
				writepos <= 80*14+11;
				num      <= ch1div;
				padBefore <= 0;
				padB      <= " ";
				padAfter  <= 4;
				padA      <= " ";
				st       <= `procWriteInteger;
				rets     <= 16;
			end

			16: begin
				writepos <= 80*29+11;
				num      <= ch2div;
				padBefore <= 0;
				padB      <= " ";
				padAfter  <= 4;
				padA      <= " ";
				st       <= `procWriteInteger;
				rets     <= 17;
			end


			// goto write string
			17: begin
				writepos   <= 80*14+61;
				stringAddr <= `TimeDivStr;
				st         <= `procWriteString;
				rets       <= 18;
			end

			// goto write string
			18: begin
				writepos   <= 80*29+61;
				stringAddr <= `TimeDivStr;
				st         <= `procWriteString;
				rets       <= 19;
			end

			19: begin
				writepos <= 80*14+71;
				num      <= timediv;
				padBefore <= 0;
				padB      <= " ";
				padAfter  <= 4;
				padA      <= " ";
				st       <= `procWriteInteger;
				rets     <= 20;
			end

			20: begin
				writepos <= 80*29+71;
				num      <= timediv;
				padBefore <= 0;
				padB      <= " ";
				padAfter  <= 4;
				padA      <= " ";
				st       <= `procWriteInteger;
				rets     <= 3;
			end

			
			// Write Clock
			100: begin
					wchar      <= 1;
					wcharValue <= 48 + (hour/10)%10;
					wcharAddr  <= writepos;
					st <= st + 1;
				end
			101: begin
					wcharValue <= 48 + hour%10;
					wcharAddr  <= wcharAddr + 1;
					st <= st + 1;
				end
			102: begin
					wcharValue <= ":";
					wcharAddr  <= wcharAddr + 1;
					st <= st + 1;
				end
			103: begin
					wcharValue <= 48 + (min/10)%10;
					wcharAddr  <= wcharAddr + 1;
					st <= st + 1;
				end
			104: begin
					wcharValue <= 48 + min%10;
					wcharAddr  <= wcharAddr + 1;
					st <= st + 1;
				end
			105: begin
					wcharValue <= ":";
					wcharAddr  <= wcharAddr + 1;
					st <= st + 1;
				end
			106: begin
					wcharValue <= 48 + (sec/10)%10;
					wcharAddr  <= wcharAddr + 1;
					st <= st + 1;
				end
			107: begin
					wcharValue <= 48 + sec%10;
					wcharAddr  <= wcharAddr + 1;
					st <= st + 1;
				end
			108: begin
					wchar <= 0;
					st <= rets;
				end


			// write string
			200: begin
					wchar      <= 0;
					counter    <= 0;
					st <= st + 1;
				end
			201: begin
					if( currentChar && counter < 128 ) begin
						wchar <= 1;
						wcharValue <= currentChar;
						wcharAddr  <= writepos;
						stringAddr <= stringAddr + 1;
						counter <= counter + 1;
						st <= st + 1;
					end else begin
						wchar <= 0;
						st <= rets;
					end
				end
			202: begin
					if( currentChar && counter < 128 ) begin
						wchar <= 1;
						wcharValue <= currentChar;
						wcharAddr  <= wcharAddr + 1;
						stringAddr <= stringAddr + 1;
						counter <= counter + 1;
					end else begin
						wchar <= 0;
						st <= rets;
					end
				end
				
			300: begin //write integer
				wchar      <= 0;
				counter    <= 0;
				st <= 301;
				
				end
			301: begin
					stringBuffer[counter] <= "0"+num%10;
					counter <= counter + 1;
					if( num/10 > 0) begin
						num     <= num/10;
					end else if(padBefore) begin
						st <= 302;
					end else begin
						st <= 303;
					end
				end
				
			302: begin // common: write integer, write real
					if(counter<padBefore) begin
						stringBuffer[counter] = padB;
						counter <= counter + 1;
					end else begin
						st <= 303;
					end
				end
			303: begin
						if(padAfter>counter) begin
							padAfter <= padAfter - counter;
						end else begin
							padAfter <= 0;
						end
						st <= 304;		
					end
			304: begin
						if(counter) begin
							wchar <= 1;
							wcharValue <= stringBuffer[counter-1];
							wcharAddr  <= writepos;
							counter    <= counter -  1;
							st <= 305;
						end else begin
							wchar <= 0;
							st    <= 306;
						end
				end
			305: begin
						if(counter > 0) begin
							wchar <= 1;
							wcharValue <= stringBuffer[counter-1];
							wcharAddr  <= wcharAddr + 1;
							counter    <= counter -  1;
						end else begin
							wchar <= 0;
							st    <= 306;
						end
					end
			306: begin
					if( padAfter ) begin
						wchar <= 1;
						wcharValue <= padA;
						wcharAddr  <= wcharAddr + 1;
						padAfter   <= padAfter - 1;
					end else begin
						wchar <= 0;
						st <= rets;
					end
				end
				
		endcase
	end
end


endmodule
