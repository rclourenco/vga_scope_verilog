`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:50:40 09/20/2008 
// Design Name: 
// Module Name:    I2S 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
// I2S interface
// For interfacing up to I2S devices such as delta sigma converters
// Created by Jim Patchell for his FPGA based digital synthesizer
// Copyright (c) 2008 by James Patchell
// This code may be freely used as long as this notice remains in the file.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module I2Sb(clk, reset, din, dout, wd, A, mck, sck, lrck, sd, I);
    input clk;					//system clock
    input reset;				//system reset
    input [7:0] din;			//data in from AVR
    output [7:0] dout;		//data out to AVR
	 input wd;					//write strobe from AVR
	 input [1:0] A;			//register select from AVR
    output mck;				//master I2S clock
    output sck;				//I2S Serial Clock
    output lrck;				//left-right clock
    output sd;					//serial data
    input [15:0] I;			//data input

/****************************************************************
* for the time being, this is going to be mono-we send the same
* data out for both left and write channels
****************************************************************/

	reg mck;
	reg sck;
	reg lrck;
	wire sd;
	
	reg [7:0] dout;
	reg [15:0] shifter;
	reg [7:0] mckDiv,mckDivCntr;
	reg [7:0] sckDiv,sckDivCntr;
	reg [7:0] lrDiv,lrDivCntr;
	reg wdmckDiv,wdsckDiv,wdlrDiv;
	reg fd1,fd2,ldSR;
	
	parameter ADR_MCLKDIV			=	2'b00;
	parameter ADR_LRDIV				=	2'b01;
	parameter ADR_SCKDIV				=	2'b10;
	
	//-----------------------------------------------------
	// Master Clock Divider
	//-----------------------------------------------------
	
	always @ (A or wd)
		if((A == ADR_MCLKDIV) && wd)
			wdmckDiv = 1;
		else
			wdmckDiv = 0;
			
	always @ (posedge clk or posedge reset)
		if(reset)
			//mckDiv <= 0;		//master reset
			mckDiv <= 8'd4;
		else if (wdmckDiv)
			mckDiv <= din;		//write data into register
			
	always @(posedge clk or posedge reset)
		if(reset)
			mckDivCntr <= 0;
		else if (mckDivCntr == 0)
			mckDivCntr <= mckDiv;	//reload divider
		else
			mckDivCntr <= mckDivCntr - 1;	//count down
			
	always @ (posedge clk or posedge reset)
		if(reset)
			mck <= 0;
		else if (mckDivCntr == 0)
			mck <= !mck;	//toggle master clock
			
	//------------------------------------------------------
	// SCK divider
	//------------------------------------------------------
	
	always @ (A or wd)
		if((A == ADR_SCKDIV) && wd)
			wdsckDiv = 1;
		else
			wdsckDiv = 0;
			
	always @ (posedge clk or posedge reset)
		if(reset)
			sckDiv <= 8'd3;
		else if (wdsckDiv)
			sckDiv <= din;
			
	always @(posedge clk or posedge reset)
		if(reset)
			sckDivCntr <= 0;
		else if ((sckDivCntr == 0) && (mckDivCntr == 0))
			sckDivCntr <= sckDiv;
		else if (mckDivCntr == 0)
			sckDivCntr <= sckDivCntr - 1;
			
	always @ (posedge clk or posedge reset)
		if(reset)
			sck <= 0;
		else if ((sckDivCntr == 0) && (mckDivCntr == 0))
			sck <= !sck;		//toggle serial bit
			
	//----------------------------------------------------------
	// LR clock divider
	//----------------------------------------------------------
	
	always @ (A or wd)
		if(( A == ADR_LRDIV) && wd)
			wdlrDiv = 1;
		else
			wdlrDiv = 0;
			
	always @ (posedge clk or posedge reset)
		if(reset)
			lrDiv <= 8'd255;
		else if (wdlrDiv)
			lrDiv <= din;
			
	always @ (posedge clk or posedge reset)
		if(reset)
			lrDivCntr <= 0;
		else if ((lrDivCntr == 0)  && (mckDivCntr == 0) && !mck)
			lrDivCntr <= lrDiv;
		else if ((mckDivCntr == 0) && !mck)
			lrDivCntr <= lrDivCntr - 1;
	
	always @ (posedge clk or posedge reset)
		if(reset)
			lrck <= 0;
		else if ((lrDivCntr == 0)  && (mckDivCntr == 0) && !mck)
			lrck <= !lrck;

	//------------------------------------------------------
	// Shift register
	//------------------------------------------------------
	always @ (posedge clk or posedge reset)
		if(reset)
			shifter <= 0;
		else if (ldSR)
			shifter <= I;
		else if ((sckDivCntr == 0) && (mckDivCntr == 0) && sck)
			shifter <= {shifter[14:0],1'b0};

		assign sd = shifter[15];
			
	//------------------------------------------------------
	// Data frame detect
	//------------------------------------------------------
		
	always @ (posedge clk or posedge reset) begin
		if(reset) begin
			fd1 <= 0;
			fd2 <= 0;
		end
		else begin
			if((sckDivCntr == 0) && (mckDivCntr == 0) && !sck && !mck) begin
				fd1 <= lrck;
				fd2 <= fd1;
			end
		end
	end
		
	always @(fd1 or fd2 or sckDivCntr or mckDivCntr)
		if( (fd1 ^ fd2) & ((sckDivCntr == 0) && (mckDivCntr == 0) && sck && !mck) )
			ldSR = 1;
		else
			ldSR = 0;

	//-------------------------------------------------------
	// data output
	//-------------------------------------------------------
	
	always @ (A or mckDiv or sckDiv or lrDiv)
		case(A)
			ADR_MCLKDIV:dout = mckDiv;
			ADR_LRDIV:dout = lrDiv;	
			ADR_SCKDIV:dout = sckDiv;
			default: dout = 8'h9c;
		endcase
		
endmodule					
