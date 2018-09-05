# Created : 9:31:38, Tue Jun 21, 2016 : Sanjay Rai

source ../device_type.tcl

set TOP_module VU9P_AXI_ICAP_PR_DESIGN_top
set ROLE_CLK_PERIOD 8.000
set NORTH_ROLE_NAME IP_SDX_ACCL_MATRIX_INVERT_4X4_CPP_KERNEL 
proc synth_hls_pr_NORTH {ARGV_0} { 

upvar 1 $ARGV_0 ROLE_NAME

    create_project -in_memory -part [DEVICE_TYPE] 

    read_bd "../IP/role/$ROLE_NAME/HLS_PR_SDX_SRAI/HLS_PR_SDX_SRAI.bd"

    read_ip " ../IP/role/debug_bridge_PR/debug_bridge_PR.xci"

    read_verilog {
    ../src/srai_accel_intfc.sv
    ../src/role_NORTH/role_NORTH.sv
    }

    read_xdc -mode out_of_context -ref role_NORTH  ../src/role_NORTH/xdc/role_NORTH.xdc

    synth_design -keep_equivalent_registers -shreg_min_size 8 -include_dirs ../src -top role_NORTH -verilog_define XSDB_SLV_DIS -mode out_of_context  -part [DEVICE_TYPE] 
    
    opt_design -verbose -directive Explore

    write_checkpoint -force ../checkpoints/role_NORTH.$ROLE_NAME.post_synth_opt.dcp
    close_project
}

