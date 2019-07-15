
################################################################
# This is a generated script based on design: PCIe_Bridge_ICAP_complex
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source PCIe_Bridge_ICAP_complex_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvu9p-fsgd2104-2-i
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name PCIe_Bridge_ICAP_complex

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 1
if { $run_remote_bd_flow == 1 } {
  # Set the reference directory for source file relative paths (by default 
  # the value is script directory path)
  set origin_dir .

  # Use origin directory path location variable, if specified in the tcl shell
  if { [info exists ::origin_dir_loc] } {
     set origin_dir $::origin_dir_loc
  }

  set str_bd_folder [file normalize ${origin_dir}]
  set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_msg_id "BD_TCL-110" "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_msg_id "BD_TCL-008" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_msg_id "BD_TCL-009" "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-111" "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-010" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files -quiet */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-112" "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_msg_id "BD_TCL-113" "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-011" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  # NOTE - usage of <-dir> will create <$str_bd_folder/$design_name/$design_name.bd>
  create_bd_design -dir $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design $design_name} errmsg] } {
     common::send_msg_id "BD_TCL-012" "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: AXI_MM_2_stage_reg
proc create_hier_cell_AXI_MM_2_stage_reg { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_AXI_MM_2_stage_reg() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axi_register_slice_1, and set properties
  set axi_register_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_1 ]

  # Create instance: axi_register_slice_2, and set properties
  set axi_register_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M_AXI] [get_bd_intf_pins axi_register_slice_2/M_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_register_slice_1/S_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_1_M_AXI [get_bd_intf_pins axi_register_slice_1/M_AXI] [get_bd_intf_pins axi_register_slice_2/S_AXI]

  # Create port connections
  connect_bd_net -net axi_pcie3_0_axi_aclk [get_bd_pins aclk] [get_bd_pins axi_register_slice_1/aclk] [get_bd_pins axi_register_slice_2/aclk]
  connect_bd_net -net axi_pcie3_0_axi_aresetn [get_bd_pins aresetn] [get_bd_pins axi_register_slice_1/aresetn] [get_bd_pins axi_register_slice_2/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: AXI_LITE_2Stage_reg
proc create_hier_cell_AXI_LITE_2Stage_reg { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_AXI_LITE_2Stage_reg() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axi_register_slice_0, and set properties
  set axi_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_0 ]
  set_property -dict [ list \
   CONFIG.REG_R {7} \
   CONFIG.REG_W {7} \
 ] $axi_register_slice_0

  # Create instance: axi_register_slice_1, and set properties
  set axi_register_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_1 ]
  set_property -dict [ list \
   CONFIG.REG_R {7} \
   CONFIG.REG_W {7} \
 ] $axi_register_slice_1

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M_AXI] [get_bd_intf_pins axi_register_slice_1/M_AXI]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_register_slice_0/S_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_0_M_AXI [get_bd_intf_pins axi_register_slice_0/M_AXI] [get_bd_intf_pins axi_register_slice_1/S_AXI]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axi_register_slice_0/aclk] [get_bd_pins axi_register_slice_1/aclk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axi_register_slice_0/aresetn] [get_bd_pins axi_register_slice_1/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: xDMA_SUBSYS
proc create_hier_cell_xDMA_SUBSYS { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_xDMA_SUBSYS() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_LITE

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_mgt


  # Create pins
  create_bd_pin -dir O -type rst axi_aresetn
  create_bd_pin -dir O -type clk clk_out_250M
  create_bd_pin -dir I -type clk sys_clk
  create_bd_pin -dir I -type clk sys_clk_gt
  create_bd_pin -dir I -type rst sys_rst_n
  create_bd_pin -dir O user_lnk_up
  create_bd_pin -dir I -from 0 -to 0 usr_irq_req

  # Create instance: pcie4_uscale_plus_0, and set properties
  set pcie4_uscale_plus_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:pcie4_uscale_plus:1.3 pcie4_uscale_plus_0 ]
  set_property -dict [ list \
   CONFIG.AXISTEN_IF_CQ_ALIGNMENT_MODE {Address_Aligned} \
   CONFIG.AXISTEN_IF_EXT_512_RC_4TLP_STRADDLE {true} \
   CONFIG.AXISTEN_IF_EXT_512_RQ_STRADDLE {true} \
   CONFIG.MSI_X_OPTIONS {MSI-X_External} \
   CONFIG.PF0_CLASS_CODE {070001} \
   CONFIG.PF0_DEVICE_ID {903F} \
   CONFIG.PF0_MSIX_CAP_PBA_BIR {BAR_1} \
   CONFIG.PF0_MSIX_CAP_PBA_OFFSET {00008FE0} \
   CONFIG.PF0_MSIX_CAP_TABLE_BIR {BAR_1} \
   CONFIG.PF0_MSIX_CAP_TABLE_OFFSET {00008000} \
   CONFIG.PF0_MSIX_CAP_TABLE_SIZE {020} \
   CONFIG.PF1_CLASS_CODE {070001} \
   CONFIG.PF1_DEVICE_ID {9040} \
   CONFIG.PF1_MSIX_CAP_PBA_BIR {BAR_1} \
   CONFIG.PF1_MSIX_CAP_PBA_OFFSET {9FE0} \
   CONFIG.PF1_MSIX_CAP_TABLE_BIR {BAR_1} \
   CONFIG.PF1_MSIX_CAP_TABLE_OFFSET {9000} \
   CONFIG.PF1_MSIX_CAP_TABLE_SIZE {020} \
   CONFIG.PF2_DEVICE_ID {0007} \
   CONFIG.PF3_DEVICE_ID {903F} \
   CONFIG.PL_DISABLE_LANE_REVERSAL {TRUE} \
   CONFIG.PL_LINK_CAP_MAX_LINK_SPEED {8.0_GT/s} \
   CONFIG.PL_LINK_CAP_MAX_LINK_WIDTH {X16} \
   CONFIG.TL_PF_ENABLE_REG {2} \
   CONFIG.acs_ext_cap_enable {true} \
   CONFIG.axisten_freq {250} \
   CONFIG.axisten_if_enable_client_tag {true} \
   CONFIG.axisten_if_enable_msg_route {00000} \
   CONFIG.axisten_if_width {512_bit} \
   CONFIG.cfg_mgmt_if {false} \
   CONFIG.cfg_pm_if {false} \
   CONFIG.coreclk_freq {500} \
   CONFIG.gen_x0y1 {false} \
   CONFIG.gen_x1y2 {true} \
   CONFIG.mcap_enablement {None} \
   CONFIG.mode_selection {Advanced} \
   CONFIG.pcie_blk_locn {X1Y2} \
   CONFIG.pf0_bar0_scale {Megabytes} \
   CONFIG.pf0_bar0_size {32} \
   CONFIG.pf0_bar1_enabled {true} \
   CONFIG.pf0_bar1_size {128} \
   CONFIG.pf0_bar1_type {Memory} \
   CONFIG.pf0_base_class_menu {Simple_communication_controllers} \
   CONFIG.pf0_class_code_base {07} \
   CONFIG.pf0_class_code_interface {01} \
   CONFIG.pf0_class_code_sub {00} \
   CONFIG.pf0_msi_enabled {false} \
   CONFIG.pf0_msix_enabled {true} \
   CONFIG.pf0_sub_class_interface_menu {16450_compatible_serial_controller} \
   CONFIG.pf1_bar0_scale {Megabytes} \
   CONFIG.pf1_bar0_size {32} \
   CONFIG.pf1_bar1_enabled {true} \
   CONFIG.pf1_bar1_size {128} \
   CONFIG.pf1_bar1_type {Memory} \
   CONFIG.pf1_base_class_menu {Simple_communication_controllers} \
   CONFIG.pf1_class_code_base {07} \
   CONFIG.pf1_class_code_interface {01} \
   CONFIG.pf1_class_code_sub {00} \
   CONFIG.pf1_msix_enabled {true} \
   CONFIG.pf1_sub_class_interface_menu {16450_compatible_serial_controller} \
   CONFIG.pf2_bar0_scale {Megabytes} \
   CONFIG.pf2_bar0_size {32} \
   CONFIG.pf2_bar1_enabled {true} \
   CONFIG.pf2_bar1_size {128} \
   CONFIG.pf2_bar1_type {Memory} \
   CONFIG.pf3_bar0_scale {Megabytes} \
   CONFIG.pf3_bar0_size {32} \
   CONFIG.pf3_bar1_enabled {true} \
   CONFIG.pf3_bar1_size {128} \
   CONFIG.pf3_bar1_type {Memory} \
   CONFIG.plltype {QPLL1} \
   CONFIG.select_quad {GTY_Quad_227} \
   CONFIG.type1_membase_memlimit_enable {Disabled} \
   CONFIG.type1_prefetchable_membase_memlimit {Disabled} \
 ] $pcie4_uscale_plus_0

  # Create instance: xdma_0, and set properties
  set xdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xdma:4.1 xdma_0 ]
  set_property -dict [ list \
   CONFIG.PF0_DEVICE_ID_mqdma {903F} \
   CONFIG.PF2_DEVICE_ID_mqdma {903F} \
   CONFIG.PF3_DEVICE_ID_mqdma {903F} \
   CONFIG.acs_ext_cap_enable {true} \
   CONFIG.axi_bypass_64bit_en {false} \
   CONFIG.axi_data_width {512_bit} \
   CONFIG.axil_master_64bit_en {false} \
   CONFIG.axilite_master_en {true} \
   CONFIG.axilite_master_scale {Megabytes} \
   CONFIG.axilite_master_size {32} \
   CONFIG.axisten_freq {250} \
   CONFIG.c_s_axi_num_read {32} \
   CONFIG.cfg_mgmt_if {false} \
   CONFIG.coreclk_freq {500} \
   CONFIG.dedicate_perst {false} \
   CONFIG.en_axi_slave_if {false} \
   CONFIG.mode_selection {Advanced} \
   CONFIG.pcie_blk_locn {X1Y2} \
   CONFIG.pcie_id_if {FALSE} \
   CONFIG.pciebar2axibar_axil_master {0x0000000000000000} \
   CONFIG.pf0_device_id {903F} \
   CONFIG.pf0_interrupt_pin {NONE} \
   CONFIG.pf0_msi_enabled {false} \
   CONFIG.pf0_msix_cap_pba_bir {BAR_1} \
   CONFIG.pf0_msix_cap_pba_offset {00008FE0} \
   CONFIG.pf0_msix_cap_table_bir {BAR_1} \
   CONFIG.pf0_msix_cap_table_offset {00008000} \
   CONFIG.pf0_msix_cap_table_size {01F} \
   CONFIG.pf0_msix_enabled {true} \
   CONFIG.pf1_bar0_scale {Kilobytes} \
   CONFIG.pf1_bar0_size {128} \
   CONFIG.pf1_bar1_enabled {false} \
   CONFIG.pf1_bar2_64bit {false} \
   CONFIG.pf1_bar2_enabled {false} \
   CONFIG.pf1_bar4_64bit {false} \
   CONFIG.pf1_bar4_enabled {false} \
   CONFIG.pipe_sim {false} \
   CONFIG.pl_link_cap_max_link_speed {8.0_GT/s} \
   CONFIG.pl_link_cap_max_link_width {X16} \
   CONFIG.plltype {QPLL1} \
   CONFIG.select_quad {GTY_Quad_227} \
   CONFIG.split_dma {true} \
   CONFIG.xdma_pcie_64bit_en {false} \
 ] $xdma_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {2} \
   CONFIG.CONST_WIDTH {2} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins M_AXI_LITE] [get_bd_intf_pins xdma_0/M_AXI_LITE]
  connect_bd_intf_net -intf_net pcie4_uscale_plus_0_m_axis_cq [get_bd_intf_pins pcie4_uscale_plus_0/m_axis_cq] [get_bd_intf_pins xdma_0/m_axis_cq]
  connect_bd_intf_net -intf_net pcie4_uscale_plus_0_m_axis_rc [get_bd_intf_pins pcie4_uscale_plus_0/m_axis_rc] [get_bd_intf_pins xdma_0/m_axis_rc]
  connect_bd_intf_net -intf_net pcie4_uscale_plus_0_pcie4_cfg_fc [get_bd_intf_pins pcie4_uscale_plus_0/pcie4_cfg_fc] [get_bd_intf_pins xdma_0/pcie4_cfg_fc]
  connect_bd_intf_net -intf_net pcie4_uscale_plus_0_pcie4_cfg_mesg_rcvd [get_bd_intf_pins pcie4_uscale_plus_0/pcie4_cfg_mesg_rcvd] [get_bd_intf_pins xdma_0/pcie4_cfg_mesg_rcvd]
  connect_bd_intf_net -intf_net pcie4_uscale_plus_0_pcie4_cfg_mesg_tx [get_bd_intf_pins pcie4_uscale_plus_0/pcie4_cfg_mesg_tx] [get_bd_intf_pins xdma_0/pcie4_cfg_mesg_tx]
  connect_bd_intf_net -intf_net pcie4_uscale_plus_0_pcie4_cfg_status [get_bd_intf_pins pcie4_uscale_plus_0/pcie4_cfg_status] [get_bd_intf_pins xdma_0/pcie4_cfg_status]
  connect_bd_intf_net -intf_net xdma_0_M_AXI [get_bd_intf_pins M_AXI] [get_bd_intf_pins xdma_0/M_AXI]
  connect_bd_intf_net -intf_net xdma_0_pcie4_cfg_control [get_bd_intf_pins pcie4_uscale_plus_0/pcie4_cfg_control] [get_bd_intf_pins xdma_0/pcie4_cfg_control]
  connect_bd_intf_net -intf_net xdma_0_pcie4_cfg_external_msix [get_bd_intf_pins pcie4_uscale_plus_0/pcie4_cfg_external_msix] [get_bd_intf_pins xdma_0/pcie4_cfg_external_msix]
  connect_bd_intf_net -intf_net xdma_0_pcie4_cfg_interrupt [get_bd_intf_pins pcie4_uscale_plus_0/pcie4_cfg_interrupt] [get_bd_intf_pins xdma_0/pcie4_cfg_interrupt]
  connect_bd_intf_net -intf_net xdma_0_pcie_mgt [get_bd_intf_pins pcie_mgt] [get_bd_intf_pins pcie4_uscale_plus_0/pcie4_mgt]
  connect_bd_intf_net -intf_net xdma_0_s_axis_cc [get_bd_intf_pins pcie4_uscale_plus_0/s_axis_cc] [get_bd_intf_pins xdma_0/s_axis_cc]
  connect_bd_intf_net -intf_net xdma_0_s_axis_rq [get_bd_intf_pins pcie4_uscale_plus_0/s_axis_rq] [get_bd_intf_pins xdma_0/s_axis_rq]

  # Create port connections
  connect_bd_net -net axi_pcie3_0_axi_aclk [get_bd_pins clk_out_250M] [get_bd_pins xdma_0/axi_aclk]
  connect_bd_net -net axi_pcie3_0_axi_aresetn [get_bd_pins axi_aresetn] [get_bd_pins xdma_0/axi_aresetn]
  connect_bd_net -net pcie4_uscale_plus_0_phy_rdy_out [get_bd_pins pcie4_uscale_plus_0/phy_rdy_out] [get_bd_pins xdma_0/phy_rdy_out_sd]
  connect_bd_net -net pcie4_uscale_plus_0_user_clk [get_bd_pins pcie4_uscale_plus_0/user_clk] [get_bd_pins xdma_0/user_clk_sd]
  connect_bd_net -net pcie4_uscale_plus_0_user_reset [get_bd_pins pcie4_uscale_plus_0/user_reset] [get_bd_pins xdma_0/user_reset_sd]
  connect_bd_net -net sys_clk_1 [get_bd_pins sys_clk] [get_bd_pins pcie4_uscale_plus_0/sys_clk]
  connect_bd_net -net sys_clk_gt_1 [get_bd_pins sys_clk_gt] [get_bd_pins pcie4_uscale_plus_0/sys_clk_gt]
  connect_bd_net -net sys_rst_n_1 [get_bd_pins sys_rst_n] [get_bd_pins pcie4_uscale_plus_0/sys_reset] [get_bd_pins xdma_0/sys_rst_n]
  connect_bd_net -net xdma_0_user_lnk_up [get_bd_pins user_lnk_up] [get_bd_pins pcie4_uscale_plus_0/user_lnk_up] [get_bd_pins xdma_0/user_lnk_up_sd]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins usr_irq_req] [get_bd_pins xdma_0/usr_irq_req]
  connect_bd_net -net xlconstant_0_dout1 [get_bd_pins xdma_0/usr_irq_function_number] [get_bd_pins xlconstant_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: TO_SH_AXI_MM_NORTH
proc create_hier_cell_TO_SH_AXI_MM_NORTH { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_TO_SH_AXI_MM_NORTH() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 rp_AXI_MM_FROM_HLS_PR_0


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I decouple

  # Create instance: AXI_MM_2_stage_reg
  create_hier_cell_AXI_MM_2_stage_reg $hier_obj AXI_MM_2_stage_reg

  # Create instance: axi_register_slice_PR_DECOUPLE_AXI_MM, and set properties
  set axi_register_slice_PR_DECOUPLE_AXI_MM [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_PR_DECOUPLE_AXI_MM ]

  # Create interface connections
  connect_bd_intf_net -intf_net AXI_MM_3_stage_reg_M_AXI [get_bd_intf_pins M_AXI] [get_bd_intf_pins AXI_MM_2_stage_reg/M_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_0_M_AXI [get_bd_intf_pins AXI_MM_2_stage_reg/S_AXI] [get_bd_intf_pins axi_register_slice_PR_DECOUPLE_AXI_MM/M_AXI]
  connect_bd_intf_net -intf_net rp_AXI_MM_FROM_HLS_PR_0_1 [get_bd_intf_pins rp_AXI_MM_FROM_HLS_PR_0] [get_bd_intf_pins axi_register_slice_PR_DECOUPLE_AXI_MM/S_AXI]

  # Create port connections
  connect_bd_net -net clk_wiz_0_clk_out_125M [get_bd_pins aclk] [get_bd_pins AXI_MM_2_stage_reg/aclk] [get_bd_pins axi_register_slice_PR_DECOUPLE_AXI_MM/aclk]
  connect_bd_net -net decouple_1 [get_bd_pins decouple] [get_bd_pins axi_register_slice_PR_DECOUPLE_AXI_MM/aresetn]
  connect_bd_net -net rst_ddr4_0_300M1_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins AXI_MM_2_stage_reg/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: FROM_SH_AXI_MM_NORTH
proc create_hier_cell_FROM_SH_AXI_MM_NORTH { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_FROM_SH_AXI_MM_NORTH() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -type rst aresetn1
  create_bd_pin -dir I -type clk clk_out_250M

  # Create instance: axi_register_slice_0, and set properties
  set axi_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_0 ]

  # Create instance: axi_register_slice_1, and set properties
  set axi_register_slice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_1 ]

  # Create instance: axi_register_slice_2, and set properties
  set axi_register_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_register_slice_0/S_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_0_M_AXI [get_bd_intf_pins axi_register_slice_0/M_AXI] [get_bd_intf_pins axi_register_slice_1/S_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_1_M_AXI [get_bd_intf_pins axi_register_slice_1/M_AXI] [get_bd_intf_pins axi_register_slice_2/S_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_2_M_AXI [get_bd_intf_pins M_AXI_0] [get_bd_intf_pins axi_register_slice_2/M_AXI]

  # Create port connections
  connect_bd_net -net axi_pcie3_0_axi_aclk [get_bd_pins clk_out_250M] [get_bd_pins axi_register_slice_0/aclk] [get_bd_pins axi_register_slice_1/aclk] [get_bd_pins axi_register_slice_2/aclk]
  connect_bd_net -net axi_pcie3_0_axi_aresetn [get_bd_pins aresetn] [get_bd_pins axi_register_slice_0/aresetn] [get_bd_pins axi_register_slice_1/aresetn]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins aresetn1] [get_bd_pins axi_register_slice_2/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: FROM_SH_AXI_LITE_NORTH
proc create_hier_cell_FROM_SH_AXI_LITE_NORTH { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_FROM_SH_AXI_LITE_NORTH() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 rp_AXI_LITE_TO_HLS_PR_0


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I decouple

  # Create instance: AXI_LITE_2Stage_reg
  create_hier_cell_AXI_LITE_2Stage_reg $hier_obj AXI_LITE_2Stage_reg

  # Create instance: axi_register_slice_2, and set properties
  set axi_register_slice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_2 ]
  set_property -dict [ list \
   CONFIG.REG_R {7} \
   CONFIG.REG_W {7} \
 ] $axi_register_slice_2

  # Create interface connections
  connect_bd_intf_net -intf_net AXI_LITE_3Stage_reg_M_AXI [get_bd_intf_pins AXI_LITE_2Stage_reg/M_AXI] [get_bd_intf_pins axi_register_slice_2/S_AXI]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins AXI_LITE_2Stage_reg/S_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_2_M_AXI [get_bd_intf_pins rp_AXI_LITE_TO_HLS_PR_0] [get_bd_intf_pins axi_register_slice_2/M_AXI]

  # Create port connections
  connect_bd_net -net clk_wiz_0_clk_out_125M [get_bd_pins aclk] [get_bd_pins AXI_LITE_2Stage_reg/aclk] [get_bd_pins axi_register_slice_2/aclk]
  connect_bd_net -net decouple_1 [get_bd_pins decouple] [get_bd_pins axi_register_slice_2/aresetn]
  connect_bd_net -net rst_ddr4_0_300M1_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins AXI_LITE_2Stage_reg/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set C1_SYS_CLK [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 C1_SYS_CLK ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {300000000} \
   ] $C1_SYS_CLK

  set M_AXI_LITE_TO_HLS_PR_NORTH [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_LITE_TO_HLS_PR_NORTH ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {32} \
   CONFIG.DATA_WIDTH {32} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.PROTOCOL {AXI4LITE} \
   ] $M_AXI_LITE_TO_HLS_PR_NORTH

  set M_AXI_MM_TO_HLS_PR_NORTH [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_MM_TO_HLS_PR_NORTH ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {64} \
   CONFIG.DATA_WIDTH {512} \
   CONFIG.NUM_READ_OUTSTANDING {32} \
   CONFIG.NUM_WRITE_OUTSTANDING {32} \
   CONFIG.PROTOCOL {AXI4} \
   ] $M_AXI_MM_TO_HLS_PR_NORTH

  set S_AXI_MM_FROM_HLS_PR_NORTH [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_MM_FROM_HLS_PR_NORTH ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {64} \
   CONFIG.ARUSER_WIDTH {0} \
   CONFIG.AWUSER_WIDTH {0} \
   CONFIG.BUSER_WIDTH {0} \
   CONFIG.DATA_WIDTH {512} \
   CONFIG.HAS_BRESP {1} \
   CONFIG.HAS_BURST {1} \
   CONFIG.HAS_CACHE {1} \
   CONFIG.HAS_LOCK {1} \
   CONFIG.HAS_PROT {1} \
   CONFIG.HAS_QOS {1} \
   CONFIG.HAS_REGION {1} \
   CONFIG.HAS_RRESP {1} \
   CONFIG.HAS_WSTRB {1} \
   CONFIG.ID_WIDTH {5} \
   CONFIG.MAX_BURST_LENGTH {256} \
   CONFIG.NUM_READ_OUTSTANDING {32} \
   CONFIG.NUM_READ_THREADS {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {32} \
   CONFIG.NUM_WRITE_THREADS {1} \
   CONFIG.PROTOCOL {AXI4} \
   CONFIG.READ_WRITE_MODE {READ_WRITE} \
   CONFIG.RUSER_BITS_PER_BYTE {0} \
   CONFIG.RUSER_WIDTH {0} \
   CONFIG.SUPPORTS_NARROW_BURST {1} \
   CONFIG.WUSER_BITS_PER_BYTE {0} \
   CONFIG.WUSER_WIDTH {0} \
   ] $S_AXI_MM_FROM_HLS_PR_NORTH

  set c1_ddr4 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 c1_ddr4 ]

  set pcie_mgt [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_mgt ]


  # Create ports
  set DDR4_sys_rst [ create_bd_port -dir I -type rst DDR4_sys_rst ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $DDR4_sys_rst
  set axi_reset_n_out [ create_bd_port -dir O -from 0 -to 0 -type rst axi_reset_n_out ]
  set c1_init_calib_complete [ create_bd_port -dir O c1_init_calib_complete ]
  set clk_out_125M [ create_bd_port -dir O -type clk clk_out_125M ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {M_AXI_LITE_TO_HLS_PR_NORTH} \
   CONFIG.ASSOCIATED_RESET {axi_reset_n_out} \
 ] $clk_out_125M
  set clk_out_250M [ create_bd_port -dir O -type clk clk_out_250M ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S_AXI_MM_FROM_HLS_PR_NORTH:M_AXI_MM_TO_HLS_PR_NORTH} \
 ] $clk_out_250M
  set clk_out_PROG [ create_bd_port -dir O -type clk clk_out_PROG ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {400000000} \
 ] $clk_out_PROG
  set clk_out_PROG_locked [ create_bd_port -dir O clk_out_PROG_locked ]
  set ker_active_count_L [ create_bd_port -dir I -from 31 -to 0 ker_active_count_L ]
  set ker_active_count_U [ create_bd_port -dir I -from 31 -to 0 ker_active_count_U ]
  set status_gpio_in [ create_bd_port -dir I -from 7 -to 0 status_gpio_in ]
  set sys_clk [ create_bd_port -dir I -type clk sys_clk ]
  set sys_clk_gt [ create_bd_port -dir I -type clk sys_clk_gt ]
  set sys_rst_n [ create_bd_port -dir I -type rst sys_rst_n ]

  # Create instance: FROM_SH_AXI_LITE_NORTH
  create_hier_cell_FROM_SH_AXI_LITE_NORTH [current_bd_instance .] FROM_SH_AXI_LITE_NORTH

  # Create instance: FROM_SH_AXI_MM_NORTH
  create_hier_cell_FROM_SH_AXI_MM_NORTH [current_bd_instance .] FROM_SH_AXI_MM_NORTH

  # Create instance: TO_SH_AXI_MM_NORTH
  create_hier_cell_TO_SH_AXI_MM_NORTH [current_bd_instance .] TO_SH_AXI_MM_NORTH

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]

  # Create instance: axi_bram_ctrl_0_bram, and set properties
  set axi_bram_ctrl_0_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 axi_bram_ctrl_0_bram ]
  set_property -dict [ list \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {50} \
   CONFIG.Use_RSTB_Pin {true} \
 ] $axi_bram_ctrl_0_bram

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS_2 {1} \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_GPIO2_WIDTH {1} \
   CONFIG.C_GPIO_WIDTH {1} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_0

  # Create instance: axi_gpio_KER_ACTIVE_COUNT, and set properties
  set axi_gpio_KER_ACTIVE_COUNT [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_KER_ACTIVE_COUNT ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_ALL_INPUTS_2 {1} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_KER_ACTIVE_COUNT

  # Create instance: axi_gpio_status, and set properties
  set axi_gpio_status [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_status ]
  set_property -dict [ list \
   CONFIG.C_ALL_INPUTS {1} \
   CONFIG.C_GPIO_WIDTH {8} \
 ] $axi_gpio_status

  # Create instance: axi_hwicap_0, and set properties
  set axi_hwicap_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_hwicap:3.0 axi_hwicap_0 ]
  set_property -dict [ list \
   CONFIG.C_FAMILY {kintexu} \
 ] $axi_hwicap_0

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_DATA_FIFO {0} \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.M01_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {1} \
   CONFIG.S00_HAS_DATA_FIFO {0} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_DATA_FIFO {0} \
   CONFIG.S01_HAS_REGSLICE {4} \
   CONFIG.S02_HAS_DATA_FIFO {0} \
   CONFIG.S02_HAS_REGSLICE {4} \
   CONFIG.S03_HAS_DATA_FIFO {0} \
   CONFIG.S03_HAS_REGSLICE {4} \
   CONFIG.SYNCHRONIZATION_STAGES {2} \
 ] $axi_interconnect_0

  # Create instance: axi_pcie3_0_axi_periph, and set properties
  set axi_pcie3_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_pcie3_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.M01_HAS_REGSLICE {4} \
   CONFIG.M02_HAS_REGSLICE {4} \
   CONFIG.M03_HAS_REGSLICE {4} \
   CONFIG.M04_HAS_REGSLICE {4} \
   CONFIG.M05_HAS_REGSLICE {4} \
   CONFIG.M06_HAS_REGSLICE {4} \
   CONFIG.M07_HAS_REGSLICE {4} \
   CONFIG.M08_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {9} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.SYNCHRONIZATION_STAGES {2} \
 ] $axi_pcie3_0_axi_periph

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {40.0} \
   CONFIG.CLKOUT1_DRIVES {BUFG} \
   CONFIG.CLKOUT1_JITTER {88.976} \
   CONFIG.CLKOUT1_PHASE_ERROR {71.064} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {125.000} \
   CONFIG.CLKOUT2_DRIVES {BUFG} \
   CONFIG.CLKOUT2_JITTER {101.705} \
   CONFIG.CLKOUT2_PHASE_ERROR {71.064} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {62.5} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLKOUT3_DRIVES {Buffer} \
   CONFIG.CLKOUT3_JITTER {79.446} \
   CONFIG.CLKOUT3_PHASE_ERROR {72.667} \
   CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {100.000} \
   CONFIG.CLKOUT3_USED {false} \
   CONFIG.CLKOUT4_DRIVES {Buffer} \
   CONFIG.CLKOUT5_DRIVES {Buffer} \
   CONFIG.CLKOUT6_DRIVES {Buffer} \
   CONFIG.CLKOUT7_DRIVES {Buffer} \
   CONFIG.CLK_OUT1_PORT {clk_out_125M} \
   CONFIG.CLK_OUT2_PORT {clk_out_62_5M} \
   CONFIG.CLK_OUT3_PORT {clk_out3} \
   CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
   CONFIG.JITTER_SEL {Min_O_Jitter} \
   CONFIG.MMCM_BANDWIDTH {HIGH} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {6.250} \
   CONFIG.MMCM_CLKIN1_PERIOD {4.000} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {12.500} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {25} \
   CONFIG.MMCM_CLKOUT2_DIVIDE {1} \
   CONFIG.MMCM_DIVCLK_DIVIDE {1} \
   CONFIG.NUM_OUT_CLKS {2} \
   CONFIG.PHASESHIFT_MODE {WAVEFORM} \
   CONFIG.PRIM_SOURCE {No_buffer} \
   CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} \
   CONFIG.USE_FREQ_SYNTH {true} \
   CONFIG.USE_LOCKED {false} \
   CONFIG.USE_PHASE_ALIGNMENT {false} \
   CONFIG.USE_RESET {false} \
 ] $clk_wiz_0

  # Create instance: clk_wiz_PROG, and set properties
  set clk_wiz_PROG [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_PROG ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {33.330000000000005} \
   CONFIG.CLKOUT1_DRIVES {Buffer} \
   CONFIG.CLKOUT1_JITTER {71.763} \
   CONFIG.CLKOUT1_PHASE_ERROR {75.042} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {400.000} \
   CONFIG.CLKOUT2_DRIVES {Buffer} \
   CONFIG.CLKOUT3_DRIVES {Buffer} \
   CONFIG.CLKOUT4_DRIVES {Buffer} \
   CONFIG.CLKOUT5_DRIVES {Buffer} \
   CONFIG.CLKOUT6_DRIVES {Buffer} \
   CONFIG.CLKOUT7_DRIVES {Buffer} \
   CONFIG.JITTER_SEL {Min_O_Jitter} \
   CONFIG.MMCM_BANDWIDTH {HIGH} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {15.500} \
   CONFIG.MMCM_CLKIN1_PERIOD {3.333} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {3.875} \
   CONFIG.MMCM_DIVCLK_DIVIDE {3} \
   CONFIG.PRIM_SOURCE {No_buffer} \
   CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} \
   CONFIG.USE_DYN_RECONFIG {true} \
   CONFIG.USE_PHASE_ALIGNMENT {false} \
 ] $clk_wiz_PROG

  # Create instance: ddr4_1, and set properties
  set ddr4_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4:2.2 ddr4_1 ]
  set_property -dict [ list \
   CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {250} \
   CONFIG.C0.BANK_GROUP_WIDTH {2} \
   CONFIG.C0.CKE_WIDTH {1} \
   CONFIG.C0.CS_WIDTH {1} \
   CONFIG.C0.DDR4_AxiAddressWidth {34} \
   CONFIG.C0.DDR4_AxiDataWidth {512} \
   CONFIG.C0.DDR4_CLKFBOUT_MULT {5} \
   CONFIG.C0.DDR4_CLKOUT0_DIVIDE {5} \
   CONFIG.C0.DDR4_CasLatency {17} \
   CONFIG.C0.DDR4_CasWriteLatency {12} \
   CONFIG.C0.DDR4_DIVCLK_DIVIDE {1} \
   CONFIG.C0.DDR4_DataMask {NONE} \
   CONFIG.C0.DDR4_DataWidth {72} \
   CONFIG.C0.DDR4_Ecc {true} \
   CONFIG.C0.DDR4_InputClockPeriod {3332} \
   CONFIG.C0.DDR4_MemoryPart {MTA18ASF2G72PZ-2G3} \
   CONFIG.C0.DDR4_MemoryType {RDIMMs} \
   CONFIG.C0.DDR4_TimePeriod {833} \
   CONFIG.C0.ODT_WIDTH {1} \
 ] $ddr4_1

  # Create instance: rst_125M, and set properties
  set rst_125M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_125M ]

  # Create instance: rst_ddr4_0_300M, and set properties
  set rst_ddr4_0_300M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ddr4_0_300M ]

  # Create instance: system_ila_AXIL, and set properties
  set system_ila_AXIL [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_AXIL ]
  set_property -dict [ list \
   CONFIG.C_BRAM_CNT {0} \
   CONFIG.C_MON_TYPE {INTERFACE} \
 ] $system_ila_AXIL

  # Create instance: system_ila_AXI_MM, and set properties
  set system_ila_AXI_MM [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila:1.1 system_ila_AXI_MM ]
  set_property -dict [ list \
   CONFIG.ALL_PROBE_SAME_MU {true} \
   CONFIG.C_BRAM_CNT {0} \
   CONFIG.C_INPUT_PIPE_STAGES {4} \
   CONFIG.C_MON_TYPE {INTERFACE} \
   CONFIG.C_SLOT_0_AXI_B_SEL_TRIG {0} \
   CONFIG.C_SLOT_0_AXI_R_SEL_TRIG {0} \
   CONFIG.C_SLOT_0_AXI_W_SEL_TRIG {0} \
   CONFIG.C_SLOT_0_MAX_RD_BURSTS {32} \
   CONFIG.C_SLOT_0_MAX_WR_BURSTS {32} \
   CONFIG.C_SLOT_0_TXN_CNTR_EN {0} \
 ] $system_ila_AXI_MM

  # Create instance: system_management_wiz_0, and set properties
  set system_management_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_management_wiz:1.3 system_management_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CHANNEL_ENABLE_VP_VN {false} \
   CONFIG.INTERFACE_SELECTION {Enable_AXI} \
   CONFIG.TEMPERATURE_ALARM_OT_TRIGGER {95.0} \
 ] $system_management_wiz_0

  # Create instance: xDMA_SUBSYS
  create_hier_cell_xDMA_SUBSYS [current_bd_instance .] xDMA_SUBSYS

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net C0_SYS_CLK_1 [get_bd_intf_ports C1_SYS_CLK] [get_bd_intf_pins ddr4_1/C0_SYS_CLK]
  connect_bd_intf_net -intf_net FROM_SH_AXI_LITE_rp_AXI_LITE_TO_HLS_PR_0 [get_bd_intf_ports M_AXI_LITE_TO_HLS_PR_NORTH] [get_bd_intf_pins FROM_SH_AXI_LITE_NORTH/rp_AXI_LITE_TO_HLS_PR_0]
  connect_bd_intf_net -intf_net M_AXI_MM_FROM_HLS_PR_0_1 [get_bd_intf_ports S_AXI_MM_FROM_HLS_PR_NORTH] [get_bd_intf_pins TO_SH_AXI_MM_NORTH/rp_AXI_MM_FROM_HLS_PR_0]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_pcie3_0_axi_periph/S00_AXI] [get_bd_intf_pins xDMA_SUBSYS/M_AXI_LITE]
