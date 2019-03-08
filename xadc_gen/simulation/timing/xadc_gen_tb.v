// file: xadc_gen_tb.v
// (c) Copyright 2009 - 2011 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//----------------------------------------------------------------------------
// System Monitor wizard demonstration testbench
//----------------------------------------------------------------------------
// This demonstration testbench instantiates the example design for the 
//   System Monitor wizard. Input clock is generated in this testbench.
//----------------------------------------------------------------------------
// This testbench does not implement  checking of averaging and calibration
// Bipolar signals are applied with Vn = 0

`timescale 1ps/1ps
`define wait_eoc @(negedge EOC_TB)
`define wait_eoc_p @(posedge EOC_TB)
`define wait_eos @(posedge EOS_TB)
`define wait_drdy @(negedge DRDY_TB)
`define wait_drdy_p @(posedge DRDY_TB)
`define wait_done @(posedge BUSY_TB)
`define wait_busy @(negedge BUSY_TB)

module xadc_gen_tb ();

  // timescale is 1ps/1ps
  localparam  ONE_NS      = 1000;

  localparam time PER1    = 8*ONE_NS;
  // Declare the input clock signals
  reg         DCLK_TB     = 0;


  reg [6:0] DADDR_TB;
  reg DEN_TB;
  reg DWE_TB;
  reg [15:0] DI_TB;
  wire [15:0] DO_TB;
  wire DRDY_TB;

  reg RESET_TB;

  wire [2:0] ALM_unused;

  wire ALARM_OUT_TB;




  wire FLOAT_VCCAUX_ALARM;
  wire FLOAT_VCCINT_ALARM;
  wire FLOAT_USER_TEMP_ALARM;


  wire BUSY_TB;

  wire [4:0] CHANNEL_TB;

  wire EOC_TB;

  wire EOS_TB;






// Input clock generation

always begin
  DCLK_TB = #(PER1/2) ~DCLK_TB;
end


always @(posedge DCLK_TB or posedge RESET_TB)
begin
  if (RESET_TB) begin
   DADDR_TB = 7'b0000000; //{2'b00, CHANNEL_TB};
   DI_TB = 16'b0000000000000000;
   DWE_TB = 1'b0;
   DEN_TB = 1'b0; //EOC_TB;
  end
  else begin
   DADDR_TB = {2'b00, CHANNEL_TB};
   DI_TB = 16'b0000000000000000;
   DWE_TB = 1'b0;
   DEN_TB = EOC_TB;
  end
end
initial
begin
  $display ("Timing checks are not valid");
  assign RESET_TB = 1'b1;
  #(2*PER1);
  assign RESET_TB = 1'b0;
  #(1*PER1);
  $display ("Timing checks are valid");
end

// Start of the testbench

initial
  begin
   $display ("XADC is configured for Simultaneous Sampling Mode");
///////////////////////////////////////////////////////////////////////
///// Channel Sequencer Setup - Random selection of any no. of channels
///////////////////////////////////////////////////////////////////////
////////////////// Non-averaged sequencer channels ////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
////////////////// First round through the sequence ///////////////////
///////////////////////////////////////////////////////////////////////
  `wait_eoc_p;
  `wait_eoc;
  $display ("EOC is asserted.") ;
  `wait_drdy_p;
  `wait_drdy;
  $display ("DRDY is asserted. Valid data is on the DO bus") ;
  if( (DO_TB[15:4] <= (2732+4)) &&  (DO_TB[15:4] >= (2732-4)) ) begin
    $display ("Monitored temperature is within the expected range") ;
  end
  else begin
    $display ("Monitored temperature is out of expected range") ;
    $display ("ERROR !!!") ;
   $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/PER1);
    $finish;
  end
  `wait_eoc_p;
  `wait_eoc;
  $display ("EOC is asserted.") ;
  `wait_drdy_p;
  `wait_drdy;
  $display ("DRDY is asserted. Valid data is on the DO bus") ;
  if( DO_TB[15:4] == (1392)  ) begin
    $display ("Monitored Vccint in the Vccint Status register matched with the expected Vccint") ;
  end
  else begin
    $display ("Monitored Vccint in the Vccint Status register did not match with the expected Vccint") ;
    $display ("ERROR !!!") ;
   $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/PER1);
    $finish;
  end
  `wait_eoc_p;
  `wait_eoc;
  $display ("EOC is asserted.") ;
  `wait_drdy_p;
  `wait_drdy;
  $display ("DRDY is asserted. Valid data is on the DO bus") ;
  if( DO_TB[15:4] == (2048)) begin
    $display ("Monitored Vp/Vn is written correctly in the Vp/Vn Status register") ;
  end
  else begin
    $display ("Monitored Vp/Vn is not written correctly in the Vp/Vn Status register") ;
    $display ("ERROR !!!") ;
   $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/PER1);
    $finish;
  end
  `wait_eoc_p;
  `wait_eoc;
  $display ("EOC is asserted.") ;
  `wait_drdy_p;
  `wait_drdy;
  $display ("DRDY is asserted. Valid data is on the DO bus") ;
  if( DO_TB[15:4] == (2048)) begin
    $display ("Monitored Vauxp[6]/Vauxn[6] is written correctly in the Vauxp[6]/Vauxn[6] Status register") ;
  end
  else begin
    $display ("Monitored Vauxp[6]/Vauxn[6] is not written correctly in the Vauxp[6]/Vauxn[6] Status register") ;
    $display ("ERROR !!!") ;
   $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/PER1);
    $finish;
  end
  `wait_eoc_p;
  `wait_eoc;
  $display ("EOC is asserted.") ;
  `wait_drdy_p;
  `wait_drdy;
  $display ("DRDY is asserted. Valid data is on the DO bus") ;
  if( DO_TB[15:4] == (2048)) begin
    $display ("Monitored Vauxp[7]/Vauxn[7] is written correctly in the Vauxp[7]/Vauxn[7] Status register") ;
  end
  else begin
    $display ("Monitored Vauxp[7]/Vauxn[7] is not written correctly in the Vauxp[7]/Vauxn[7] Status register") ;
    $display ("ERROR !!!") ;
   $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/PER1);
    $finish;
  end
    $display ("Simulation Complete");
   $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/PER1);
    $finish;
    $display ("Simulation Complete");
   $display("SYSTEM_CLOCK_COUNTER : %0d\n",$time/PER1);
    $finish;
  end

  // Instantiation of the example design
  //---------------------------------------------------------
  xadc_gen_exdes dut (
      .DADDR_IN(DADDR_TB[6:0]),
      .DCLK_IN(~DCLK_TB),
      .DEN_IN(DEN_TB),
      .DI_IN(DI_TB[15:0]),
      .DWE_IN(DWE_TB),
      .RESET_IN(RESET_TB),
      .VAUXP6(1'b0),
      .VAUXN6(1'b0),
      .VAUXP7(1'b0),
      .VAUXN7(1'b0),
      .VAUXP14(1'b0),
      .VAUXN14(1'b0),
      .VAUXP15(1'b0),
      .VAUXN15(1'b0),
      .BUSY_OUT(BUSY_TB),
      .CHANNEL_OUT(CHANNEL_TB[4:0]),
      .DO_OUT(DO_TB[15:0]),
      .DRDY_OUT(DRDY_TB),
      .EOC_OUT(EOC_TB),
      .EOS_OUT(EOS_TB),
      .ALARM_OUT(ALARM_OUT_TB),
      .VP_IN(1'b0),
      .VN_IN(1'b0)

         );

endmodule



