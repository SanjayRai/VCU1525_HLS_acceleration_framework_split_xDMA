-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
-- Date        : Tue Jul 16 16:30:11 2019
-- Host        : mc32gblnx running 64-bit CentOS Linux release 7.6.1810 (Core)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/sanjayr/projects/temp/VCU1525_HLS_acceleration_framework_split_xDMA/IP/shell/PCIe_Bridge_ICAP_complex/PCIe_Bridge_ICAP_complex_stub.vhdl
-- Design      : PCIe_Bridge_ICAP_complex
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcvu9p-fsgd2104-2-i
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PCIe_Bridge_ICAP_complex is
  Port ( 
    C1_SYS_CLK_clk_n : in STD_LOGIC;
    C1_SYS_CLK_clk_p : in STD_LOGIC;
    DDR4_sys_rst : in STD_LOGIC;
    M_AXI_LITE_TO_HLS_PR_NORTH_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_LITE_TO_HLS_PR_NORTH_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_LITE_TO_HLS_PR_NORTH_arready : in STD_LOGIC;
    M_AXI_LITE_TO_HLS_PR_NORTH_arvalid : out STD_LOGIC;
    M_AXI_LITE_TO_HLS_PR_NORTH_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_LITE_TO_HLS_PR_NORTH_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_LITE_TO_HLS_PR_NORTH_awready : in STD_LOGIC;
    M_AXI_LITE_TO_HLS_PR_NORTH_awvalid : out STD_LOGIC;
    M_AXI_LITE_TO_HLS_PR_NORTH_bready : out STD_LOGIC;
    M_AXI_LITE_TO_HLS_PR_NORTH_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_LITE_TO_HLS_PR_NORTH_bvalid : in STD_LOGIC;
    M_AXI_LITE_TO_HLS_PR_NORTH_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_LITE_TO_HLS_PR_NORTH_rready : out STD_LOGIC;
    M_AXI_LITE_TO_HLS_PR_NORTH_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_LITE_TO_HLS_PR_NORTH_rvalid : in STD_LOGIC;
    M_AXI_LITE_TO_HLS_PR_NORTH_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_LITE_TO_HLS_PR_NORTH_wready : in STD_LOGIC;
    M_AXI_LITE_TO_HLS_PR_NORTH_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_LITE_TO_HLS_PR_NORTH_wvalid : out STD_LOGIC;
    M_AXI_MM_TO_HLS_PR_NORTH_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_arid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_arready : in STD_LOGIC;
    M_AXI_MM_TO_HLS_PR_NORTH_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_arvalid : out STD_LOGIC;
    M_AXI_MM_TO_HLS_PR_NORTH_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_awid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_awready : in STD_LOGIC;
    M_AXI_MM_TO_HLS_PR_NORTH_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_awvalid : out STD_LOGIC;
    M_AXI_MM_TO_HLS_PR_NORTH_bid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_bready : out STD_LOGIC;
    M_AXI_MM_TO_HLS_PR_NORTH_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_bvalid : in STD_LOGIC;
    M_AXI_MM_TO_HLS_PR_NORTH_rdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_rid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_rlast : in STD_LOGIC;
    M_AXI_MM_TO_HLS_PR_NORTH_rready : out STD_LOGIC;
    M_AXI_MM_TO_HLS_PR_NORTH_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_rvalid : in STD_LOGIC;
    M_AXI_MM_TO_HLS_PR_NORTH_wdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_wlast : out STD_LOGIC;
    M_AXI_MM_TO_HLS_PR_NORTH_wready : in STD_LOGIC;
    M_AXI_MM_TO_HLS_PR_NORTH_wstrb : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXI_MM_TO_HLS_PR_NORTH_wvalid : out STD_LOGIC;
    S_AXI_MM_FROM_HLS_PR_NORTH_araddr : in STD_LOGIC_VECTOR ( 63 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_arid : in STD_LOGIC_VECTOR ( 4 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_arready : out STD_LOGIC;
    S_AXI_MM_FROM_HLS_PR_NORTH_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_arvalid : in STD_LOGIC;
    S_AXI_MM_FROM_HLS_PR_NORTH_awaddr : in STD_LOGIC_VECTOR ( 63 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_awid : in STD_LOGIC_VECTOR ( 4 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_awready : out STD_LOGIC;
    S_AXI_MM_FROM_HLS_PR_NORTH_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_awvalid : in STD_LOGIC;
    S_AXI_MM_FROM_HLS_PR_NORTH_bid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_bready : in STD_LOGIC;
    S_AXI_MM_FROM_HLS_PR_NORTH_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_bvalid : out STD_LOGIC;
    S_AXI_MM_FROM_HLS_PR_NORTH_rdata : out STD_LOGIC_VECTOR ( 511 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_rid : out STD_LOGIC_VECTOR ( 4 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_rlast : out STD_LOGIC;
    S_AXI_MM_FROM_HLS_PR_NORTH_rready : in STD_LOGIC;
    S_AXI_MM_FROM_HLS_PR_NORTH_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_rvalid : out STD_LOGIC;
    S_AXI_MM_FROM_HLS_PR_NORTH_wdata : in STD_LOGIC_VECTOR ( 511 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_wlast : in STD_LOGIC;
    S_AXI_MM_FROM_HLS_PR_NORTH_wready : out STD_LOGIC;
    S_AXI_MM_FROM_HLS_PR_NORTH_wstrb : in STD_LOGIC_VECTOR ( 63 downto 0 );
    S_AXI_MM_FROM_HLS_PR_NORTH_wvalid : in STD_LOGIC;
    axi_reset_n_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    c1_ddr4_act_n : out STD_LOGIC;
    c1_ddr4_adr : out STD_LOGIC_VECTOR ( 16 downto 0 );
    c1_ddr4_ba : out STD_LOGIC_VECTOR ( 1 downto 0 );
    c1_ddr4_bg : out STD_LOGIC_VECTOR ( 1 downto 0 );
    c1_ddr4_ck_c : out STD_LOGIC_VECTOR ( 0 to 0 );
    c1_ddr4_ck_t : out STD_LOGIC_VECTOR ( 0 to 0 );
    c1_ddr4_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    c1_ddr4_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    c1_ddr4_dq : inout STD_LOGIC_VECTOR ( 71 downto 0 );
    c1_ddr4_dqs_c : inout STD_LOGIC_VECTOR ( 17 downto 0 );
    c1_ddr4_dqs_t : inout STD_LOGIC_VECTOR ( 17 downto 0 );
    c1_ddr4_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    c1_ddr4_par : out STD_LOGIC;
    c1_ddr4_reset_n : out STD_LOGIC;
    c1_init_calib_complete : out STD_LOGIC;
    clk_out_125M : out STD_LOGIC;
    clk_out_250M : out STD_LOGIC;
    clk_out_PROG : out STD_LOGIC;
    clk_out_PROG_locked : out STD_LOGIC;
    ker_active_count_L : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ker_active_count_U : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pcie_mgt_rxn : in STD_LOGIC_VECTOR ( 15 downto 0 );
    pcie_mgt_rxp : in STD_LOGIC_VECTOR ( 15 downto 0 );
    pcie_mgt_txn : out STD_LOGIC_VECTOR ( 15 downto 0 );
    pcie_mgt_txp : out STD_LOGIC_VECTOR ( 15 downto 0 );
    status_gpio_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    sys_clk : in STD_LOGIC;
    sys_clk_gt : in STD_LOGIC;
    sys_rst_n : in STD_LOGIC
  );

end PCIe_Bridge_ICAP_complex;

architecture stub of PCIe_Bridge_ICAP_complex is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "C1_SYS_CLK_clk_n,C1_SYS_CLK_clk_p,DDR4_sys_rst,M_AXI_LITE_TO_HLS_PR_NORTH_araddr[31:0],M_AXI_LITE_TO_HLS_PR_NORTH_arprot[2:0],M_AXI_LITE_TO_HLS_PR_NORTH_arready,M_AXI_LITE_TO_HLS_PR_NORTH_arvalid,M_AXI_LITE_TO_HLS_PR_NORTH_awaddr[31:0],M_AXI_LITE_TO_HLS_PR_NORTH_awprot[2:0],M_AXI_LITE_TO_HLS_PR_NORTH_awready,M_AXI_LITE_TO_HLS_PR_NORTH_awvalid,M_AXI_LITE_TO_HLS_PR_NORTH_bready,M_AXI_LITE_TO_HLS_PR_NORTH_bresp[1:0],M_AXI_LITE_TO_HLS_PR_NORTH_bvalid,M_AXI_LITE_TO_HLS_PR_NORTH_rdata[31:0],M_AXI_LITE_TO_HLS_PR_NORTH_rready,M_AXI_LITE_TO_HLS_PR_NORTH_rresp[1:0],M_AXI_LITE_TO_HLS_PR_NORTH_rvalid,M_AXI_LITE_TO_HLS_PR_NORTH_wdata[31:0],M_AXI_LITE_TO_HLS_PR_NORTH_wready,M_AXI_LITE_TO_HLS_PR_NORTH_wstrb[3:0],M_AXI_LITE_TO_HLS_PR_NORTH_wvalid,M_AXI_MM_TO_HLS_PR_NORTH_araddr[63:0],M_AXI_MM_TO_HLS_PR_NORTH_arburst[1:0],M_AXI_MM_TO_HLS_PR_NORTH_arcache[3:0],M_AXI_MM_TO_HLS_PR_NORTH_arid[3:0],M_AXI_MM_TO_HLS_PR_NORTH_arlen[7:0],M_AXI_MM_TO_HLS_PR_NORTH_arlock[0:0],M_AXI_MM_TO_HLS_PR_NORTH_arprot[2:0],M_AXI_MM_TO_HLS_PR_NORTH_arqos[3:0],M_AXI_MM_TO_HLS_PR_NORTH_arready,M_AXI_MM_TO_HLS_PR_NORTH_arregion[3:0],M_AXI_MM_TO_HLS_PR_NORTH_arsize[2:0],M_AXI_MM_TO_HLS_PR_NORTH_arvalid,M_AXI_MM_TO_HLS_PR_NORTH_awaddr[63:0],M_AXI_MM_TO_HLS_PR_NORTH_awburst[1:0],M_AXI_MM_TO_HLS_PR_NORTH_awcache[3:0],M_AXI_MM_TO_HLS_PR_NORTH_awid[3:0],M_AXI_MM_TO_HLS_PR_NORTH_awlen[7:0],M_AXI_MM_TO_HLS_PR_NORTH_awlock[0:0],M_AXI_MM_TO_HLS_PR_NORTH_awprot[2:0],M_AXI_MM_TO_HLS_PR_NORTH_awqos[3:0],M_AXI_MM_TO_HLS_PR_NORTH_awready,M_AXI_MM_TO_HLS_PR_NORTH_awregion[3:0],M_AXI_MM_TO_HLS_PR_NORTH_awsize[2:0],M_AXI_MM_TO_HLS_PR_NORTH_awvalid,M_AXI_MM_TO_HLS_PR_NORTH_bid[3:0],M_AXI_MM_TO_HLS_PR_NORTH_bready,M_AXI_MM_TO_HLS_PR_NORTH_bresp[1:0],M_AXI_MM_TO_HLS_PR_NORTH_bvalid,M_AXI_MM_TO_HLS_PR_NORTH_rdata[511:0],M_AXI_MM_TO_HLS_PR_NORTH_rid[3:0],M_AXI_MM_TO_HLS_PR_NORTH_rlast,M_AXI_MM_TO_HLS_PR_NORTH_rready,M_AXI_MM_TO_HLS_PR_NORTH_rresp[1:0],M_AXI_MM_TO_HLS_PR_NORTH_rvalid,M_AXI_MM_TO_HLS_PR_NORTH_wdata[511:0],M_AXI_MM_TO_HLS_PR_NORTH_wlast,M_AXI_MM_TO_HLS_PR_NORTH_wready,M_AXI_MM_TO_HLS_PR_NORTH_wstrb[63:0],M_AXI_MM_TO_HLS_PR_NORTH_wvalid,S_AXI_MM_FROM_HLS_PR_NORTH_araddr[63:0],S_AXI_MM_FROM_HLS_PR_NORTH_arburst[1:0],S_AXI_MM_FROM_HLS_PR_NORTH_arcache[3:0],S_AXI_MM_FROM_HLS_PR_NORTH_arid[4:0],S_AXI_MM_FROM_HLS_PR_NORTH_arlen[7:0],S_AXI_MM_FROM_HLS_PR_NORTH_arlock[0:0],S_AXI_MM_FROM_HLS_PR_NORTH_arprot[2:0],S_AXI_MM_FROM_HLS_PR_NORTH_arqos[3:0],S_AXI_MM_FROM_HLS_PR_NORTH_arready,S_AXI_MM_FROM_HLS_PR_NORTH_arregion[3:0],S_AXI_MM_FROM_HLS_PR_NORTH_arsize[2:0],S_AXI_MM_FROM_HLS_PR_NORTH_arvalid,S_AXI_MM_FROM_HLS_PR_NORTH_awaddr[63:0],S_AXI_MM_FROM_HLS_PR_NORTH_awburst[1:0],S_AXI_MM_FROM_HLS_PR_NORTH_awcache[3:0],S_AXI_MM_FROM_HLS_PR_NORTH_awid[4:0],S_AXI_MM_FROM_HLS_PR_NORTH_awlen[7:0],S_AXI_MM_FROM_HLS_PR_NORTH_awlock[0:0],S_AXI_MM_FROM_HLS_PR_NORTH_awprot[2:0],S_AXI_MM_FROM_HLS_PR_NORTH_awqos[3:0],S_AXI_MM_FROM_HLS_PR_NORTH_awready,S_AXI_MM_FROM_HLS_PR_NORTH_awregion[3:0],S_AXI_MM_FROM_HLS_PR_NORTH_awsize[2:0],S_AXI_MM_FROM_HLS_PR_NORTH_awvalid,S_AXI_MM_FROM_HLS_PR_NORTH_bid[4:0],S_AXI_MM_FROM_HLS_PR_NORTH_bready,S_AXI_MM_FROM_HLS_PR_NORTH_bresp[1:0],S_AXI_MM_FROM_HLS_PR_NORTH_bvalid,S_AXI_MM_FROM_HLS_PR_NORTH_rdata[511:0],S_AXI_MM_FROM_HLS_PR_NORTH_rid[4:0],S_AXI_MM_FROM_HLS_PR_NORTH_rlast,S_AXI_MM_FROM_HLS_PR_NORTH_rready,S_AXI_MM_FROM_HLS_PR_NORTH_rresp[1:0],S_AXI_MM_FROM_HLS_PR_NORTH_rvalid,S_AXI_MM_FROM_HLS_PR_NORTH_wdata[511:0],S_AXI_MM_FROM_HLS_PR_NORTH_wlast,S_AXI_MM_FROM_HLS_PR_NORTH_wready,S_AXI_MM_FROM_HLS_PR_NORTH_wstrb[63:0],S_AXI_MM_FROM_HLS_PR_NORTH_wvalid,axi_reset_n_out[0:0],c1_ddr4_act_n,c1_ddr4_adr[16:0],c1_ddr4_ba[1:0],c1_ddr4_bg[1:0],c1_ddr4_ck_c[0:0],c1_ddr4_ck_t[0:0],c1_ddr4_cke[0:0],c1_ddr4_cs_n[0:0],c1_ddr4_dq[71:0],c1_ddr4_dqs_c[17:0],c1_ddr4_dqs_t[17:0],c1_ddr4_odt[0:0],c1_ddr4_par,c1_ddr4_reset_n,c1_init_calib_complete,clk_out_125M,clk_out_250M,clk_out_PROG,clk_out_PROG_locked,ker_active_count_L[31:0],ker_active_count_U[31:0],pcie_mgt_rxn[15:0],pcie_mgt_rxp[15:0],pcie_mgt_txn[15:0],pcie_mgt_txp[15:0],status_gpio_in[7:0],sys_clk,sys_clk_gt,sys_rst_n";
begin
end;
