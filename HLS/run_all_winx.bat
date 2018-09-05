echo Start PR Kernel Test Loop

rem for /L %%i IN (0, 1, 1000) DO (
for /L %%i IN (0, 1, 20) DO (
rem for /L %%i IN (0, 1, 20) DO (
    echo "*****************************************************************"
    echo "************************** Start loop %%i **************************"
    SDX_ACCL_KERNEL_FP_VECTOR_MULT\windows_build\winX\x64\Debug\winX.exe ..\bitfiles\role\VU9P_AXI_ICAP_PR_DESIGN_top.IP_SDX_ACCL_KERNEL_FP_VECTOR_MULT_pblock_role_HLS_PR_NORTH_partial.bin
rem     SDX_ACCL_KERNEL_PASSTHRU\windows_build\winX\x64\Debug\winX.exe ..\bitfiles\role\VU9P_AXI_ICAP_PR_DESIGN_top.IP_SDX_ACCL_KERNEL_PASSTHRU_pblock_role_HLS_PR_NORTH_partial.bin
rem     SDX_ACCL_MATRIX_INVERT_4X4_CPP_KERNEL\windows_build\winX\x64\Debug\winX.exe ..\bitfiles\role\VU9P_AXI_ICAP_PR_DESIGN_top.IP_SDX_ACCL_MATRIX_INVERT_4X4_CPP_KERNEL_pblock_role_HLS_PR_NORTH_partial.bin
rem     SDX_ACCL_MATRIX_INVERT_5X5_CPP_KERNEL\windows_build\winX\x64\Debug\winX.exe ..\bitfiles\role\VU9P_AXI_ICAP_PR_DESIGN_top.IP_SDX_ACCL_MATRIX_INVERT_5X5_CPP_KERNEL_pblock_role_HLS_PR_NORTH_partial.bin
rem     SDX_ACCL_MATRIX_MULT_6X6\windows_build\winX\x64\Debug\winX.exe ..\bitfiles\role\VU9P_AXI_ICAP_PR_DESIGN_top.IP_SDX_ACCL_MATRIX_MULT_6X6_pblock_role_HLS_PR_NORTH_partial.bin
rem     SDX_ACCL_MATRIX_MULT_8X8\windows_build\winX\x64\Debug\winX.exe ..\bitfiles\role\VU9P_AXI_ICAP_PR_DESIGN_top.IP_SDX_ACCL_MATRIX_MULT_8X8_pblock_role_HLS_PR_NORTH_partial.bin
    echo "************************** End loop %%i **************************"
    echo "*****************************************************************"
)
