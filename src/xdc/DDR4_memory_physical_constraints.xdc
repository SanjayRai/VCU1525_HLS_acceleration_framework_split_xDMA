create_pblock pblock_dynamic_SLR0
resize_pblock [get_pblocks pblock_dynamic_SLR0] -add {CLOCKREGION_X0Y0:CLOCKREGION_X5Y4}
#resize_pblock [get_pblocks pblock_dynamic_SLR0] -remove {SLICE_X159Y270:SLICE_X168Y299 DSP48E2_X18Y108:DSP48E2_X18Y119 LAGUNA_X22Y180:LAGUNA_X23Y239 RAMB18_X11Y108:RAMB18_X11Y119 RAMB36_X11Y54:RAMB36_X11Y59}
set_property SNAPPING_MODE ON [get_pblocks pblock_dynamic_SLR0]
set_property PARENT pblock_role_HLS_PR_NORTH  [get_pblocks pblock_dynamic_SLR0] -quiet
add_cells_to_pblock [get_pblocks pblock_dynamic_SLR0] [get_cells -of [get_pins -leaf -of [get_nets U_role_NORTH/HLS_PR_0_i_NORTH/DDR_SUB_SYS/PR_DDR4_MIG_0/ddr4_0/inst/u_ddr4_infrastructure/div_clk]]] -quiet
create_pblock pblock_dynamic_SLR0_ddr4_mem00
add_cells_to_pblock [get_pblocks pblock_dynamic_SLR0_ddr4_mem00] [get_cells  U_role_NORTH/HLS_PR_0_i_NORTH/DDR_SUB_SYS/PR_DDR4_MIG_0] -quiet
resize_pblock [get_pblocks pblock_dynamic_SLR0_ddr4_mem00] -add {CLOCKREGION_X2Y1:CLOCKREGION_X2Y3}
set_property SNAPPING_MODE ON [get_pblocks pblock_dynamic_SLR0_ddr4_mem00]
set_property PARENT pblock_dynamic_SLR0 [get_pblocks pblock_dynamic_SLR0_ddr4_mem00]

create_pblock pblock_dynamic_SLR1
resize_pblock [get_pblocks pblock_dynamic_SLR1] -add {CLOCKREGION_X0Y5:CLOCKREGION_X2Y9}
set_property SNAPPING_MODE ON [get_pblocks pblock_dynamic_SLR1]
set_property PARENT pblock_role_HLS_PR_NORTH  [get_pblocks pblock_dynamic_SLR1] -quiet
add_cells_to_pblock [get_pblocks pblock_dynamic_SLR1] [get_cells -of [get_pins -leaf -of [get_nets U_role_NORTH/HLS_PR_0_i_NORTH/DDR_SUB_SYS/PR_DDR4_MIG_2/ddr4_2/inst/u_ddr4_infrastructure/div_clk]]] -quiet
create_pblock pblock_dynamic_SLR1_ddr4_mem01
add_cells_to_pblock [get_pblocks pblock_dynamic_SLR1_ddr4_mem01] [get_cells  U_role_NORTH/HLS_PR_0_i_NORTH/DDR_SUB_SYS/PR_DDR4_MIG_2] -quiet
resize_pblock [get_pblocks pblock_dynamic_SLR1_ddr4_mem01] -add {CLOCKREGION_X2Y7:CLOCKREGION_X2Y9}
set_property SNAPPING_MODE ON [get_pblocks pblock_dynamic_SLR1_ddr4_mem01]
set_property PARENT pblock_dynamic_SLR1 [get_pblocks pblock_dynamic_SLR1_ddr4_mem01]

create_pblock pblock_dynamic_SLR2
resize_pblock [get_pblocks pblock_dynamic_SLR2] -add {CLOCKREGION_X0Y10:CLOCKREGION_X5Y14}
#resize_pblock [get_pblocks pblock_dynamic_SLR2] -remove {SLICE_X159Y600:SLICE_X168Y629 DSP48E2_X18Y240:DSP48E2_X18Y251 LAGUNA_X22Y480:LAGUNA_X23Y539 RAMB18_X11Y240:RAMB18_X11Y251 RAMB36_X11Y120:RAMB36_X11Y125}
set_property SNAPPING_MODE ON [get_pblocks pblock_dynamic_SLR2]
set_property PARENT pblock_role_HLS_PR_NORTH  [get_pblocks pblock_dynamic_SLR2] -quiet
add_cells_to_pblock [get_pblocks pblock_dynamic_SLR2] [get_cells -of [get_pins -leaf -of [get_nets U_role_NORTH/HLS_PR_0_i_NORTH/DDR_SUB_SYS/PR_DDR4_MIG_3/ddr4_3/inst/u_ddr4_infrastructure/div_clk]]] -quiet
create_pblock pblock_dynamic_SLR2_ddr4_mem02
add_cells_to_pblock [get_pblocks pblock_dynamic_SLR2_ddr4_mem02] [get_cells  U_role_NORTH/HLS_PR_0_i_NORTH/DDR_SUB_SYS/PR_DDR4_MIG_3] -quiet
resize_pblock [get_pblocks pblock_dynamic_SLR2_ddr4_mem02] -add {CLOCKREGION_X4Y11:CLOCKREGION_X4Y13}
set_property SNAPPING_MODE ON [get_pblocks pblock_dynamic_SLR2_ddr4_mem02]
set_property PARENT pblock_dynamic_SLR2 [get_pblocks pblock_dynamic_SLR2_ddr4_mem02]


set_property CLOCK_ROOT X4Y7 [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/ddr4_1/inst/u_ddr4_infrastructure/u_bufg_riuClk/O]
set_property CLOCK_ROOT X4Y7 [get_pins U_shell_top/PCIe_Bridge_ICAP_complex_i/ddr4_1/inst/u_ddr4_infrastructure/u_bufg_divClk/O]

# set_property CLOCK_ROOT X2Y2 [get_pins U_role_NORTH/HLS_PR_0_i_NORTH/DDR_SUB_SYS/PR_DDR4_MIG_0/ddr4_0/inst/u_ddr4_infrastructure/u_bufg_divClk/O]
# set_property CLOCK_ROOT X2Y2 [get_pins U_role_NORTH/HLS_PR_0_i_NORTH/DDR_SUB_SYS/PR_DDR4_MIG_0/ddr4_0/inst/u_ddr4_infrastructure/u_bufg_riuClk/O]
# 
# set_property CLOCK_ROOT X2Y8 [get_pins U_role_NORTH/HLS_PR_0_i_NORTH/DDR_SUB_SYS/PR_DDR4_MIG_2/ddr4_2/inst/u_ddr4_infrastructure/u_bufg_divClk/O]
# set_property CLOCK_ROOT X2Y8 [get_pins U_role_NORTH/HLS_PR_0_i_NORTH/DDR_SUB_SYS/PR_DDR4_MIG_2/ddr4_2/inst/u_ddr4_infrastructure/u_bufg_riuClk/O]
# 
# set_property CLOCK_ROOT X4Y12 [get_pins U_role_NORTH/HLS_PR_0_i_NORTH/DDR_SUB_SYS/PR_DDR4_MIG_3/ddr4_3/inst/u_ddr4_infrastructure/u_bufg_divClk/O]
# set_property CLOCK_ROOT X4Y12 [get_pins U_role_NORTH/HLS_PR_0_i_NORTH/DDR_SUB_SYS/PR_DDR4_MIG_3/ddr4_3/inst/u_ddr4_infrastructure/u_bufg_riuClk/O]
