#include<stdio.h>
#include<math.h>
#include <errno.h>

#include <fstream>
#include <string>
#include <chrono>
#include <cmath>
#include "sdx_cppKernel_top.h" 
#ifdef LINUX_BUILD
#include "pcie_memio.h" 
#include "srai_accel_utils.h" 
#else
#include "pcie_memio_winx.h"
#include "srai_accel_utils_winx.h" 
#endif
#define ZERO_f 1.0e-4
#define ONE_GIG (1024UL*1024UL*1024UL)
using namespace std;



int check_if_Indentity_Matrix (data_t matrix_A[DIM][DIM]){
int id_error_count;
    id_error_count = 0;
    for (int row = 0; row < DIM;row++) {
        for (int col = 0; col < DIM;col++) {
            if (row == col) {
                if (fabs(matrix_A[row][col] -1.0f) > 0.1e-4){
                    cout << "ERROR DBG :: " << fabs(matrix_A[row][col] -1.0f) << endl;
                    id_error_count++;
                } 
            } else if (fabs(matrix_A[row][col]) > 0.1e-4){
                    id_error_count++;
            }
        }
    }
    return id_error_count;
}

void matrix_mult (data_t matrix_A[DIM][DIM], data_t matrix_B[DIM][DIM], data_t mult[DIM][DIM]) {
    for (int row = 0; row < DIM;row++) {
        for (int col = 0; col < DIM;col++) {
            mult[row][col] = 0.0f;
        }
    }
    for (int row = 0; row < DIM;row++) {
        for (int col = 0; col < DIM;col++) {
          for (int k = 0; k < DIM;k++) {
            mult[row][col] += matrix_A[row][k]* matrix_B[k][col];
          }
        }
    }
}

void print_matrix (data_t matrix_val[DIM][DIM]) {
    for (int row = 0; row < DIM;row++) {
        for (int col = 0; col < DIM;col++) {
            if (fabs(matrix_val[row][col]) < 0.1e-4) {
                matrix_val[row][col] = 0.0f;
            }
            cout << matrix_val[row][col] << " "; 
        }
        cout << endl;
    }
        cout << "------------------------------------"<< endl;

}