connect_bd_intf_net -intf_net [get_bd_intf_nets S00_AXI_1] [get_bd_intf_pins system_ila_AXIL/SLOT_0_AXI] [get_bd_intf_pins xDMA_SUBSYS/M_AXI_LITE]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins TO_SH_AXI_MM_NORTH/M_AXI] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTB [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTB] [get_bd_intf_pins axi_bram_ctrl_0_bram/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins ddr4_1/C0_DDR4_S_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets axi_interconnect_0_M00_AXI] [get_bd_intf_pins ddr4_1/C0_DDR4_S_AXI] [get_bd_intf_pins system_ila_AXI_MM/SLOT_0_AXI]
  connect_bd_intf_net -intf_net axi_pcie3_0_axi_periph_M00_AXI [get_bd_intf_pins axi_pcie3_0_axi_periph/M00_AXI] [get_bd_intf_pins ddr4_1/C0_DDR4_S_AXI_CTRL]
  connect_bd_intf_net -intf_net axi_pcie3_0_axi_periph_M01_AXI [get_bd_intf_pins FROM_SH_AXI_LITE_NORTH/S_AXI] [get_bd_intf_pins axi_pcie3_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net axi_pcie3_0_axi_periph_M02_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins axi_pcie3_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net axi_pcie3_0_axi_periph_M03_AXI [get_bd_intf_pins axi_hwicap_0/S_AXI_LITE] [get_bd_intf_pins axi_pcie3_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net axi_pcie3_0_axi_periph_M04_AXI [get_bd_intf_pins axi_pcie3_0_axi_periph/M04_AXI] [get_bd_intf_pins clk_wiz_PROG/s_axi_lite]
  connect_bd_intf_net -intf_net axi_pcie3_0_axi_periph_M05_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_pcie3_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net axi_pcie3_0_axi_periph_M06_AXI [get_bd_intf_pins axi_pcie3_0_axi_periph/M06_AXI] [get_bd_intf_pins system_management_wiz_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_pcie3_0_axi_periph_M07_AXI [get_bd_intf_pins axi_gpio_KER_ACTIVE_COUNT/S_AXI] [get_bd_intf_pins axi_pcie3_0_axi_periph/M07_AXI]
  connect_bd_intf_net -intf_net axi_pcie3_0_axi_periph_M08_AXI [get_bd_intf_pins axi_gpio_status/S_AXI] [get_bd_intf_pins axi_pcie3_0_axi_periph/M08_AXI]
  connect_bd_intf_net -intf_net axi_register_slice_2_M_AXI [get_bd_intf_ports M_AXI_MM_TO_HLS_PR_NORTH] [get_bd_intf_pins FROM_SH_AXI_MM_NORTH/M_AXI_0]
  connect_bd_intf_net -intf_net ddr4_0_C0_DDR4 [get_bd_intf_ports c1_ddr4] [get_bd_intf_pins ddr4_1/C0_DDR4]
  connect_bd_intf_net -intf_net xdma_0_M_AXI [get_bd_intf_pins FROM_SH_AXI_MM_NORTH/S_AXI] [get_bd_intf_pins xDMA_SUBSYS/M_AXI]
  connect_bd_intf_net -intf_net xdma_0_pcie_mgt [get_bd_intf_ports pcie_mgt] [get_bd_intf_pins xDMA_SUBSYS/pcie_mgt]

  # Create port connections
  connect_bd_net -net axi_pcie3_0_axi_aclk [get_bd_ports clk_out_250M] [get_bd_pins FROM_SH_AXI_MM_NORTH/clk_out_250M] [get_bd_pins TO_SH_AXI_MM_NORTH/aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_pcie3_0_axi_periph/S00_ACLK] [get_bd_pins system_ila_AXIL/clk] [get_bd_pins xDMA_SUBSYS/clk_out_250M]
  connect_bd_net -net axi_pcie3_0_axi_aresetn [get_bd_pins FROM_SH_AXI_MM_NORTH/aresetn] [get_bd_pins TO_SH_AXI_MM_NORTH/aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_pcie3_0_axi_periph/S00_ARESETN] [get_bd_pins rst_125M/ext_reset_in] [get_bd_pins system_ila_AXIL/resetn] [get_bd_pins xDMA_SUBSYS/axi_aresetn]
  connect_bd_net -net clk_wiz_0_clk_out_125M [get_bd_ports clk_out_125M] [get_bd_pins FROM_SH_AXI_LITE_NORTH/aclk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_gpio_KER_ACTIVE_COUNT/s_axi_aclk] [get_bd_pins axi_gpio_status/s_axi_aclk] [get_bd_pins axi_hwicap_0/s_axi_aclk] [get_bd_pins axi_pcie3_0_axi_periph/ACLK] [get_bd_pins axi_pcie3_0_axi_periph/M01_ACLK] [get_bd_pins axi_pcie3_0_axi_periph/M02_ACLK] [get_bd_pins axi_pcie3_0_axi_periph/M03_ACLK] [get_bd_pins axi_pcie3_0_axi_periph/M04_ACLK] [get_bd_pins axi_pcie3_0_axi_periph/M05_ACLK] [get_bd_pins axi_pcie3_0_axi_periph/M06_ACLK] [get_bd_pins axi_pcie3_0_axi_periph/M07_ACLK] [get_bd_pins axi_pcie3_0_axi_periph/M08_ACLK] [get_bd_pins clk_wiz_0/clk_out_125M] [get_bd_pins clk_wiz_PROG/s_axi_aclk] [get_bd_pins rst_125M/slowest_sync_clk] [get_bd_pins system_management_wiz_0/s_axi_aclk]
  connect_bd_net -net clk_wiz_0_clk_out_62_5M [get_bd_pins axi_hwicap_0/icap_clk] [get_bd_pins clk_wiz_0/clk_out_62_5M]
  connect_bd_net -net clk_wiz_1_clk_out1 [get_bd_ports clk_out_PROG] [get_bd_pins clk_wiz_PROG/clk_out1]
  connect_bd_net -net clk_wiz_PROG_locked [get_bd_ports clk_out_PROG_locked] [get_bd_pins clk_wiz_PROG/locked]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_pcie3_0_axi_periph/M00_ACLK] [get_bd_pins clk_wiz_PROG/clk_in1] [get_bd_pins ddr4_1/c0_ddr4_ui_clk] [get_bd_pins rst_ddr4_0_300M/slowest_sync_clk] [get_bd_pins system_ila_AXI_MM/clk]
  connect_bd_net -net ddr4_0_c0_ddr4_ui_clk_sync_rst [get_bd_pins ddr4_1/c0_ddr4_ui_clk_sync_rst] [get_bd_pins rst_ddr4_0_300M/ext_reset_in]
  connect_bd_net -net ddr4_1_addn_ui_clkout1 [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins ddr4_1/addn_ui_clkout1]
  connect_bd_net -net ddr4_1_c0_init_calib_complete [get_bd_ports c1_init_calib_complete] [get_bd_pins ddr4_1/c0_init_calib_complete]
  connect_bd_net -net gpio2_io_i_0_1 [get_bd_ports ker_active_count_U] [get_bd_pins axi_gpio_KER_ACTIVE_COUNT/gpio2_io_i]
  connect_bd_net -net gpio_io_i_0_1 [get_bd_ports ker_active_count_L] [get_bd_pins axi_gpio_KER_ACTIVE_COUNT/gpio_io_i]
  connect_bd_net -net gpio_io_i_0_2 [get_bd_ports status_gpio_in] [get_bd_pins axi_gpio_status/gpio_io_i]
  connect_bd_net -net rst_ddr4_0_300M1_peripheral_aresetn [get_bd_ports axi_reset_n_out] [get_bd_pins FROM_SH_AXI_LITE_NORTH/aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_gpio_KER_ACTIVE_COUNT/s_axi_aresetn] [get_bd_pins axi_gpio_status/s_axi_aresetn] [get_bd_pins axi_hwicap_0/s_axi_aresetn] [get_bd_pins axi_pcie3_0_axi_periph/ARESETN] [get_bd_pins axi_pcie3_0_axi_periph/M01_ARESETN] [get_bd_pins axi_pcie3_0_axi_periph/M02_ARESETN] [get_bd_pins axi_pcie3_0_axi_periph/M03_ARESETN] [get_bd_pins axi_pcie3_0_axi_periph/M04_ARESETN] [get_bd_pins axi_pcie3_0_axi_periph/M05_ARESETN] [get_bd_pins axi_pcie3_0_axi_periph/M06_ARESETN] [get_bd_pins axi_pcie3_0_axi_periph/M07_ARESETN] [get_bd_pins axi_pcie3_0_axi_periph/M08_ARESETN] [get_bd_pins clk_wiz_PROG/s_axi_aresetn] [get_bd_pins rst_125M/peripheral_aresetn] [get_bd_pins system_management_wiz_0/s_axi_aresetn]
  connect_bd_net -net rst_ddr4_0_300M_peripheral_aresetn [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_pcie3_0_axi_periph/M00_ARESETN] [get_bd_pins ddr4_1/c0_ddr4_aresetn] [get_bd_pins rst_ddr4_0_300M/peripheral_aresetn] [get_bd_pins system_ila_AXI_MM/resetn]
  connect_bd_net -net sys_clk_1 [get_bd_ports sys_clk] [get_bd_pins xDMA_SUBSYS/sys_clk]
  connect_bd_net -net sys_clk_gt_1 [get_bd_ports sys_clk_gt] [get_bd_pins xDMA_SUBSYS/sys_clk_gt]
  connect_bd_net -net sys_rst_1 [get_bd_ports DDR4_sys_rst] [get_bd_pins ddr4_1/sys_rst]
  connect_bd_net -net sys_rst_n_1 [get_bd_ports sys_rst_n] [get_bd_pins xDMA_SUBSYS/sys_rst_n]
  connect_bd_net -net xdma_0_user_lnk_up [get_bd_pins rst_125M/dcm_locked] [get_bd_pins xDMA_SUBSYS/user_lnk_up]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins axi_hwicap_0/eos_in] [get_bd_pins xDMA_SUBSYS/usr_irq_req] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins FROM_SH_AXI_LITE_NORTH/decouple] [get_bd_pins FROM_SH_AXI_MM_NORTH/aresetn1] [get_bd_pins TO_SH_AXI_MM_NORTH/decouple] [get_bd_pins axi_gpio_0/gpio2_io_i] [get_bd_pins axi_gpio_0/gpio_io_o]

  # Create address segments
  create_bd_addr_seg -range 0x00100000 -offset 0x00100000 [get_bd_addr_spaces xDMA_SUBSYS/xdma_0/M_AXI_LITE] [get_bd_addr_segs M_AXI_LITE_TO_HLS_PR_NORTH/Reg] SEG_M_AXI_LITE_TO_HLS_PR_NORTH_Reg
  create_bd_addr_seg -range 0x002000000000 -offset 0x00000000 [get_bd_addr_spaces xDMA_SUBSYS/xdma_0/M_AXI] [get_bd_addr_segs M_AXI_MM_TO_HLS_PR_NORTH/Reg] SEG_M_AXI_MM_TOHLS_PR_NORTH_Reg
  create_bd_addr_seg -range 0x00002000 -offset 0x000F0000 [get_bd_addr_spaces xDMA_SUBSYS/xdma_0/M_AXI_LITE] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x00010000 -offset 0x00010000 [get_bd_addr_spaces xDMA_SUBSYS/xdma_0/M_AXI_LITE] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x00070000 [get_bd_addr_spaces xDMA_SUBSYS/xdma_0/M_AXI_LITE] [get_bd_addr_segs axi_gpio_KER_ACTIVE_COUNT/S_AXI/Reg] SEG_axi_gpio_1_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x00080000 [get_bd_addr_spaces xDMA_SUBSYS/xdma_0/M_AXI_LITE] [get_bd_addr_segs axi_gpio_status/S_AXI/Reg] SEG_axi_gpio_status_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x00030000 [get_bd_addr_spaces xDMA_SUBSYS/xdma_0/M_AXI_LITE] [get_bd_addr_segs axi_hwicap_0/S_AXI_LITE/Reg] SEG_axi_hwicap_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x00020000 [get_bd_addr_spaces xDMA_SUBSYS/xdma_0/M_AXI_LITE] [get_bd_addr_segs clk_wiz_PROG/s_axi_lite/Reg] SEG_clk_wiz_PROG_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x000E0000 [get_bd_addr_spaces xDMA_SUBSYS/xdma_0/M_AXI_LITE] [get_bd_addr_segs ddr4_1/C0_DDR4_MEMORY_MAP_CTRL/C0_REG] SEG_ddr4_1_C0_REG
  create_bd_addr_seg -range 0x00010000 -offset 0x00050000 [get_bd_addr_spaces xDMA_SUBSYS/xdma_0/M_AXI_LITE] [get_bd_addr_segs system_management_wiz_0/S_AXI_LITE/Reg] SEG_system_management_wiz_0_Reg
  create_bd_addr_seg -range 0x001000000000 -offset 0x00000000 [get_bd_addr_spaces S_AXI_MM_FROM_HLS_PR_NORTH] [get_bd_addr_segs ddr4_1/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] SEG_ddr4_0_C0_DDR4_ADDRESS_BLOCK


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


