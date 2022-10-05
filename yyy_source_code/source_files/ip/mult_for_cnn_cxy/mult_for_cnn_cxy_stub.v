// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Sun Jul 26 10:32:50 2020
// Host        : DESKTOP-RSCA5E9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               F:/Prj2020/Vivado/NexysA7_fullsystem_rebuild_0725/NexysA7_fullsystem_rebuild_0725.srcs/sources_1/ip/mult_for_cnn_cxy/mult_for_cnn_cxy_stub.v
// Design      : mult_for_cnn_cxy
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mult_gen_v12_0_13,Vivado 2017.4" *)
module mult_for_cnn_cxy(CLK, A, B, P)
/* synthesis syn_black_box black_box_pad_pin="CLK,A[15:0],B[15:0],P[31:0]" */;
  input CLK;
  input [15:0]A;
  input [15:0]B;
  output [31:0]P;
endmodule
