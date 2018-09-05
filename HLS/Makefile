# Created : 16:59:35, Fri May 20, 2017 : Sanjay Rai

.PHONY: all

all: help 

SRAI_HW:
	cd SDX_ACCL_KERNEL_PASSTHRU/Make_flow; make srai_hw
	cd SDX_ACCL_KERNEL_FP_VECTOR_MULT/Make_flow; make srai_hw
	cd SDX_ACCL_MATRIX_INVERT_4X4_CPP_KERNEL/Make_flow; make srai_hw
	cd SDX_ACCL_MATRIX_INVERT_5X5_CPP_KERNEL/Make_flow; make srai_hw
	cd SDX_ACCL_MATRIX_MULT_6X6/Make_flow; make srai_hw
	cd SDX_ACCL_MATRIX_MULT_8X8/Make_flow; make srai_hw

SRAI_SW_SIM:
	cd SDX_ACCL_KERNEL_PASSTHRU/Make_flow; make srai_sw_sim
	cd SDX_ACCL_KERNEL_FP_VECTOR_MULT/Make_flow; make srai_sw_sim
	cd SDX_ACCL_MATRIX_INVERT_4X4_CPP_KERNEL/Make_flow; make srai_sw_sim
	cd SDX_ACCL_MATRIX_INVERT_5X5_CPP_KERNEL/Make_flow; make srai_sw_sim
	cd SDX_ACCL_MATRIX_MULT_6X6/Make_flow; make srai_sw_sim
	cd SDX_ACCL_MATRIX_MULT_8X8/Make_flow; make srai_sw_sim

HLS_IP:
	cd SDX_ACCL_KERNEL_PASSTHRU/vivado_hls_prj;vivado_hls -f vivado_hls_project.tcl
	cd SDX_ACCL_KERNEL_FP_VECTOR_MULT/vivado_hls_prj;vivado_hls -f vivado_hls_project.tcl
	cd SDX_ACCL_MATRIX_INVERT_4X4_CPP_KERNEL/vivado_hls_prj;vivado_hls -f vivado_hls_project.tcl
	cd SDX_ACCL_MATRIX_INVERT_5X5_CPP_KERNEL/vivado_hls_prj;vivado_hls -f vivado_hls_project.tcl
	cd SDX_ACCL_MATRIX_MULT_6X6/vivado_hls_prj;vivado_hls -f vivado_hls_project.tcl
	cd SDX_ACCL_MATRIX_MULT_8X8/vivado_hls_prj;vivado_hls -f vivado_hls_project.tcl

HLS_IP_CLEAN:
	-cd SDX_ACCL_KERNEL_PASSTHRU/vivado_hls_prj; ./mk_clean
	-cd SDX_ACCL_KERNEL_FP_VECTOR_MULT/vivado_hls_prj; ./mk_clean
	-cd SDX_ACCL_MATRIX_INVERT_4X4_CPP_KERNEL/vivado_hls_prj; ./mk_clean
	-cd SDX_ACCL_MATRIX_INVERT_5X5_CPP_KERNEL/vivado_hls_prj; ./mk_clean
	-cd SDX_ACCL_MATRIX_MULT_6X6/vivado_hls_prj; ./mk_clean
	-cd SDX_ACCL_MATRIX_MULT_8X8/vivado_hls_prj; ./mk_clean

clean_all:
	-cd SDX_ACCL_KERNEL_PASSTHRU/Make_flow; make clean_all 
	-cd SDX_ACCL_KERNEL_FP_VECTOR_MULT/Make_flow; make clean_all 
	-cd SDX_ACCL_MATRIX_INVERT_4X4_CPP_KERNEL/Make_flow; make clean_all 
	-cd SDX_ACCL_MATRIX_INVERT_5X5_CPP_KERNEL/Make_flow; make clean_all 
	-cd SDX_ACCL_MATRIX_MULT_6X6/Make_flow; make clean_all 
	-cd SDX_ACCL_MATRIX_MULT_8X8/Make_flow; make clean_all 

help:
	@echo "    make  SRAI_HW | SRAI_SW_SIM | HLS_IP | clean_all | HLS_IP_CLEAN"
