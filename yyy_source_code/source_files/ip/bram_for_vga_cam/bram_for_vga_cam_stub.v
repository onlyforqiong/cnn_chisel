// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Thu May 21 16:18:57 2020
// Host        : DESKTOP-RSCA5E9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               F:/Prj2020/Vivado/NexysA7_full_system_0521/NexysA7_full_system_0521.srcs/sources_1/ip/bram_for_vga_cam/bram_for_vga_cam_stub.v
// Design      : bram_for_vga_cam
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2017.4" *)
module bram_for_vga_cam(clka, ena, wea, addra, dina, douta, clkb, enb, web, addrb, 
  dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[11:0],dina[0:0],douta[0:0],clkb,enb,web[0:0],addrb[11:0],dinb[0:0],doutb[0:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [11:0]addra;
  input [0:0]dina;
  output [0:0]douta;
  input clkb;
  input enb;
  input [0:0]web;
  input [11:0]addrb;
  input [0:0]dinb;
  output [0:0]doutb;
endmodule
