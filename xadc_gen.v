// file: xadc_gen.v
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
`timescale 1ns / 1 ps

(* CORE_GENERATION_INFO = "xadc_gen,xadc_wiz_v2_1,{component_name=xadc_gen,dclk_frequency=125,enable_busy=true,enable_convst=false,enable_convstclk=false,enable_dclk=true,enable_drp=true,enable_eoc=true,enable_eos=true,enable_vbram_alaram=false,enable_vccddro_alaram=false,enable_vccpaux_alaram=false,enable_Vccint_Alaram=false,enable_Vccaux_alaram=false,enable_vccpint_alaram=false,ot_alaram=false,user_temp_alaram=false,timing_mode=continuous,channel_averaging=None,sequencer_mode=on,startup_channel_selection=simultaneous_sampling}" *)


module xadc_gen
          (
          DADDR_IN,            // Address bus for the dynamic reconfiguration port
          DCLK_IN,             // Clock input for the dynamic reconfiguration port
          DEN_IN,              // Enable Signal for the dynamic reconfiguration port
          DI_IN,               // Input data bus for the dynamic reconfiguration port
          DWE_IN,              // Write Enable for the dynamic reconfiguration port
          RESET_IN,            // Reset signal for the System Monitor control logic
          VAUXP6,              // Auxiliary channel 6
          VAUXN6,
          VAUXP7,              // Auxiliary channel 7
          VAUXN7,
          VAUXP14,             // Auxiliary channel 14
          VAUXN14,
          VAUXP15,             // Auxiliary channel 15
          VAUXN15,
          BUSY_OUT,            // ADC Busy signal
          CHANNEL_OUT,         // Channel Selection Outputs
          DO_OUT,              // Output data bus for dynamic reconfiguration port
          DRDY_OUT,            // Data ready signal for the dynamic reconfiguration port
          EOC_OUT,             // End of Conversion Signal
          EOS_OUT,             // End of Sequence Signal
          ALARM_OUT,           // OR'ed output of all the Alarms    
          VP_IN,               // Dedicated Analog Input Pair
          VN_IN);

          input [6:0] DADDR_IN;
          input DCLK_IN;
          input DEN_IN;
          input [15:0] DI_IN;
          input DWE_IN;
          input RESET_IN;
          input VAUXP6;
          input VAUXN6;
          input VAUXP7;
          input VAUXN7;
          input VAUXP14;
          input VAUXN14;
          input VAUXP15;
          input VAUXN15;
          input VP_IN;
          input VN_IN;

          output BUSY_OUT;
          output [4:0] CHANNEL_OUT;
          output [15:0] DO_OUT;
          output DRDY_OUT;
          output EOC_OUT;
          output EOS_OUT;
          output ALARM_OUT;

        wire FLOAT_VCCAUX;
        wire FLOAT_VCCINT;
        wire FLOAT_TEMP;
          wire GND_BIT;
    wire [2:0] GND_BUS3;
          assign GND_BIT = 0;
          wire [15:0] aux_channel_p;
          wire [15:0] aux_channel_n;
          wire [7:0]  alm_int;
          assign ALARM_OUT = alm_int[7];
          assign aux_channel_p[0] = 1'b0;
          assign aux_channel_n[0] = 1'b0;

          assign aux_channel_p[1] = 1'b0;
          assign aux_channel_n[1] = 1'b0;

          assign aux_channel_p[2] = 1'b0;
          assign aux_channel_n[2] = 1'b0;

          assign aux_channel_p[3] = 1'b0;
          assign aux_channel_n[3] = 1'b0;

          assign aux_channel_p[4] = 1'b0;
          assign aux_channel_n[4] = 1'b0;

          assign aux_channel_p[5] = 1'b0;
          assign aux_channel_n[5] = 1'b0;

          assign aux_channel_p[6] = VAUXP6;
          assign aux_channel_n[6] = VAUXN6;

          assign aux_channel_p[7] = VAUXP7;
          assign aux_channel_n[7] = VAUXN7;

          assign aux_channel_p[8] = 1'b0;
          assign aux_channel_n[8] = 1'b0;

          assign aux_channel_p[9] = 1'b0;
          assign aux_channel_n[9] = 1'b0;

          assign aux_channel_p[10] = 1'b0;
          assign aux_channel_n[10] = 1'b0;

          assign aux_channel_p[11] = 1'b0;
          assign aux_channel_n[11] = 1'b0;

          assign aux_channel_p[12] = 1'b0;
          assign aux_channel_n[12] = 1'b0;

          assign aux_channel_p[13] = 1'b0;
          assign aux_channel_n[13] = 1'b0;

          assign aux_channel_p[14] = VAUXP14;
          assign aux_channel_n[14] = VAUXN14;

          assign aux_channel_p[15] = VAUXP15;
          assign aux_channel_n[15] = VAUXN15;
XADC #(
        .INIT_40(16'h0000), // config reg 0
        .INIT_41(16'h4f0f), // config reg 1
        .INIT_42(16'h0500), // config reg 2
        .INIT_48(16'h0b00), // Sequencer channel selection
        .INIT_49(16'h00c0), // Sequencer channel selection
        .INIT_4A(16'h0000), // Sequencer Average selection
        .INIT_4B(16'h0000), // Sequencer Average selection
        .INIT_4C(16'h0800), // Sequencer Bipolar selection
        .INIT_4D(16'h00c0), // Sequencer Bipolar selection
        .INIT_4E(16'h0000), // Sequencer Acq time selection
        .INIT_4F(16'h0000), // Sequencer Acq time selection
        .INIT_50(16'hb5ed), // Temp alarm trigger
        .INIT_51(16'h57e4), // Vccint upper alarm limit
        .INIT_52(16'ha147), // Vccaux upper alarm limit
        .INIT_53(16'hca33),  // Temp alarm OT upper
        .INIT_54(16'ha93a), // Temp alarm reset
        .INIT_55(16'h52c6), // Vccint lower alarm limit
        .INIT_56(16'h9555), // Vccaux lower alarm limit
        .INIT_57(16'hae4e),  // Temp alarm OT reset
        .INIT_58(16'h5999), // VBRAM upper alarm limit
        .INIT_5C(16'h5111),  //  VBRAM lower alarm limit
        .INIT_59(16'h5555), // VCCPINT upper alarm limit
        .INIT_5D(16'h5111),  //  VCCPINT lower alarm limit
        .INIT_5A(16'h9999), // VCCPAUX upper alarm limit
        .INIT_5E(16'h91eb),  //  VCCPAUX lower alarm limit
        .INIT_5B(16'h6aaa), // VCCDdro upper alarm limit
        .INIT_5F(16'h6666),  //  VCCDdro lower alarm limit
        .SIM_MONITOR_FILE("design.txt")
)

XADC_INST (
        .CONVST(GND_BIT),
        .CONVSTCLK(GND_BIT),
        .DADDR(DADDR_IN[6:0]),
        .DCLK(DCLK_IN),
        .DEN(DEN_IN),
        .DI(DI_IN[15:0]),
        .DWE(DWE_IN),
        .RESET(RESET_IN),
        .VAUXN(aux_channel_n[15:0]),
        .VAUXP(aux_channel_p[15:0]),
        .ALM(alm_int),
        .BUSY(BUSY_OUT),
        .CHANNEL(CHANNEL_OUT[4:0]),
        .DO(DO_OUT[15:0]),
        .DRDY(DRDY_OUT),
        .EOC(EOC_OUT),
        .EOS(EOS_OUT),
        .JTAGBUSY(),
        .JTAGLOCKED(),
        .JTAGMODIFIED(),
        .OT(),
        .MUXADDR(),
        .VP(VP_IN),
        .VN(VN_IN)
          );

endmodule