void gen_test_matrix(srai_mem_conv_IN0 *a) {

//    
//     data_t temp_ID[DIM][DIM] = {{1.0f, 0.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 1.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 1.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 1.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 0.0f, 1.0f}};
// 
//
   data_t temp[DIM][DIM] = {{2.0f, 4.0f, 6.0f, 8.0f, 1.0f, 4.0f},
                            {1.0f, 2.0f, 4.0f, 6.0f, 2.0f, 2.0f},
                            {4.0f, 2.0f, 8.0f, 6.0f, 3.0f, 2.0f},
                            {6.0f, 2.0f, 2.0f, 4.0f, 5.0f, 2.0f},
                            {4.0f, 2.0f, 4.0f, 6.0f, 7.0f, 2.0f},
                            {1.0f, 2.0f, 4.0f, 6.0f, 2.0f, 2.0f}};
   
    data_t temp_ID[DIM][DIM] = {{1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f},
                                {0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f},
                                {0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f},
                                {0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f},
                                {0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f},
                                {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f}};
//    data_t temp[DIM][DIM] = {{2.0f, 4.0f, 6.0f, 8.0f, 1.0f, 4.0f, 6.0f, 8.0f},
//                             {1.0f, 2.0f, 4.0f, 6.0f, 2.0f, 2.0f, 4.0f, 6.0f},
//                             {4.0f, 2.0f, 8.0f, 6.0f, 3.0f, 2.0f, 8.0f, 6.0f},
//                             {6.0f, 2.0f, 2.0f, 4.0f, 5.0f, 2.0f, 2.0f, 4.0f},
//                             {4.0f, 2.0f, 4.0f, 6.0f, 7.0f, 2.0f, 4.0f, 6.0f},
//                             {1.0f, 2.0f, 4.0f, 6.0f, 2.0f, 2.0f, 4.0f, 6.0f},
//                             {4.0f, 2.0f, 8.0f, 6.0f, 3.0f, 2.0f, 8.0f, 6.0f},
//                             {1.0f, 2.0f, 4.0f, 6.0f, 2.0f, 2.0f, 4.0f, 6.0f}};
//    
//     data_t temp_ID[DIM][DIM] = {{1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f}};
//    data_t temp[DIM][DIM] = {{2.0f, 4.0f, 6.0f, 8.0f, 1.0f, 4.0f, 6.0f, 8.0f, 1.0f, 1.0f},
//                             {1.0f, 2.0f, 4.0f, 6.0f, 2.0f, 2.0f, 4.0f, 6.0f, 2.0f, 2.0f},
//                             {4.0f, 2.0f, 8.0f, 6.0f, 3.0f, 2.0f, 8.0f, 6.0f, 3.0f, 3.0f},
//                             {6.0f, 2.0f, 2.0f, 4.0f, 5.0f, 2.0f, 2.0f, 4.0f, 5.0f, 5.0f},
//                             {4.0f, 2.0f, 4.0f, 6.0f, 7.0f, 2.0f, 4.0f, 6.0f, 7.0f, 7.0f},
//                             {1.0f, 2.0f, 4.0f, 6.0f, 2.0f, 2.0f, 4.0f, 6.0f, 2.0f, 2.0f},
//                             {4.0f, 2.0f, 8.0f, 6.0f, 3.0f, 2.0f, 8.0f, 6.0f, 3.0f, 3.0f},
//                             {6.0f, 2.0f, 2.0f, 4.0f, 5.0f, 2.0f, 2.0f, 4.0f, 5.0f, 5.0f},
//                             {4.0f, 2.0f, 4.0f, 6.0f, 7.0f, 2.0f, 4.0f, 6.0f, 7.0f, 7.0f},
//                             {1.0f, 2.0f, 4.0f, 6.0f, 2.0f, 2.0f, 4.0f, 6.0f, 2.0f, 2.0f}};
//    
//     data_t temp_ID[DIM][DIM] = {{1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f},
//                                 {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f}};

  data_t random_scale;

    for (int j = 0 ; j < NUMBER_OF_DATA_SETS; j++) {
        for (int i = 0 ; i < SDX_CU_LOCAL_SIZE; i++) {
        // Input A Matrix -- Argument #1
            //random_scale = (data_t)(i+1.0f);
            random_scale = (data_t)(rand() % (int)32768.0)/321.01;
            for (int row = 0; row < DIM;row++) {
                for (int col = 0; col < DIM;col++) {
                    a->my_data_t[row][col] = (temp[row][col])*random_scale; 
                }
            }
            a++;
        // Input B Matrix -- Argument #2
            //random_scale = (data_t)(1.0f);
            random_scale = (data_t)(rand() % (int)32768.0)/1321.01;
            //random_scale = (data_t)(i+1.0f);
            //random_scale = (data_t)(rand() % (int)32768.0)/321.01;
            for (int row = 0; row < DIM;row++) {
                for (int col = 0; col < DIM;col++) {
                    a->my_data_t[row][col] = (temp[row][col])*random_scale; 
                    //a->my_data_t[row][col] = (temp_ID[row][col]); 
                }
            }
            a++;
        }
    }
}

void print_gen_test_matrix(srai_mem_conv_IN0 *a) {

    for (int j = 0 ; j < NUMBER_OF_DATA_SETS; j++) {
        for (int i = 0 ; i < SDX_CU_LOCAL_IN_SIZE; i++) {
            for (int row = 0; row < DIM;row++) {
                for (int col = 0; col < DIM;col++) {
                    cout << (data_t)a->my_data_t[row][col] << " ";
                }
                cout << endl;
            }
                cout << endl;
                cout << "------------------------------------"<< endl;
                a++;
        }
    }
}

