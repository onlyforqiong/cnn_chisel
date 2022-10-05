// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Sun Jul 26 10:32:50 2020
// Host        : DESKTOP-RSCA5E9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               F:/Prj2020/Vivado/NexysA7_fullsystem_rebuild_0725/NexysA7_fullsystem_rebuild_0725.srcs/sources_1/ip/mult_for_cnn_cxy/mult_for_cnn_cxy_sim_netlist.v
// Design      : mult_for_cnn_cxy
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_for_cnn_cxy,mult_gen_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_13,Vivado 2017.4" *) 
(* NotValidForBitStream *)
module mult_for_cnn_cxy
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [31:0]P;

  wire [15:0]A;
  wire [15:0]B;
  wire CLK;
  wire [31:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "31" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_for_cnn_cxy_mult_gen_v12_0_13 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "0" *) (* C_A_WIDTH = "16" *) (* C_B_TYPE = "0" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "16" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "1" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "31" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "mult_gen_v12_0_13" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module mult_for_cnn_cxy_mult_gen_v12_0_13
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [15:0]A;
  input [15:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [31:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [15:0]A;
  wire [15:0]B;
  wire CLK;
  wire [31:0]P;
  wire [47:0]NLW_i_mult_PCASC_UNCONNECTED;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign PCASC[47] = \<const0> ;
  assign PCASC[46] = \<const0> ;
  assign PCASC[45] = \<const0> ;
  assign PCASC[44] = \<const0> ;
  assign PCASC[43] = \<const0> ;
  assign PCASC[42] = \<const0> ;
  assign PCASC[41] = \<const0> ;
  assign PCASC[40] = \<const0> ;
  assign PCASC[39] = \<const0> ;
  assign PCASC[38] = \<const0> ;
  assign PCASC[37] = \<const0> ;
  assign PCASC[36] = \<const0> ;
  assign PCASC[35] = \<const0> ;
  assign PCASC[34] = \<const0> ;
  assign PCASC[33] = \<const0> ;
  assign PCASC[32] = \<const0> ;
  assign PCASC[31] = \<const0> ;
  assign PCASC[30] = \<const0> ;
  assign PCASC[29] = \<const0> ;
  assign PCASC[28] = \<const0> ;
  assign PCASC[27] = \<const0> ;
  assign PCASC[26] = \<const0> ;
  assign PCASC[25] = \<const0> ;
  assign PCASC[24] = \<const0> ;
  assign PCASC[23] = \<const0> ;
  assign PCASC[22] = \<const0> ;
  assign PCASC[21] = \<const0> ;
  assign PCASC[20] = \<const0> ;
  assign PCASC[19] = \<const0> ;
  assign PCASC[18] = \<const0> ;
  assign PCASC[17] = \<const0> ;
  assign PCASC[16] = \<const0> ;
  assign PCASC[15] = \<const0> ;
  assign PCASC[14] = \<const0> ;
  assign PCASC[13] = \<const0> ;
  assign PCASC[12] = \<const0> ;
  assign PCASC[11] = \<const0> ;
  assign PCASC[10] = \<const0> ;
  assign PCASC[9] = \<const0> ;
  assign PCASC[8] = \<const0> ;
  assign PCASC[7] = \<const0> ;
  assign PCASC[6] = \<const0> ;
  assign PCASC[5] = \<const0> ;
  assign PCASC[4] = \<const0> ;
  assign PCASC[3] = \<const0> ;
  assign PCASC[2] = \<const0> ;
  assign PCASC[1] = \<const0> ;
  assign PCASC[0] = \<const0> ;
  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "31" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_for_cnn_cxy_mult_gen_v12_0_13_viv i_mult
       (.A(A),
        .B(B),
        .CE(1'b0),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_i_mult_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
CvmaYyJzAT4gGJRlCkE1yXt5Lv9gJbr2gC0wBzixkhI3TupXRLTg9s4Z9WVWp43QDkUuM3VRZjAj
RVnqESt3JA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
hHyS2uxRkJ6sHR79RwG8dxYfMwySDoNzo0ZpVSoiAp/93R212I5J1LxM+7EujDw/cO/x9djlyxbz
erzC6/tIqQ2nS2hUZANmmER9YkiA1RlXlIqDOWo8pOFHNj1c4jf7Zdq7OJMDPvKF+fLgmk5Lu9Y0
15oIyfQw7L+gXpW1qEU=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Cfhh7YIOGyVJiZpd5j8xa2ugbHZdDDpkNcw6vvVCCgnGCfzlen3wlGk0omzzJqyVapnfg0aPFCVf
eH/noQVGu1bQkowx0JKcNE5x1v5DKH//UNI+lq09SNF0WKlMcTAGlNSUzO8kgVv9uNbKUHDXodcD
5iGh6bHMhVPSu1QKpTfJlIMd2CMz0JfDQiVbfTaAGKvrQhaqVte7pYpnqiXM7povPwt/ntWHBH4s
XSF4J4eDVLMuQmQNy3vrqFdEUqmQFtLWgNRpG2fwo19Y2lRzT3ux5SiA0Iv55uR6x7AG21x8BZlD
JC102ufirdrREfWUzlClY8zmr+TUHpTF/SgPMw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UWceDgHVHZAg17Yudaw03bncVn75AJ6y0RYlYeqdZU3kMG9E1W6q5REaQAI7sMZSrC2g0zavsx4w
utskoq80P2avoebtdvBfjr/nBCQqUN3AvM3GSk85froboZgk4fCQ8UtEj2Qk7ob+ox/md7d9P9dw
2YULi+eG04dUc1g45wwF0ZoZdARk7Ml+fXMnm7zxmvqVieAEsVq6ETZN/P0pwvIpAakLTayKriGC
qcrb1S28bOuV+Na/FX9rxN6hM5aK7vSdFqja5GGs32r9UVRIkX6i7uqS9pWQDR0Qa31W3z6wrRrT
+2wzEwNMDKYuWVIM1FQo/Tp0NKa1Y+kyjahSGA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
tLsJPLnIUk5FSxPTGLkNhAFldHrP7oFH8h39nfqyEmnC/AmGzR3fePfCEcee3I4TYySABpWhyXIf
m1jGiCuHfIpFkF2EJqjWmBev0bD33cbw1av2xtJRFa5gaQjxChO9URfjedFvCQWWwjlxejc9nD0N
O0V2XUDQxd573YmSBuByzshlxt3bujEd6Xeeb8N8NI8c2ZsfY4693LGdb3k6gtY9ZEoo4XuYVt6n
S2tNFVJTfQjyBEXbuCPqpwGf6bPdy2SKvTE/s4rSIVTO08J6bXDaEOBUGg13XVoJJqrayiJRVuQL
LhoiPzgOqS6ude1uUaMHE/SN9X/vt/6uOsOl2w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
jgk19ieS+ZYiySHKvgAHMus0OAx0HPJ59p64LMaYK8CyW0wSM8LIn++sFz9tsOBdLj2gb8IKpSVr
SOX9XXXM2pQFSME7x8q0m+EPg9m1+ghIpW4bU/w4zVq4NBjYydZCI0Hpy+X3op0a3+eENVEw5SoK
4R/zOL7aV/2nZ//wkaw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L/BPRr/PHH5da1O06dKRr5ST8eskM6lzR1UPuTvZQ6RCsFEjTD1HgyqjW7/ypnIq7V5TYDC553+Y
rJnEENzDc6RSpzenrYxw7NrURpUedIWlCc/PEf5Zq9gu1ESkpND7t98rc+uiAz7zsn/pHD/K50NR
q9l/gcWkOCgArmADo1Lw9usrfZ8ECIPKY2kLxeTYbh4fsrCpPQsQUk4NxX3N1Q0h3RRUCdHSFc0O
lvGip/vd24OK8zXDMaQv4fPmgToFQMUvLrJXErEUeRlkpxkcX6g6Zu4RMWwwmkNIfZHpc5K8Q3RL
MMc5rARUSXbNbpf28H3iyAMZ0y+EgI0CrKwooA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
iEk5o0rtKxFV7BsF/d8Bawt0jM42rzGflNR2jo3eL0pSC8jap/cE+Dg3nXNpv+FxjhwqNybrDhAA
k0Xhr9dTt5meNWRHLpFjLgeyk0Y3OGw/QiMKiXoKaX0dIujdL75SeVebKIGiZQWGYUxe1W/2c2nA
owcrJPIGTXLzG8XibXfh4ii3IwKE9cKSLwobZ0SfGk0ows/94bu674gH/ZGTBNc6UcC+zA53lrzf
tBF9auF46yR+ULMKrj14zejOPsO8RLH8Q6HQhLGpMPg/J5149Kn9sk4e2CvHCyU/nUcTIEKtLIAk
I4PVybnANvopB8H0xFEKWTdYrBJLKvm/8moPzw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ZmfgkWe1IByJZweJzBfXrLc0i6OFZ/xTPQ/z+Yr5yTt9dNDzYfGMfvY0mXWaopoMsLvXVnDm5rfx
2LopnO/+DdxcuagSBf7crYI0C4FXPGtNz7KCg7THP+3slgZ/ZDZsvP6MKiMTa3+En3df5zQpsPQf
sSl8MZkU1GwmHhmk8AN02YUakAehlB59Zs39i15OISf7rrNToERoYNunDJAoSGgT5BkI6GPhMoRS
yZr7Z1YcEHOhvDqHuIZkiyDhri8u8JprIHNFUM8b1uTYbXVQso3Ftg3v6JqVV1DU/6hiiYpt06ta
9nAFUUfbrjScuFESii1dU1mhQKXONYA549GKYQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7248)
`pragma protect data_block
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
9yxIuHkEVPNo
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
