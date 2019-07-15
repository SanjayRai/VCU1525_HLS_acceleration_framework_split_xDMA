//-----------------------------------------------------------------------------
//
// (c) Copyright 2012-2012 Xilinx, Inc. All rights reserved.
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
//
//-----------------------------------------------------------------------------
//
// Project    : UltraScale+ FPGA PCI Express v4.0 Integrated Block
// File       : PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_ext_acs_capability.v
// Version    : 1.3 
//-----------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

module PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_ext_acs_capability # (
  parameter        C_INCLUDE_RC = 0,
  // PCIe Extended Capabilty parameters
  // This parameter should be the offset of this capability.
  // The first extended capability should be at offset 12'h400
  parameter [11:0] EXT_CONFIG_BASE_ADDRESS = 12'h400,
  // This parameter is the byte-lenth of the PCIe extended capability
  // and should include the lenght of the header registers
  parameter [11:0] EXT_CONFIG_CAP_LENGTH = 12'h010,
  // This parameter should be 12'h000 to terminate the capability chain or
  // the address of the next capability.
  parameter [11:0] EXT_CONFIG_NEXT_CAP = 12'h000
)(

  // Control signals
  input wire clk,
  // This module should not be reset by anything other than a through a
  // control regiser within the VSEC.

  // PCIe Extended Capability Interface signals
  input wire read_received,
  input wire write_received,
  input wire [9:0] register_number,
  input wire [7:0] function_number,
  input wire [31:0] write_data,
  input wire [3:0] write_byte_enable,   
  output wire [31:0] read_data,
  output wire read_data_valid

);

  // Register map for this PCIe extended capability
  // PCIe extended capability addresses are given as the word offset from the
  // EXT_CONFIG_BASE_ADDRESS (not byte offset)
  //               <Register name>               <register offset>              <offest from base address>
  localparam [9:0] ACS_EXT_CAP_HEADER         = EXT_CONFIG_BASE_ADDRESS[11:2] + 0;  // 0x00
  localparam [9:0] ACS_EXT_CAPABILITY_REG     = EXT_CONFIG_BASE_ADDRESS[11:2] + 1;  // 0x04 - [15:0]
  localparam [9:0] ACS_EXT_CONTROL_REG        = EXT_CONFIG_BASE_ADDRESS[11:2] + 1;  // 0x04 - [31:0]
  localparam [9:0] ACS_EXT_EGRESS_CONTROL_VEC = EXT_CONFIG_BASE_ADDRESS[11:2] + 2;  // 0x08

  // fields for the PCIE_EXT_CAP_ADDR register. A PCIe VSEC is specified with an
  // PCIE_EXP_CAP_ID=16'h000B and PCIE_EXT_CAP_VER=4'h0 as per the PCIe specification
  localparam [15:0] PCIE_EXP_CAP_ID = 16'h000D;
  localparam [3:0]  PCIE_EXT_CAP_VER = 4'h1;

  // Register/Wire declarations
  wire [31:0] acs_ext_cap_header = {EXT_CONFIG_NEXT_CAP, PCIE_EXT_CAP_VER, PCIE_EXP_CAP_ID};
  wire [15:0] acs_status_reg        = 16'h2020;
  reg  [15:0] acs_control_reg       = 16'h0000;
  reg  [31:0] egress_ctl_vector_reg = 16'h0000;

  wire read_en;
  reg  read_en_ff;
  wire write_en;
  reg [31:0] read_data_reg;
  reg read_data_valid_reg;

  // Add function_number filtering HERE if desired.
  // Currently this is implemented for all functions.
  // Assign the input and output signals
  assign read_en  = (read_received  && (register_number[9:2] == EXT_CONFIG_BASE_ADDRESS[11:4]));
  assign write_en = (write_received && (register_number[9:2] == EXT_CONFIG_BASE_ADDRESS[11:4]));
  assign read_data       = read_data_reg;      
  assign read_data_valid = read_data_valid_reg;
  
  // Register Read logic and output registers.
  always @ (posedge clk) begin
    if (read_en) begin
      case (register_number)
        ACS_EXT_CAP_HEADER: begin
            read_data_reg <= acs_ext_cap_header;
            read_data_valid_reg <= 1'b1;
        end
        ACS_EXT_CAPABILITY_REG: begin
            read_data_reg <= {acs_control_reg, acs_status_reg};
            read_data_valid_reg <= 1'b1;
        end
        ACS_EXT_EGRESS_CONTROL_VEC: begin
            read_data_reg <= egress_ctl_vector_reg;
            read_data_valid_reg <= 1'b1;
        end
        default: begin
            read_data_reg <= 32'b0000000;
            read_data_valid_reg <= 1'b1;
        end             
      endcase
    end else begin
      read_data_reg <= 32'b0000000;
      read_data_valid_reg <= 1'b0;
    end
  end
        
  // Register Write logic
  always @ (posedge clk) begin
    if (write_en) begin
      case (register_number)
        ACS_EXT_CAPABILITY_REG: begin
            acs_control_reg[07:00]       <= write_byte_enable[2] ? (C_INCLUDE_RC ? write_data[23:16] : {2'b0, write_data[21],5'b0}) : acs_control_reg[07:00];
            acs_control_reg[15:08]       <= write_byte_enable[3] ? write_data[31:24] : acs_control_reg[15:08];
        end
        ACS_EXT_EGRESS_CONTROL_VEC: begin
            egress_ctl_vector_reg[07:00] <= write_byte_enable[0] ? write_data[07:00] : egress_ctl_vector_reg[07:00];
            egress_ctl_vector_reg[15:08] <= write_byte_enable[1] ? write_data[15:08] : egress_ctl_vector_reg[15:08];
            egress_ctl_vector_reg[23:16] <= write_byte_enable[2] ? write_data[23:16] : egress_ctl_vector_reg[23:16];
            egress_ctl_vector_reg[31:24] <= write_byte_enable[3] ? write_data[31:24] : egress_ctl_vector_reg[31:24];
        end
        default: begin
            acs_control_reg       <= acs_control_reg;
            egress_ctl_vector_reg <= egress_ctl_vector_reg;
        end
      endcase
    end else
      acs_control_reg       <= acs_control_reg;
      egress_ctl_vector_reg <= egress_ctl_vector_reg;
  end

endmodule