proc build_design {ARGV_0 ARGV_1 ARGV_2} { 
upvar 1 $ARGV_0 TOP_module
upvar 1 $ARGV_1 NORTH_ROLE_NAME
upvar 1 $ARGV_2 ROLE_CLK_PERIOD
    create_project -in_memory -part [DEVICE_TYPE] 
    add_files  ../checkpoints/$TOP_module.routed_BB.dcp
    read_checkpoint -cell U_role_NORTH ../checkpoints/role_NORTH.$NORTH_ROLE_NAME.post_synth_opt.dcp
    link_design -top $TOP_module -part [DEVICE_TYPE] -reconfig_partitions {U_role_NORTH}
    opt_design -verbose -directive Explore

    create_clock -name SRAI_PROG_CLK -period $ROLE_CLK_PERIOD [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/clk_wiz_PROG/inst/CLK_CORE_DRP_I/clk_inst/mmcme4_adv_inst/CLKOUT0]
    set_false_path -through [get_pins {U_shell_top/PCIe_Bridge_ICAP_complex_i/axi_gpio_0/gpio_io_*[*]}]
    set_clock_groups -name SRAI_CG_PROG_CLK -asynchronous -group [ get_clocks -of_objects [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/clk_wiz_PROG/inst/CLK_CORE_DRP_I/clk_inst/mmcme4_adv_inst/CLKOUT0]] -group [get_clocks [list  [get_clocks -of_objects [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/clk_wiz_0/inst/mmcme4_adv_inst/CLKOUT0]] [get_clocks -of_objects [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/clk_wiz_0/inst/mmcme4_adv_inst/CLKOUT1]]]]

    write_checkpoint -force ./$TOP_module.$NORTH_ROLE_NAME.post_synth_opt.dcp
    place_design -verbose -no_bufg_opt -directive Explore
    write_checkpoint -force ./$TOP_module.$NORTH_ROLE_NAME.post_place.dcp

    set_clock_uncertainty -setup 0.200 -from [get_clocks -of_objects [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/xDMA_SUBSYS/pcie4_uscale_plus_0/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -to [get_clocks {U_shell_top/PCIe_Bridge_ICAP_complex_i/xDMA_SUBSYS/pcie4_uscale_plus_0/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/gt_wizard.gtwizard_top_i/PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[29].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]
    set_clock_uncertainty -setup 0.200 -from [get_clocks {U_shell_top/PCIe_Bridge_ICAP_complex_i/xDMA_SUBSYS/pcie4_uscale_plus_0/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/gt_wizard.gtwizard_top_i/PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[29].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}] -to [get_clocks -of_objects [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/xDMA_SUBSYS/pcie4_uscale_plus_0/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]]
    set_clock_uncertainty -setup 0.200 -from [get_clocks {U_shell_top/PCIe_Bridge_ICAP_complex_i/xDMA_SUBSYS/pcie4_uscale_plus_0/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/gt_wizard.gtwizard_top_i/PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[29].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}] -to [get_clocks {U_shell_top/PCIe_Bridge_ICAP_complex_i/xDMA_SUBSYS/pcie4_uscale_plus_0/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/gt_wizard.gtwizard_top_i/PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[29].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]
    set_clock_uncertainty -setup 0.300 -from [get_clocks SRAI_PROG_CLK] -to [get_clocks SRAI_PROG_CLK]
    
    phys_opt_design  -verbose -directive Explore

    set_clock_uncertainty -setup 0.000 -from [get_clocks -of_objects [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/xDMA_SUBSYS/pcie4_uscale_plus_0/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -to [get_clocks {U_shell_top/PCIe_Bridge_ICAP_complex_i/xDMA_SUBSYS/pcie4_uscale_plus_0/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/gt_wizard.gtwizard_top_i/PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[29].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]
    set_clock_uncertainty -setup 0.000 -from [get_clocks {U_shell_top/PCIe_Bridge_ICAP_complex_i/xDMA_SUBSYS/pcie4_uscale_plus_0/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/gt_wizard.gtwizard_top_i/PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[29].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}] -to [get_clocks -of_objects [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/xDMA_SUBSYS/pcie4_uscale_plus_0/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]]
    set_clock_uncertainty -setup 0.000 -from [get_clocks {U_shell_top/PCIe_Bridge_ICAP_complex_i/xDMA_SUBSYS/pcie4_uscale_plus_0/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/gt_wizard.gtwizard_top_i/PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[29].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}] -to [get_clocks {U_shell_top/PCIe_Bridge_ICAP_complex_i/xDMA_SUBSYS/pcie4_uscale_plus_0/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/gt_wizard.gtwizard_top_i/PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_i/inst/gen_gtwizard_gtye4_top.PCIe_Bridge_ICAP_complex_pcie4_uscale_plus_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[29].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST/TXOUTCLK}]
    set_clock_uncertainty -setup 0.000 -from [get_clocks SRAI_PROG_CLK] -to [get_clocks SRAI_PROG_CLK]
    
    write_checkpoint -force ./$TOP_module.$NORTH_ROLE_NAME.post_place_phys_opt.dcp
    route_design  -verbose -directive Explore
    write_checkpoint -force ./$TOP_module.$NORTH_ROLE_NAME.post_route.dcp
    phys_opt_design  -verbose -directive Explore
    write_checkpoint -force ./$TOP_module.$NORTH_ROLE_NAME.post_route_phys_opt.dcp
    write_debug_probes ./$TOP_module.$NORTH_ROLE_NAME.ltx
    report_timing_summary -file $TOP_module.$NORTH_ROLE_NAME.timing_summary.rpt
    report_drc -file $TOP_module.$NORTH_ROLE_NAME.drc.rpt

    write_checkpoint -force -cell U_role_NORTH ../checkpoints/U_role_NORTH.$NORTH_ROLE_NAME.post_route_phys_opt.dcp

    set_param bitstream.enablePR 4123
    set_property BITSTREAM.CONFIG.CONFIGRATE 85.0 [current_design]
    set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
    set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
    set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
    set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
    set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN Disable [current_design]
    set_property CONFIG_MODE SPIx4 [current_design]
    set_property CONFIG_VOLTAGE 1.8 [current_design]
    set_property CFGBVS GND [current_design]
    write_bitstream -bin_file $TOP_module.$NORTH_ROLE_NAME.bit      
    close_project
}
synth_hls_pr_NORTH NORTH_ROLE_NAME
build_design TOP_module NORTH_ROLE_NAME ROLE_CLK_PERIOD 
