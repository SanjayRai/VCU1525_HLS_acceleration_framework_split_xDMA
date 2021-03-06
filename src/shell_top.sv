// Sanjay Rai (sanjay.d.rai@gmail.com)
//
`timescale 1 ps / 1 ps

module shell_top (
  input C1_SYS_CLK_clk_n,
  input C1_SYS_CLK_clk_p,
  input DDR4_sys_rst,
  srai_accel_AXI_LITE_intfc.master M_AXI_LITE_TO_HLS_PR_NORTH, 
  srai_accel_AXI_MM_intfc.slave S_AXI_MM_FROM_HLS_PR_NORTH, 
  srai_accel_AXI_MM_intfc.master M_AXI_MM_TO_HLS_PR_NORTH,
  output axi_reset_n_out,
  output c1_ddr4_act_n,
  output [16:0]c1_ddr4_adr,
  output [1:0]c1_ddr4_ba,
  output [1:0]c1_ddr4_bg,
  output [0:0]c1_ddr4_ck_c,
  output [0:0]c1_ddr4_ck_t,
  output [0:0]c1_ddr4_cke,
  output [0:0]c1_ddr4_cs_n,
  inout [71:0]c1_ddr4_dq,
  inout [17:0]c1_ddr4_dqs_c,
  inout [17:0]c1_ddr4_dqs_t,
  output [0:0]c1_ddr4_odt,
  output c1_ddr4_par,
  output c1_ddr4_reset_n,
  output clk_out_125M,
  output clk_out_250M,
  output clk_out_PROG,
  input [31:0]ker_count,
  input ker_count_ap_vld,
  input c0_init_calib_complete,
  input c2_init_calib_complete,
  input c3_init_calib_complete,
  input [15:0]pcie_mgt_rxn,
  input [15:0]pcie_mgt_rxp,
  output [15:0]pcie_mgt_txn,
  output [15:0]pcie_mgt_txp,
  input sys_clk,
  input sys_clk_gt,
  input sys_rst_n);

  reg [32:0] kernel_active_count_reg = 32'd0;
  reg [32:0] kernel_active_clock_count = 32'd0;
  reg [32:0] ker_active_time = 32'd0;
  wire [7:0]status_gpio_in;

  PCIe_Bridge_ICAP_complex PCIe_Bridge_ICAP_complex_i (
        .C1_SYS_CLK_clk_n(C1_SYS_CLK_clk_n),
        .C1_SYS_CLK_clk_p(C1_SYS_CLK_clk_p),
        .DDR4_sys_rst(DDR4_sys_rst),
        .M_AXI_LITE_TO_HLS_PR_NORTH_araddr(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_araddr),
        .M_AXI_LITE_TO_HLS_PR_NORTH_arprot(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_arprot),
        .M_AXI_LITE_TO_HLS_PR_NORTH_arready(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_arready),
        .M_AXI_LITE_TO_HLS_PR_NORTH_arvalid(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_arvalid),
        .M_AXI_LITE_TO_HLS_PR_NORTH_awaddr(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_awaddr),
        .M_AXI_LITE_TO_HLS_PR_NORTH_awprot(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_awprot),
        .M_AXI_LITE_TO_HLS_PR_NORTH_awready(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_awready),
        .M_AXI_LITE_TO_HLS_PR_NORTH_awvalid(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_awvalid),
        .M_AXI_LITE_TO_HLS_PR_NORTH_bready(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_bready),
        .M_AXI_LITE_TO_HLS_PR_NORTH_bresp(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_bresp),
        .M_AXI_LITE_TO_HLS_PR_NORTH_bvalid(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_bvalid),
        .M_AXI_LITE_TO_HLS_PR_NORTH_rdata(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_rdata),
        .M_AXI_LITE_TO_HLS_PR_NORTH_rready(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_rready),
        .M_AXI_LITE_TO_HLS_PR_NORTH_rresp(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_rresp),
        .M_AXI_LITE_TO_HLS_PR_NORTH_rvalid(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_rvalid),
        .M_AXI_LITE_TO_HLS_PR_NORTH_wdata(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_wdata),
        .M_AXI_LITE_TO_HLS_PR_NORTH_wready(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_wready),
        .M_AXI_LITE_TO_HLS_PR_NORTH_wstrb(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_wstrb),
        .M_AXI_LITE_TO_HLS_PR_NORTH_wvalid(M_AXI_LITE_TO_HLS_PR_NORTH.AXI_LITE_wvalid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_araddr(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_araddr),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arburst(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_arburst),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arcache(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_arcache),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arid(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_arid[4:0]),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arlen(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_arlen),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arlock(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_arlock),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arprot(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_arprot),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arqos(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_arqos),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arready(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_arready),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arregion(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_arregion),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arsize(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_arsize),
        .S_AXI_MM_FROM_HLS_PR_NORTH_arvalid(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_arvalid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awaddr(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_awaddr),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awburst(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_awburst),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awcache(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_awcache),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awid(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_awid[4:0]),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awlen(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_awlen),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awlock(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_awlock),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awprot(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_awprot),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awqos(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_awqos),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awready(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_awready),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awregion(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_awregion),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awsize(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_awsize),
        .S_AXI_MM_FROM_HLS_PR_NORTH_awvalid(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_awvalid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_bid(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_bid[4:0]),
        .S_AXI_MM_FROM_HLS_PR_NORTH_bready(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_bready),
        .S_AXI_MM_FROM_HLS_PR_NORTH_bresp(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_bresp),
        .S_AXI_MM_FROM_HLS_PR_NORTH_bvalid(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_bvalid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_rdata(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_rdata),
        .S_AXI_MM_FROM_HLS_PR_NORTH_rid(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_rid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_rlast(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_rlast),
        .S_AXI_MM_FROM_HLS_PR_NORTH_rready(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_rready),
        .S_AXI_MM_FROM_HLS_PR_NORTH_rresp(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_rresp),
        .S_AXI_MM_FROM_HLS_PR_NORTH_rvalid(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_rvalid),
        .S_AXI_MM_FROM_HLS_PR_NORTH_wdata(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_wdata),
        .S_AXI_MM_FROM_HLS_PR_NORTH_wlast(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_wlast),
        .S_AXI_MM_FROM_HLS_PR_NORTH_wready(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_wready),
        .S_AXI_MM_FROM_HLS_PR_NORTH_wstrb(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_wstrb),
        .S_AXI_MM_FROM_HLS_PR_NORTH_wvalid(S_AXI_MM_FROM_HLS_PR_NORTH.AXI_wvalid),
        .M_AXI_MM_TO_HLS_PR_NORTH_araddr(M_AXI_MM_TO_HLS_PR_NORTH.AXI_araddr),
        .M_AXI_MM_TO_HLS_PR_NORTH_arburst(M_AXI_MM_TO_HLS_PR_NORTH.AXI_arburst),
        .M_AXI_MM_TO_HLS_PR_NORTH_arcache(M_AXI_MM_TO_HLS_PR_NORTH.AXI_arcache),
        .M_AXI_MM_TO_HLS_PR_NORTH_arid(M_AXI_MM_TO_HLS_PR_NORTH.AXI_arid),
        .M_AXI_MM_TO_HLS_PR_NORTH_arlen(M_AXI_MM_TO_HLS_PR_NORTH.AXI_arlen),
        .M_AXI_MM_TO_HLS_PR_NORTH_arlock(M_AXI_MM_TO_HLS_PR_NORTH.AXI_arlock),
        .M_AXI_MM_TO_HLS_PR_NORTH_arprot(M_AXI_MM_TO_HLS_PR_NORTH.AXI_arprot),
        .M_AXI_MM_TO_HLS_PR_NORTH_arqos(M_AXI_MM_TO_HLS_PR_NORTH.AXI_arqos),
        .M_AXI_MM_TO_HLS_PR_NORTH_arready(M_AXI_MM_TO_HLS_PR_NORTH.AXI_arready),
        .M_AXI_MM_TO_HLS_PR_NORTH_arregion(M_AXI_MM_TO_HLS_PR_NORTH.AXI_arregion),
        .M_AXI_MM_TO_HLS_PR_NORTH_arsize(M_AXI_MM_TO_HLS_PR_NORTH.AXI_arsize),
        .M_AXI_MM_TO_HLS_PR_NORTH_arvalid(M_AXI_MM_TO_HLS_PR_NORTH.AXI_arvalid),
        .M_AXI_MM_TO_HLS_PR_NORTH_awaddr(M_AXI_MM_TO_HLS_PR_NORTH.AXI_awaddr),
        .M_AXI_MM_TO_HLS_PR_NORTH_awburst(M_AXI_MM_TO_HLS_PR_NORTH.AXI_awburst),
        .M_AXI_MM_TO_HLS_PR_NORTH_awcache(M_AXI_MM_TO_HLS_PR_NORTH.AXI_awcache),
        .M_AXI_MM_TO_HLS_PR_NORTH_awid(M_AXI_MM_TO_HLS_PR_NORTH.AXI_awid),
        .M_AXI_MM_TO_HLS_PR_NORTH_awlen(M_AXI_MM_TO_HLS_PR_NORTH.AXI_awlen),
        .M_AXI_MM_TO_HLS_PR_NORTH_awlock(M_AXI_MM_TO_HLS_PR_NORTH.AXI_awlock),
        .M_AXI_MM_TO_HLS_PR_NORTH_awprot(M_AXI_MM_TO_HLS_PR_NORTH.AXI_awprot),
        .M_AXI_MM_TO_HLS_PR_NORTH_awqos(M_AXI_MM_TO_HLS_PR_NORTH.AXI_awqos),
        .M_AXI_MM_TO_HLS_PR_NORTH_awready(M_AXI_MM_TO_HLS_PR_NORTH.AXI_awready),
        .M_AXI_MM_TO_HLS_PR_NORTH_awregion(M_AXI_MM_TO_HLS_PR_NORTH.AXI_awregion),
        .M_AXI_MM_TO_HLS_PR_NORTH_awsize(M_AXI_MM_TO_HLS_PR_NORTH.AXI_awsize),
        .M_AXI_MM_TO_HLS_PR_NORTH_awvalid(M_AXI_MM_TO_HLS_PR_NORTH.AXI_awvalid),
        .M_AXI_MM_TO_HLS_PR_NORTH_bid(M_AXI_MM_TO_HLS_PR_NORTH.AXI_bid),
        .M_AXI_MM_TO_HLS_PR_NORTH_bready(M_AXI_MM_TO_HLS_PR_NORTH.AXI_bready),
        .M_AXI_MM_TO_HLS_PR_NORTH_bresp(M_AXI_MM_TO_HLS_PR_NORTH.AXI_bresp),
        .M_AXI_MM_TO_HLS_PR_NORTH_bvalid(M_AXI_MM_TO_HLS_PR_NORTH.AXI_bvalid),
        .M_AXI_MM_TO_HLS_PR_NORTH_rdata(M_AXI_MM_TO_HLS_PR_NORTH.AXI_rdata),
        .M_AXI_MM_TO_HLS_PR_NORTH_rid(M_AXI_MM_TO_HLS_PR_NORTH.AXI_rid),
        .M_AXI_MM_TO_HLS_PR_NORTH_rlast(M_AXI_MM_TO_HLS_PR_NORTH.AXI_rlast),
        .M_AXI_MM_TO_HLS_PR_NORTH_rready(M_AXI_MM_TO_HLS_PR_NORTH.AXI_rready),
        .M_AXI_MM_TO_HLS_PR_NORTH_rresp(M_AXI_MM_TO_HLS_PR_NORTH.AXI_rresp),
        .M_AXI_MM_TO_HLS_PR_NORTH_rvalid(M_AXI_MM_TO_HLS_PR_NORTH.AXI_rvalid),
        .M_AXI_MM_TO_HLS_PR_NORTH_wdata(M_AXI_MM_TO_HLS_PR_NORTH.AXI_wdata),
        .M_AXI_MM_TO_HLS_PR_NORTH_wlast(M_AXI_MM_TO_HLS_PR_NORTH.AXI_wlast),
        .M_AXI_MM_TO_HLS_PR_NORTH_wready(M_AXI_MM_TO_HLS_PR_NORTH.AXI_wready),
        .M_AXI_MM_TO_HLS_PR_NORTH_wstrb(M_AXI_MM_TO_HLS_PR_NORTH.AXI_wstrb),
        .M_AXI_MM_TO_HLS_PR_NORTH_wvalid(M_AXI_MM_TO_HLS_PR_NORTH.AXI_wvalid),
        .axi_reset_n_out(axi_reset_n_out),
        .c1_ddr4_act_n(c1_ddr4_act_n),
        .c1_ddr4_adr(c1_ddr4_adr),
        .c1_ddr4_ba(c1_ddr4_ba),
        .c1_ddr4_bg(c1_ddr4_bg),
        .c1_ddr4_ck_c(c1_ddr4_ck_c),
        .c1_ddr4_ck_t(c1_ddr4_ck_t),
        .c1_ddr4_cke(c1_ddr4_cke),
        .c1_ddr4_cs_n(c1_ddr4_cs_n),
        .c1_ddr4_par(c1_ddr4_par),
        .c1_ddr4_dq(c1_ddr4_dq),
        .c1_ddr4_dqs_c(c1_ddr4_dqs_c),
        .c1_ddr4_dqs_t(c1_ddr4_dqs_t),
        .c1_ddr4_odt(c1_ddr4_odt),
        .c1_ddr4_reset_n(c1_ddr4_reset_n),
        .c1_init_calib_complete(c1_init_calib_complete),
        .clk_out_125M(clk_out_125M),
        .clk_out_250M(clk_out_250M),
        .clk_out_PROG(clk_out_PROG),
        .clk_out_PROG_locked(clk_out_PROG_locked),
        .ker_active_count_L(kernel_active_count_reg),
        .ker_active_count_U(kernel_active_clock_count),
        .pcie_mgt_rxn(pcie_mgt_rxn),
        .pcie_mgt_rxp(pcie_mgt_rxp),
        .pcie_mgt_txn(pcie_mgt_txn),
        .pcie_mgt_txp(pcie_mgt_txp),
        .status_gpio_in(status_gpio_in),
        .sys_clk(sys_clk),
        .sys_clk_gt(sys_clk_gt),
        .sys_rst_n(sys_rst_n));

    assign status_gpio_in = {3'b000, clk_out_PROG_locked, c0_init_calib_complete, c1_init_calib_complete, c2_init_calib_complete, c3_init_calib_complete};


 
ila_ker_count U_ila_ker_count (
	.clk(clk_out_PROG), // input wire clk
	.probe0({ker_active_time, ker_count}) // input wire [63:0] probe0
);


always @ (posedge clk_out_PROG) begin
    if (ker_count_ap_vld) begin
        kernel_active_count_reg <= ker_count;
        if (ker_count == 32'd0) begin
            kernel_active_clock_count <= 32'd0;
            ker_active_time <= 32'd0;
        end else begin 
            kernel_active_clock_count <= ker_active_time;
        end
    end else begin
            ker_active_time <= ker_active_time + 1'b1 ; 
    end
end
 
endmodule