int main(int argc, char** argv) {

  int compute_itn_count;
  time_t t;
  srand((unsigned) time(&t));
  double high_res_elapsed_time;
  double high_res_elapsed_time_HW = 0.0f;
  double high_res_elapsed_time_SW = 0.0f;
  chrono::high_resolution_clock::time_point start_t;
  chrono::high_resolution_clock::time_point stop_t;
  chrono::duration<double> elapsed_hi_res;


  uint32_t dbg_ker_count = 0;
  sdx_data_t *a_in_ptr;
#ifdef LINUX_BUILD
  char *a_in_ptr_c_POSIX = NULL;
  char *y_out_ptr_c_POSIX = NULL;
#else
  void *a_in_ptr_c_WIN32;
  void *y_out_ptr_c_WIN32;
#endif
  srai_mem_conv_IN0 *a_in_ptr_c;
  srai_mem_conv_OUT0 *y_out_ptr_c;
  srai_mem_conv_IN0 *a_in_head_c;
  srai_mem_conv_OUT0 *y_out_head_c;
  sdx_data_t *y_out_ptr;

  SysMon_temp_struct sys_temprature;

  kernel_execution_metric_struct kernel_execution_metric; 

  cout << "Srai_ DBG NUMBER_OF_DATA_SETS  =  " << NUMBER_OF_DATA_SETS << endl;
  cout << "Srai_ DBG GLOBAL_DATA_IN_SIZE  =  " << GLOBAL_DATA_IN_SIZE << endl;
  cout << "Srai_ DBG GLOBAL_DATA_OUT_SIZE =  " << GLOBAL_DATA_OUT_SIZE << endl;
  if ((GLOBAL_DATA_IN_SIZE_BYTES > ONE_GIG) | (GLOBAL_DATA_OUT_SIZE_BYTES > ONE_GIG)) {
    cout << "Memory reguirement over 1GB .......... exiting\n";
    exit (1);
  }

#ifdef LINUX_BUILD
  posix_memalign((void **)&a_in_ptr_c_POSIX, 4096/*alignment*/, GLOBAL_DATA_IN_SIZE_BYTES + 4096);
  a_in_ptr_c = (srai_mem_conv_IN0 *)a_in_ptr_c_POSIX;
  posix_memalign((void **)&y_out_ptr_c_POSIX, 4096/*alignment*/, GLOBAL_DATA_OUT_SIZE_BYTES + 4096);
  y_out_ptr_c = (srai_mem_conv_OUT0 *)y_out_ptr_c_POSIX;
#else
  a_in_ptr_c_WIN32 = _aligned_malloc(GLOBAL_DATA_IN_SIZE_BYTES, 4096);
  a_in_ptr_c = (srai_mem_conv_IN0 *)a_in_ptr_c_WIN32;
  y_out_ptr_c_WIN32 = _aligned_malloc(GLOBAL_DATA_OUT_SIZE_BYTES, 4096);
  y_out_ptr_c = (srai_mem_conv_OUT0 *)y_out_ptr_c_WIN32;
#endif

  a_in_head_c = a_in_ptr_c;
  y_out_head_c = y_out_ptr_c;

  printf("-------------------------------------------------------------\n");
  printf("Create Test Data Set\n");
  printf("Note DATA_IN_SIZE (Input Memory size in bytes  ) = %d (%x)\n",(GLOBAL_DATA_IN_SIZE_BYTES),(GLOBAL_DATA_IN_SIZE_BYTES));
  printf("Note DATA_OUT_SIZE(Input Memory size in bytes  ) = %d (%x)\n",(GLOBAL_DATA_OUT_SIZE_BYTES),(GLOBAL_DATA_OUT_SIZE_BYTES));
  cout << "Size of data_t = " << sizeof(data_t) <<  " Bytes" << endl;
  cout << "Number of Input Operands =  " << NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_IN_SIZE*NUM_ELEMENTS_PER_SDX_DATA_BEAT<< endl;
  cout << "Number of Output Operands = " << NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_OUT_SIZE*NUM_ELEMENTS_PER_SDX_DATA_BEAT<< endl;
  cout << "Size of srai_mem_conv_IN0 = " << sizeof(srai_mem_conv_IN0) <<  " Bytes" << endl;
  cout << "True Size (in Bytes) of Input Data  = " << sizeof(data_t)*NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_IN_SIZE*NUM_ELEMENTS_PER_SDX_DATA_BEAT<< endl;
  cout << "Allocated Size (in Bytes) of a_in_ptr = " <<  GLOBAL_DATA_IN_SIZE_BYTES  << " | 0x"<< hex <<  GLOBAL_DATA_IN_SIZE_BYTES << endl;
  cout << dec;
  cout << "Allocated Size (in Bytes) of a_in_ptr_c = " << sizeof(srai_mem_conv_IN0)*NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_IN_SIZE << " | 0x" << hex << sizeof(srai_mem_conv_IN0)*NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_IN_SIZE << endl;
  cout << dec;
  printf("-------------------------------------------------------------\n\n\n");

    //Fill ddr4_Memory wr_data_buffer
    cout << "Initializing Memory with InputA args\n";
    gen_test_matrix(a_in_ptr_c);
    a_in_ptr = (sdx_data_t *)a_in_head_c;
    y_out_ptr = (sdx_data_t *)y_out_head_c;

    //print_gen_test_matrix(a_in_ptr_c);
    a_in_ptr_c = a_in_head_c;
    cout << "Memory Initialized with test Data\n";

#ifdef GPP_ONLY_FLOW  
    sdx_cppKernel_top(a_in_ptr, y_out_ptr, (unsigned int)NUMBER_OF_DATA_SETS, &dbg_ker_count);

#else
// Compile for SRAI custom HLS accelerator platform 
    string PR_binFile_name;

    if (argc != 2) {
        printf("usage: %s fpga_bin_file\n", argv[0]);
        return -1;
    }

    PR_binFile_name = argv[1];


    cout << "Initializing FPGA\n";
#ifdef LINUX_BUILD
    fpga_xDMA_linux *my_fpga_xDMA_ptr = new fpga_xDMA_linux;
#else
    fpga_xDMA_winX  *my_fpga_xDMA_ptr = new fpga_xDMA_winX;
#endif
    my_fpga_xDMA_ptr->fpga_xDMA_init();

    fpga_test_AXIL_LITE_8KSCRATCHPAD_BRAM (my_fpga_xDMA_ptr);
    //
    //DeIsolate before doing anyting on AXI Buses
    cout << "DeIsolate PR region \n";
    my_fpga_xDMA_ptr->fpga_poke(AXI_LITE_GPIO_BASE, DEISOLATE_NORTH_PR); 

    fpga_read_temprature(my_fpga_xDMA_ptr, &sys_temprature, 10);
    cout << "Current FPGA Die Temprature (deg C) =  " << sys_temprature.current_temp << endl;
    cout << "Current FPGA Max Die Temprature (deg C) =  " << sys_temprature.maximum_temp << endl;
    cout << "Current FPGA Min Die Temprature (deg C) =  " << sys_temprature.minimum_temp << endl;


    /* xDMA Throughput testing */
    cout << "xDMA BandWidth test C0  : \n";
   fpga_PCIE_BANDWIDTH_test64(my_fpga_xDMA_ptr, AXI_MM_DDR4_C0, (char*)a_in_ptr, GLOBAL_DATA_OUT_SIZE_BYTES);
   cout << "..........................\n";
   cout << "xDMA BandWidth test C1  : \n";
   fpga_PCIE_BANDWIDTH_test64(my_fpga_xDMA_ptr, AXI_MM_DDR4_C1, (char*)a_in_ptr, GLOBAL_DATA_OUT_SIZE_BYTES);
   cout << "..........................\n";
   cout << "xDMA BandWidth test C2  : \n";
   fpga_PCIE_BANDWIDTH_test64(my_fpga_xDMA_ptr, AXI_MM_DDR4_C2, (char*)a_in_ptr, GLOBAL_DATA_OUT_SIZE_BYTES);
   cout << "..........................\n";
   cout << "xDMA BandWidth test C3: \n";
   fpga_PCIE_BANDWIDTH_test64(my_fpga_xDMA_ptr, AXI_MM_DDR4_C3, (char*)a_in_ptr, GLOBAL_DATA_OUT_SIZE_BYTES);
   cout << "..........................\n";
   
   

    cout << "Start HLS execution " << endl;
    cout << " ............... Programing PR clock ------------------ " << endl;
    fpga_PROGRAM_PR_CLOCK (my_fpga_xDMA_ptr, HW_Kernel_frequency);
    cout << " ....DONE ...... Programing PR clock ------------------ " << endl;

    /* Program Partial Bit file */
    fpga_PROGRAM_NORTH_PR(my_fpga_xDMA_ptr, PR_binFile_name);
    cout << " ............... Done Programing PR Bitstream ------------------ " << endl;
    /* Read the PR_HLS Control register to poll the Idle bit (bit 1) */ 
    fpga_xfer_data_to_card64(my_fpga_xDMA_ptr, AXI_MM_DDR4_C1, (char*)a_in_ptr, (GLOBAL_DATA_IN_SIZE_BYTES));
    /* Write to PR_HLS Address offset registers to set the location in Memory where Input Data and Output results are stored */
    fpga_run_NORTH_PR64(my_fpga_xDMA_ptr, AXI_MM_DDR4_C1, AXI_MM_DDR4_results_C0, (NUMBER_OF_DATA_SETS));
    start_t = chrono::high_resolution_clock::now();
    compute_itn_count = fpga_check_compute_done_NORTH_PR(my_fpga_xDMA_ptr);
    stop_t = chrono::high_resolution_clock::now();
    cout << "compute_itn_count = " << compute_itn_count << endl;

    /* Read Results from DDR4 output (results) area */
    fpga_xfer_data_from_card64(my_fpga_xDMA_ptr, AXI_MM_DDR4_results_C0, (char*)y_out_ptr, (GLOBAL_DATA_OUT_SIZE_BYTES));

    elapsed_hi_res = stop_t - start_t ;
    high_res_elapsed_time = elapsed_hi_res.count();
    high_res_elapsed_time_HW = high_res_elapsed_time;
    cout << "HLS Execution time =  " <<  high_res_elapsed_time_HW << "s\n";
    cout << "HLS THroughput =  " <<  (GLOBAL_DATA_OUT_SIZE_BYTES/high_res_elapsed_time_HW) << " Bytes/s\n";

    fpga_get_Kernel_execution_time (my_fpga_xDMA_ptr, HW_Kernel_frequency, &kernel_execution_metric);
    cout << "KERNEL_DATASET =  " <<  dec << (kernel_execution_metric.KERNEL_DATASET) << " \n";
    cout << "KERNEL_CLOCK_COUNT =  " <<  dec << (kernel_execution_metric.KERNEL_CLOCK_COUNT) << " \n";
    cout << "KERNEL_Execution_time (sec) =  " <<  dec << (kernel_execution_metric.KERNEL_EXECUTION_TIME) << " \n";

    fpga_clean(my_fpga_xDMA_ptr);
#endif


    a_in_ptr_c = a_in_head_c;
    y_out_ptr_c = y_out_head_c;

    printf (" ------------   Results  ------------------------------\n");
    printf (" ------------------------------------------------------\n");
    data_t temp_A[DIM][DIM];
    data_t temp_B[DIM][DIM];
    data_t temp_Y[DIM][DIM];
    data_t mult_sw[DIM][DIM];
    int total_id_error;
    int curr_test_error;
    total_id_error = 0;
    int random_index[4];

    for (int i = 0; i < 4; i++) {
        random_index[i]  = (int)(rand() % NUMBER_OF_DATA_SETS);
    }
    for (int j = 0 ; j < NUMBER_OF_DATA_SETS; j++) {
    curr_test_error = 0;
        for (int i = 0 ; i < SDX_CU_LOCAL_SIZE; i++) {
            for (int row = 0; row < DIM;row++) {
                for (int col = 0; col < DIM;col++) {
                    temp_A[row][col] = a_in_ptr_c->my_data_t[row][col];
                }
            }
            a_in_ptr_c++;
            for (int row = 0; row < DIM;row++) {
                for (int col = 0; col < DIM;col++) {
                    temp_B[row][col] = a_in_ptr_c->my_data_t[row][col];
                    temp_Y[row][col] = y_out_ptr_c->my_data_t[row][col]; 
                }
            }
            a_in_ptr_c++;
            y_out_ptr_c++;

            auto start_t = chrono::high_resolution_clock::now();
            matrix_mult (temp_A, temp_B, mult_sw);
            auto stop_t = chrono::high_resolution_clock::now();
            chrono::duration<double> elapsed_hi_res = stop_t - start_t ;
            high_res_elapsed_time += elapsed_hi_res.count();
            for (int row = 0; row < DIM;row++) {
                for (int col = 0; col < DIM;col++) {
                    if (fabs(mult_sw[row][col]- temp_Y[row][col]) > 0.1e-4) {
                        curr_test_error++; 
                        cout << "Error !! Expected :" << mult_sw[row][col] << "  but got : " << temp_Y[row][col] << endl;
                    }
                }
            }
            if (curr_test_error != 0) { 
                total_id_error++;
                 cout << " -------- Expected-------\n";
                 print_matrix(mult_sw);
                 cout << " -------- Got from HW ---\n";
                 print_matrix(temp_Y);
            }
        }
        if (0) {
        //if ( (j == random_index[0]) | (j == random_index[1]) | (j == random_index[2]) | (j == random_index[3]) ) {
            cout << "................ Index = " << j << "  .........\n";
            cout << "Input Matrix A .........\n";
            print_matrix(temp_A);
            cout << "Input Matrix B .........\n";
            print_matrix(temp_B);
            cout << "Output  Matrix .........\n";
            print_matrix(temp_Y);
        }
    }
    high_res_elapsed_time_SW = high_res_elapsed_time;
    printf ("\n");
    cout << ".....................................................\n";
    cout << "SW Execution time =  " <<  high_res_elapsed_time << "s\n";
    cout << "SW THroughput =  " <<  (GLOBAL_DATA_OUT_SIZE_BYTES/high_res_elapsed_time) << " Bytes/s\n";
    if (total_id_error) {
        cout << "TEST UnSucessful! : Total Errors  =  " << total_id_error << endl; 
    } else {
        cout << "TEST Sucessful : Total Errors  =  " << total_id_error << endl; 
    }

    cout << "Gain (SW_time/HW_time)  =  " << (double)(high_res_elapsed_time_SW/high_res_elapsed_time_HW) << endl;
    cout << "Highres  (SW_time)  =  " << (high_res_elapsed_time_SW) << endl;
    printf ("%d :: Software Number of %dx%d floating point Matrix Multiplies per sec = %f \n",(NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_SIZE), DIM, DIM, (NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_SIZE)/high_res_elapsed_time_SW);
    printf ("%d :: Hawdware Number of %dx%d floating point Matrix Multiplies per sec = %f \n",(NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_SIZE), DIM, DIM, (NUMBER_OF_DATA_SETS*SDX_CU_LOCAL_SIZE)/high_res_elapsed_time_HW);

    printf ("-----------------------------------------------------\n");

    cout << "Results verifcation complete " << endl;
    cout << "Total Error = " << total_id_error << endl;

    // ------------ Clean -----------------------
#ifdef LINUX_BUILD
    free(a_in_ptr_c_POSIX);
    free(y_out_ptr_c_POSIX);
#else
    _aligned_free(a_in_ptr_c_WIN32);
    _aligned_free(y_out_ptr_c_WIN32);
#endif
    return 0;
}
