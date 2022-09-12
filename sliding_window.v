module matrix_bundle_cross_bar(
  input  [15:0] io_matrix_input_matrix_port_0,
  input  [15:0] io_matrix_input_matrix_port_1,
  input  [15:0] io_matrix_input_matrix_port_2,
  input  [15:0] io_matrix_input_matrix_port_3,
  input  [15:0] io_matrix_input_matrix_port_4,
  input  [15:0] io_matrix_input_matrix_port_5,
  input  [15:0] io_matrix_input_matrix_port_6,
  input  [15:0] io_matrix_input_matrix_port_7,
  input  [15:0] io_matrix_input_matrix_port_8,
  output [15:0] io_matrix_output_matrix_port_0,
  output [15:0] io_matrix_output_matrix_port_1,
  output [15:0] io_matrix_output_matrix_port_2,
  output [15:0] io_matrix_output_matrix_port_3,
  output [15:0] io_matrix_output_matrix_port_4,
  output [15:0] io_matrix_output_matrix_port_5,
  output [15:0] io_matrix_output_matrix_port_6,
  output [15:0] io_matrix_output_matrix_port_7,
  output [15:0] io_matrix_output_matrix_port_8
);
  assign io_matrix_output_matrix_port_0 = io_matrix_input_matrix_port_0; // @[basic_macro.scala 63:26]
  assign io_matrix_output_matrix_port_1 = io_matrix_input_matrix_port_1; // @[basic_macro.scala 63:26]
  assign io_matrix_output_matrix_port_2 = io_matrix_input_matrix_port_2; // @[basic_macro.scala 63:26]
  assign io_matrix_output_matrix_port_3 = io_matrix_input_matrix_port_3; // @[basic_macro.scala 63:26]
  assign io_matrix_output_matrix_port_4 = io_matrix_input_matrix_port_4; // @[basic_macro.scala 63:26]
  assign io_matrix_output_matrix_port_5 = io_matrix_input_matrix_port_5; // @[basic_macro.scala 63:26]
  assign io_matrix_output_matrix_port_6 = io_matrix_input_matrix_port_6; // @[basic_macro.scala 63:26]
  assign io_matrix_output_matrix_port_7 = io_matrix_input_matrix_port_7; // @[basic_macro.scala 63:26]
  assign io_matrix_output_matrix_port_8 = io_matrix_input_matrix_port_8; // @[basic_macro.scala 63:26]
endmodule
module sliding_window(
  input         clock,
  input         reset,
  input  [15:0] io_data_in,
  input  [15:0] io_const_in_matrix_port_0,
  input  [15:0] io_const_in_matrix_port_1,
  input  [15:0] io_const_in_matrix_port_2,
  input  [15:0] io_const_in_matrix_port_3,
  input  [15:0] io_const_in_matrix_port_4,
  input  [15:0] io_const_in_matrix_port_5,
  input  [15:0] io_const_in_matrix_port_6,
  input  [15:0] io_const_in_matrix_port_7,
  input  [15:0] io_const_in_matrix_port_8,
  input         io_data_valid,
  input         io_data_refresh,
  output [15:0] io_data_out,
  output        io_data_out_valid,
  output        io_sliding_end
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
  reg [31:0] _RAND_128;
  reg [31:0] _RAND_129;
  reg [31:0] _RAND_130;
  reg [31:0] _RAND_131;
  reg [31:0] _RAND_132;
  reg [31:0] _RAND_133;
  reg [31:0] _RAND_134;
  reg [31:0] _RAND_135;
  reg [31:0] _RAND_136;
  reg [31:0] _RAND_137;
  reg [31:0] _RAND_138;
  reg [31:0] _RAND_139;
  reg [31:0] _RAND_140;
  reg [31:0] _RAND_141;
  reg [31:0] _RAND_142;
  reg [31:0] _RAND_143;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] slid_windows_port_io_matrix_input_matrix_port_0; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_input_matrix_port_1; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_input_matrix_port_2; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_input_matrix_port_3; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_input_matrix_port_4; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_input_matrix_port_5; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_input_matrix_port_6; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_input_matrix_port_7; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_input_matrix_port_8; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_output_matrix_port_0; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_output_matrix_port_1; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_output_matrix_port_2; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_output_matrix_port_3; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_output_matrix_port_4; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_output_matrix_port_5; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_output_matrix_port_6; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_output_matrix_port_7; // @[sliding_window.scala 39:35]
  wire [15:0] slid_windows_port_io_matrix_output_matrix_port_8; // @[sliding_window.scala 39:35]
  reg [15:0] data_shift_0; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_1; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_2; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_3; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_4; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_5; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_6; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_7; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_8; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_9; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_10; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_11; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_12; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_13; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_14; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_15; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_16; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_17; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_18; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_19; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_20; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_21; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_22; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_23; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_24; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_25; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_26; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_27; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_28; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_29; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_30; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_31; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_32; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_33; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_34; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_35; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_36; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_37; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_38; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_39; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_40; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_41; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_42; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_43; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_44; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_45; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_46; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_47; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_48; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_49; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_50; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_51; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_52; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_53; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_54; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_55; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_56; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_57; // @[sliding_window.scala 25:90]
  reg [15:0] data_shift_58; // @[sliding_window.scala 25:90]
  reg [15:0] io_data_out_mul_data_reg_0; // @[basic_macro.scala 41:71]
  reg [15:0] io_data_out_mul_data_reg_1; // @[basic_macro.scala 41:71]
  reg [15:0] io_data_out_mul_data_reg_2; // @[basic_macro.scala 41:71]
  reg [15:0] io_data_out_mul_data_reg_3; // @[basic_macro.scala 41:71]
  reg [15:0] io_data_out_mul_data_reg_4; // @[basic_macro.scala 41:71]
  reg [15:0] io_data_out_mul_data_reg_5; // @[basic_macro.scala 41:71]
  reg [15:0] io_data_out_mul_data_reg_6; // @[basic_macro.scala 41:71]
  reg [15:0] io_data_out_mul_data_reg_7; // @[basic_macro.scala 41:71]
  reg [15:0] io_data_out_mul_data_reg_8; // @[basic_macro.scala 41:71]
  wire [31:0] _io_data_out_mul_data_reg_0_T = $signed(slid_windows_port_io_matrix_output_matrix_port_0) * $signed(
    io_const_in_matrix_port_0); // @[basic_macro.scala 43:38]
  wire [31:0] _io_data_out_mul_data_reg_1_T = $signed(slid_windows_port_io_matrix_output_matrix_port_1) * $signed(
    io_const_in_matrix_port_1); // @[basic_macro.scala 43:38]
  wire [31:0] _io_data_out_mul_data_reg_2_T = $signed(slid_windows_port_io_matrix_output_matrix_port_2) * $signed(
    io_const_in_matrix_port_2); // @[basic_macro.scala 43:38]
  wire [31:0] _io_data_out_mul_data_reg_3_T = $signed(slid_windows_port_io_matrix_output_matrix_port_3) * $signed(
    io_const_in_matrix_port_3); // @[basic_macro.scala 43:38]
  wire [31:0] _io_data_out_mul_data_reg_4_T = $signed(slid_windows_port_io_matrix_output_matrix_port_4) * $signed(
    io_const_in_matrix_port_4); // @[basic_macro.scala 43:38]
  wire [31:0] _io_data_out_mul_data_reg_5_T = $signed(slid_windows_port_io_matrix_output_matrix_port_5) * $signed(
    io_const_in_matrix_port_5); // @[basic_macro.scala 43:38]
  wire [31:0] _io_data_out_mul_data_reg_6_T = $signed(slid_windows_port_io_matrix_output_matrix_port_6) * $signed(
    io_const_in_matrix_port_6); // @[basic_macro.scala 43:38]
  wire [31:0] _io_data_out_mul_data_reg_7_T = $signed(slid_windows_port_io_matrix_output_matrix_port_7) * $signed(
    io_const_in_matrix_port_7); // @[basic_macro.scala 43:38]
  wire [31:0] _io_data_out_mul_data_reg_8_T = $signed(slid_windows_port_io_matrix_output_matrix_port_8) * $signed(
    io_const_in_matrix_port_8); // @[basic_macro.scala 43:38]
  reg [15:0] io_data_out_REG; // @[basic_macro.scala 28:21]
  reg [15:0] io_data_out_REG_1; // @[basic_macro.scala 28:21]
  reg [15:0] io_data_out_REG_2; // @[basic_macro.scala 31:21]
  reg [15:0] io_data_out_REG_3; // @[basic_macro.scala 33:20]
  reg [15:0] io_data_out_REG_4; // @[basic_macro.scala 33:20]
  reg [15:0] io_data_out_REG_5; // @[basic_macro.scala 31:21]
  reg [15:0] io_data_out_REG_6; // @[basic_macro.scala 28:21]
  reg [15:0] io_data_out_REG_7; // @[basic_macro.scala 31:21]
  reg [15:0] io_data_out_REG_8; // @[basic_macro.scala 33:20]
  reg [15:0] io_data_out_REG_9; // @[basic_macro.scala 33:20]
  reg [15:0] io_data_out_REG_10; // @[basic_macro.scala 33:20]
  reg [9:0] counter_a; // @[Counter.scala 62:40]
  wire  wrap_wrap = counter_a == 10'h314; // @[Counter.scala 74:24]
  wire [9:0] _wrap_value_T_1 = counter_a + 10'h1; // @[Counter.scala 78:24]
  reg  io_data_out_valid_r; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_1; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_2; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_3; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_4; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_5; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_6; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_7; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_8; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_9; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_10; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_11; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_12; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_13; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_14; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_15; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_16; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_17; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_18; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_19; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_20; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_21; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_22; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_23; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_24; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_25; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_26; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_27; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_28; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_29; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_30; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_31; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_32; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_33; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_34; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_35; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_36; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_37; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_38; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_39; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_40; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_41; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_42; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_43; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_44; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_45; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_46; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_47; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_48; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_49; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_50; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_51; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_52; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_53; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_54; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_55; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_56; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_57; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_58; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_59; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_60; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_61; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_62; // @[Reg.scala 16:16]
  reg  io_data_out_valid_r_63; // @[Reg.scala 16:16]
  wire [23:0] _GEN_126 = reset ? $signed(24'sh0) : $signed(_io_data_out_mul_data_reg_0_T[31:8]); // @[basic_macro.scala 41:{71,71} 43:33]
  wire [23:0] _GEN_128 = reset ? $signed(24'sh0) : $signed(_io_data_out_mul_data_reg_1_T[31:8]); // @[basic_macro.scala 41:{71,71} 43:33]
  wire [23:0] _GEN_130 = reset ? $signed(24'sh0) : $signed(_io_data_out_mul_data_reg_2_T[31:8]); // @[basic_macro.scala 41:{71,71} 43:33]
  wire [23:0] _GEN_132 = reset ? $signed(24'sh0) : $signed(_io_data_out_mul_data_reg_3_T[31:8]); // @[basic_macro.scala 41:{71,71} 43:33]
  wire [23:0] _GEN_134 = reset ? $signed(24'sh0) : $signed(_io_data_out_mul_data_reg_4_T[31:8]); // @[basic_macro.scala 41:{71,71} 43:33]
  wire [23:0] _GEN_136 = reset ? $signed(24'sh0) : $signed(_io_data_out_mul_data_reg_5_T[31:8]); // @[basic_macro.scala 41:{71,71} 43:33]
  wire [23:0] _GEN_138 = reset ? $signed(24'sh0) : $signed(_io_data_out_mul_data_reg_6_T[31:8]); // @[basic_macro.scala 41:{71,71} 43:33]
  wire [23:0] _GEN_140 = reset ? $signed(24'sh0) : $signed(_io_data_out_mul_data_reg_7_T[31:8]); // @[basic_macro.scala 41:{71,71} 43:33]
  wire [23:0] _GEN_142 = reset ? $signed(24'sh0) : $signed(_io_data_out_mul_data_reg_8_T[31:8]); // @[basic_macro.scala 41:{71,71} 43:33]
  matrix_bundle_cross_bar slid_windows_port ( // @[sliding_window.scala 39:35]
    .io_matrix_input_matrix_port_0(slid_windows_port_io_matrix_input_matrix_port_0),
    .io_matrix_input_matrix_port_1(slid_windows_port_io_matrix_input_matrix_port_1),
    .io_matrix_input_matrix_port_2(slid_windows_port_io_matrix_input_matrix_port_2),
    .io_matrix_input_matrix_port_3(slid_windows_port_io_matrix_input_matrix_port_3),
    .io_matrix_input_matrix_port_4(slid_windows_port_io_matrix_input_matrix_port_4),
    .io_matrix_input_matrix_port_5(slid_windows_port_io_matrix_input_matrix_port_5),
    .io_matrix_input_matrix_port_6(slid_windows_port_io_matrix_input_matrix_port_6),
    .io_matrix_input_matrix_port_7(slid_windows_port_io_matrix_input_matrix_port_7),
    .io_matrix_input_matrix_port_8(slid_windows_port_io_matrix_input_matrix_port_8),
    .io_matrix_output_matrix_port_0(slid_windows_port_io_matrix_output_matrix_port_0),
    .io_matrix_output_matrix_port_1(slid_windows_port_io_matrix_output_matrix_port_1),
    .io_matrix_output_matrix_port_2(slid_windows_port_io_matrix_output_matrix_port_2),
    .io_matrix_output_matrix_port_3(slid_windows_port_io_matrix_output_matrix_port_3),
    .io_matrix_output_matrix_port_4(slid_windows_port_io_matrix_output_matrix_port_4),
    .io_matrix_output_matrix_port_5(slid_windows_port_io_matrix_output_matrix_port_5),
    .io_matrix_output_matrix_port_6(slid_windows_port_io_matrix_output_matrix_port_6),
    .io_matrix_output_matrix_port_7(slid_windows_port_io_matrix_output_matrix_port_7),
    .io_matrix_output_matrix_port_8(slid_windows_port_io_matrix_output_matrix_port_8)
  );
  assign io_data_out = io_data_out_REG_10; // @[sliding_window.scala 43:17]
  assign io_data_out_valid = io_data_out_valid_r_63; // @[sliding_window.scala 47:23]
  assign io_sliding_end = io_data_valid & wrap_wrap; // @[Counter.scala 120:{16,23}]
  assign slid_windows_port_io_matrix_input_matrix_port_0 = data_shift_0; // @[sliding_window.scala 41:62]
  assign slid_windows_port_io_matrix_input_matrix_port_1 = data_shift_1; // @[sliding_window.scala 41:62]
  assign slid_windows_port_io_matrix_input_matrix_port_2 = data_shift_2; // @[sliding_window.scala 41:62]
  assign slid_windows_port_io_matrix_input_matrix_port_3 = data_shift_28; // @[sliding_window.scala 41:62]
  assign slid_windows_port_io_matrix_input_matrix_port_4 = data_shift_29; // @[sliding_window.scala 41:62]
  assign slid_windows_port_io_matrix_input_matrix_port_5 = data_shift_30; // @[sliding_window.scala 41:62]
  assign slid_windows_port_io_matrix_input_matrix_port_6 = data_shift_56; // @[sliding_window.scala 41:62]
  assign slid_windows_port_io_matrix_input_matrix_port_7 = data_shift_57; // @[sliding_window.scala 41:62]
  assign slid_windows_port_io_matrix_input_matrix_port_8 = data_shift_58; // @[sliding_window.scala 41:62]
  always @(posedge clock) begin
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_0 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_0 <= io_data_in; // @[sliding_window.scala 31:37]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_1 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_1 <= data_shift_0; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_2 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_2 <= data_shift_1; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_3 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_3 <= data_shift_2; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_4 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_4 <= data_shift_3; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_5 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_5 <= data_shift_4; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_6 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_6 <= data_shift_5; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_7 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_7 <= data_shift_6; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_8 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_8 <= data_shift_7; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_9 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_9 <= data_shift_8; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_10 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_10 <= data_shift_9; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_11 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_11 <= data_shift_10; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_12 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_12 <= data_shift_11; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_13 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_13 <= data_shift_12; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_14 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_14 <= data_shift_13; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_15 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_15 <= data_shift_14; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_16 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_16 <= data_shift_15; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_17 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_17 <= data_shift_16; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_18 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_18 <= data_shift_17; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_19 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_19 <= data_shift_18; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_20 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_20 <= data_shift_19; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_21 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_21 <= data_shift_20; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_22 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_22 <= data_shift_21; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_23 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_23 <= data_shift_22; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_24 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_24 <= data_shift_23; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_25 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_25 <= data_shift_24; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_26 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_26 <= data_shift_25; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_27 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_27 <= data_shift_26; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_28 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_28 <= data_shift_27; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_29 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_29 <= data_shift_28; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_30 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_30 <= data_shift_29; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_31 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_31 <= data_shift_30; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_32 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_32 <= data_shift_31; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_33 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_33 <= data_shift_32; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_34 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_34 <= data_shift_33; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_35 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_35 <= data_shift_34; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_36 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_36 <= data_shift_35; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_37 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_37 <= data_shift_36; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_38 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_38 <= data_shift_37; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_39 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_39 <= data_shift_38; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_40 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_40 <= data_shift_39; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_41 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_41 <= data_shift_40; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_42 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_42 <= data_shift_41; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_43 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_43 <= data_shift_42; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_44 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_44 <= data_shift_43; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_45 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_45 <= data_shift_44; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_46 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_46 <= data_shift_45; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_47 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_47 <= data_shift_46; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_48 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_48 <= data_shift_47; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_49 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_49 <= data_shift_48; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_50 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_50 <= data_shift_49; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_51 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_51 <= data_shift_50; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_52 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_52 <= data_shift_51; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_53 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_53 <= data_shift_52; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_54 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_54 <= data_shift_53; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_55 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_55 <= data_shift_54; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_56 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_56 <= data_shift_55; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_57 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_57 <= data_shift_56; // @[sliding_window.scala 33:35]
    end
    if (reset) begin // @[sliding_window.scala 25:90]
      data_shift_58 <= 16'sh0; // @[sliding_window.scala 25:90]
    end else if (!(io_data_valid)) begin // @[sliding_window.scala 27:29]
      data_shift_58 <= data_shift_57; // @[sliding_window.scala 33:35]
    end
    io_data_out_mul_data_reg_0 <= _GEN_126[15:0]; // @[basic_macro.scala 41:{71,71} 43:33]
    io_data_out_mul_data_reg_1 <= _GEN_128[15:0]; // @[basic_macro.scala 41:{71,71} 43:33]
    io_data_out_mul_data_reg_2 <= _GEN_130[15:0]; // @[basic_macro.scala 41:{71,71} 43:33]
    io_data_out_mul_data_reg_3 <= _GEN_132[15:0]; // @[basic_macro.scala 41:{71,71} 43:33]
    io_data_out_mul_data_reg_4 <= _GEN_134[15:0]; // @[basic_macro.scala 41:{71,71} 43:33]
    io_data_out_mul_data_reg_5 <= _GEN_136[15:0]; // @[basic_macro.scala 41:{71,71} 43:33]
    io_data_out_mul_data_reg_6 <= _GEN_138[15:0]; // @[basic_macro.scala 41:{71,71} 43:33]
    io_data_out_mul_data_reg_7 <= _GEN_140[15:0]; // @[basic_macro.scala 41:{71,71} 43:33]
    io_data_out_mul_data_reg_8 <= _GEN_142[15:0]; // @[basic_macro.scala 41:{71,71} 43:33]
    io_data_out_REG <= io_data_out_mul_data_reg_0; // @[basic_macro.scala 28:21]
    io_data_out_REG_1 <= io_data_out_mul_data_reg_1; // @[basic_macro.scala 28:21]
    io_data_out_REG_2 <= $signed(io_data_out_mul_data_reg_2) + $signed(io_data_out_mul_data_reg_3); // @[basic_macro.scala 37:60]
    io_data_out_REG_3 <= $signed(io_data_out_REG_1) + $signed(io_data_out_REG_2); // @[basic_macro.scala 37:60]
    io_data_out_REG_4 <= $signed(io_data_out_REG) + $signed(io_data_out_REG_3); // @[basic_macro.scala 37:60]
    io_data_out_REG_5 <= $signed(io_data_out_mul_data_reg_4) + $signed(io_data_out_mul_data_reg_5); // @[basic_macro.scala 37:60]
    io_data_out_REG_6 <= io_data_out_mul_data_reg_6; // @[basic_macro.scala 28:21]
    io_data_out_REG_7 <= $signed(io_data_out_mul_data_reg_7) + $signed(io_data_out_mul_data_reg_8); // @[basic_macro.scala 37:60]
    io_data_out_REG_8 <= $signed(io_data_out_REG_6) + $signed(io_data_out_REG_7); // @[basic_macro.scala 37:60]
    io_data_out_REG_9 <= $signed(io_data_out_REG_5) + $signed(io_data_out_REG_8); // @[basic_macro.scala 37:60]
    io_data_out_REG_10 <= $signed(io_data_out_REG_4) + $signed(io_data_out_REG_9); // @[basic_macro.scala 37:60]
    if (reset) begin // @[Counter.scala 62:40]
      counter_a <= 10'h0; // @[Counter.scala 62:40]
    end else if (io_data_valid) begin // @[Counter.scala 120:16]
      if (wrap_wrap) begin // @[Counter.scala 88:20]
        counter_a <= 10'h0; // @[Counter.scala 88:28]
      end else begin
        counter_a <= _wrap_value_T_1; // @[Counter.scala 78:15]
      end
    end
    io_data_out_valid_r <= io_data_valid; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_1 <= io_data_out_valid_r; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_2 <= io_data_out_valid_r_1; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_3 <= io_data_out_valid_r_2; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_4 <= io_data_out_valid_r_3; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_5 <= io_data_out_valid_r_4; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_6 <= io_data_out_valid_r_5; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_7 <= io_data_out_valid_r_6; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_8 <= io_data_out_valid_r_7; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_9 <= io_data_out_valid_r_8; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_10 <= io_data_out_valid_r_9; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_11 <= io_data_out_valid_r_10; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_12 <= io_data_out_valid_r_11; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_13 <= io_data_out_valid_r_12; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_14 <= io_data_out_valid_r_13; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_15 <= io_data_out_valid_r_14; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_16 <= io_data_out_valid_r_15; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_17 <= io_data_out_valid_r_16; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_18 <= io_data_out_valid_r_17; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_19 <= io_data_out_valid_r_18; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_20 <= io_data_out_valid_r_19; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_21 <= io_data_out_valid_r_20; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_22 <= io_data_out_valid_r_21; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_23 <= io_data_out_valid_r_22; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_24 <= io_data_out_valid_r_23; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_25 <= io_data_out_valid_r_24; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_26 <= io_data_out_valid_r_25; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_27 <= io_data_out_valid_r_26; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_28 <= io_data_out_valid_r_27; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_29 <= io_data_out_valid_r_28; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_30 <= io_data_out_valid_r_29; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_31 <= io_data_out_valid_r_30; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_32 <= io_data_out_valid_r_31; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_33 <= io_data_out_valid_r_32; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_34 <= io_data_out_valid_r_33; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_35 <= io_data_out_valid_r_34; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_36 <= io_data_out_valid_r_35; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_37 <= io_data_out_valid_r_36; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_38 <= io_data_out_valid_r_37; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_39 <= io_data_out_valid_r_38; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_40 <= io_data_out_valid_r_39; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_41 <= io_data_out_valid_r_40; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_42 <= io_data_out_valid_r_41; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_43 <= io_data_out_valid_r_42; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_44 <= io_data_out_valid_r_43; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_45 <= io_data_out_valid_r_44; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_46 <= io_data_out_valid_r_45; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_47 <= io_data_out_valid_r_46; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_48 <= io_data_out_valid_r_47; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_49 <= io_data_out_valid_r_48; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_50 <= io_data_out_valid_r_49; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_51 <= io_data_out_valid_r_50; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_52 <= io_data_out_valid_r_51; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_53 <= io_data_out_valid_r_52; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_54 <= io_data_out_valid_r_53; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_55 <= io_data_out_valid_r_54; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_56 <= io_data_out_valid_r_55; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_57 <= io_data_out_valid_r_56; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_58 <= io_data_out_valid_r_57; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_59 <= io_data_out_valid_r_58; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_60 <= io_data_out_valid_r_59; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_61 <= io_data_out_valid_r_60; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_62 <= io_data_out_valid_r_61; // @[Reg.scala 16:16 17:{18,22}]
    io_data_out_valid_r_63 <= io_data_out_valid_r_62; // @[Reg.scala 16:16 17:{18,22}]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  data_shift_0 = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  data_shift_1 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  data_shift_2 = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  data_shift_3 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  data_shift_4 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  data_shift_5 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  data_shift_6 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  data_shift_7 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  data_shift_8 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  data_shift_9 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  data_shift_10 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  data_shift_11 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  data_shift_12 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  data_shift_13 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  data_shift_14 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  data_shift_15 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  data_shift_16 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  data_shift_17 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  data_shift_18 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  data_shift_19 = _RAND_19[15:0];
  _RAND_20 = {1{`RANDOM}};
  data_shift_20 = _RAND_20[15:0];
  _RAND_21 = {1{`RANDOM}};
  data_shift_21 = _RAND_21[15:0];
  _RAND_22 = {1{`RANDOM}};
  data_shift_22 = _RAND_22[15:0];
  _RAND_23 = {1{`RANDOM}};
  data_shift_23 = _RAND_23[15:0];
  _RAND_24 = {1{`RANDOM}};
  data_shift_24 = _RAND_24[15:0];
  _RAND_25 = {1{`RANDOM}};
  data_shift_25 = _RAND_25[15:0];
  _RAND_26 = {1{`RANDOM}};
  data_shift_26 = _RAND_26[15:0];
  _RAND_27 = {1{`RANDOM}};
  data_shift_27 = _RAND_27[15:0];
  _RAND_28 = {1{`RANDOM}};
  data_shift_28 = _RAND_28[15:0];
  _RAND_29 = {1{`RANDOM}};
  data_shift_29 = _RAND_29[15:0];
  _RAND_30 = {1{`RANDOM}};
  data_shift_30 = _RAND_30[15:0];
  _RAND_31 = {1{`RANDOM}};
  data_shift_31 = _RAND_31[15:0];
  _RAND_32 = {1{`RANDOM}};
  data_shift_32 = _RAND_32[15:0];
  _RAND_33 = {1{`RANDOM}};
  data_shift_33 = _RAND_33[15:0];
  _RAND_34 = {1{`RANDOM}};
  data_shift_34 = _RAND_34[15:0];
  _RAND_35 = {1{`RANDOM}};
  data_shift_35 = _RAND_35[15:0];
  _RAND_36 = {1{`RANDOM}};
  data_shift_36 = _RAND_36[15:0];
  _RAND_37 = {1{`RANDOM}};
  data_shift_37 = _RAND_37[15:0];
  _RAND_38 = {1{`RANDOM}};
  data_shift_38 = _RAND_38[15:0];
  _RAND_39 = {1{`RANDOM}};
  data_shift_39 = _RAND_39[15:0];
  _RAND_40 = {1{`RANDOM}};
  data_shift_40 = _RAND_40[15:0];
  _RAND_41 = {1{`RANDOM}};
  data_shift_41 = _RAND_41[15:0];
  _RAND_42 = {1{`RANDOM}};
  data_shift_42 = _RAND_42[15:0];
  _RAND_43 = {1{`RANDOM}};
  data_shift_43 = _RAND_43[15:0];
  _RAND_44 = {1{`RANDOM}};
  data_shift_44 = _RAND_44[15:0];
  _RAND_45 = {1{`RANDOM}};
  data_shift_45 = _RAND_45[15:0];
  _RAND_46 = {1{`RANDOM}};
  data_shift_46 = _RAND_46[15:0];
  _RAND_47 = {1{`RANDOM}};
  data_shift_47 = _RAND_47[15:0];
  _RAND_48 = {1{`RANDOM}};
  data_shift_48 = _RAND_48[15:0];
  _RAND_49 = {1{`RANDOM}};
  data_shift_49 = _RAND_49[15:0];
  _RAND_50 = {1{`RANDOM}};
  data_shift_50 = _RAND_50[15:0];
  _RAND_51 = {1{`RANDOM}};
  data_shift_51 = _RAND_51[15:0];
  _RAND_52 = {1{`RANDOM}};
  data_shift_52 = _RAND_52[15:0];
  _RAND_53 = {1{`RANDOM}};
  data_shift_53 = _RAND_53[15:0];
  _RAND_54 = {1{`RANDOM}};
  data_shift_54 = _RAND_54[15:0];
  _RAND_55 = {1{`RANDOM}};
  data_shift_55 = _RAND_55[15:0];
  _RAND_56 = {1{`RANDOM}};
  data_shift_56 = _RAND_56[15:0];
  _RAND_57 = {1{`RANDOM}};
  data_shift_57 = _RAND_57[15:0];
  _RAND_58 = {1{`RANDOM}};
  data_shift_58 = _RAND_58[15:0];
  _RAND_59 = {1{`RANDOM}};
  io_data_out_mul_data_reg_0 = _RAND_59[15:0];
  _RAND_60 = {1{`RANDOM}};
  io_data_out_mul_data_reg_1 = _RAND_60[15:0];
  _RAND_61 = {1{`RANDOM}};
  io_data_out_mul_data_reg_2 = _RAND_61[15:0];
  _RAND_62 = {1{`RANDOM}};
  io_data_out_mul_data_reg_3 = _RAND_62[15:0];
  _RAND_63 = {1{`RANDOM}};
  io_data_out_mul_data_reg_4 = _RAND_63[15:0];
  _RAND_64 = {1{`RANDOM}};
  io_data_out_mul_data_reg_5 = _RAND_64[15:0];
  _RAND_65 = {1{`RANDOM}};
  io_data_out_mul_data_reg_6 = _RAND_65[15:0];
  _RAND_66 = {1{`RANDOM}};
  io_data_out_mul_data_reg_7 = _RAND_66[15:0];
  _RAND_67 = {1{`RANDOM}};
  io_data_out_mul_data_reg_8 = _RAND_67[15:0];
  _RAND_68 = {1{`RANDOM}};
  io_data_out_REG = _RAND_68[15:0];
  _RAND_69 = {1{`RANDOM}};
  io_data_out_REG_1 = _RAND_69[15:0];
  _RAND_70 = {1{`RANDOM}};
  io_data_out_REG_2 = _RAND_70[15:0];
  _RAND_71 = {1{`RANDOM}};
  io_data_out_REG_3 = _RAND_71[15:0];
  _RAND_72 = {1{`RANDOM}};
  io_data_out_REG_4 = _RAND_72[15:0];
  _RAND_73 = {1{`RANDOM}};
  io_data_out_REG_5 = _RAND_73[15:0];
  _RAND_74 = {1{`RANDOM}};
  io_data_out_REG_6 = _RAND_74[15:0];
  _RAND_75 = {1{`RANDOM}};
  io_data_out_REG_7 = _RAND_75[15:0];
  _RAND_76 = {1{`RANDOM}};
  io_data_out_REG_8 = _RAND_76[15:0];
  _RAND_77 = {1{`RANDOM}};
  io_data_out_REG_9 = _RAND_77[15:0];
  _RAND_78 = {1{`RANDOM}};
  io_data_out_REG_10 = _RAND_78[15:0];
  _RAND_79 = {1{`RANDOM}};
  counter_a = _RAND_79[9:0];
  _RAND_80 = {1{`RANDOM}};
  io_data_out_valid_r = _RAND_80[0:0];
  _RAND_81 = {1{`RANDOM}};
  io_data_out_valid_r_1 = _RAND_81[0:0];
  _RAND_82 = {1{`RANDOM}};
  io_data_out_valid_r_2 = _RAND_82[0:0];
  _RAND_83 = {1{`RANDOM}};
  io_data_out_valid_r_3 = _RAND_83[0:0];
  _RAND_84 = {1{`RANDOM}};
  io_data_out_valid_r_4 = _RAND_84[0:0];
  _RAND_85 = {1{`RANDOM}};
  io_data_out_valid_r_5 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  io_data_out_valid_r_6 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  io_data_out_valid_r_7 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  io_data_out_valid_r_8 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  io_data_out_valid_r_9 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  io_data_out_valid_r_10 = _RAND_90[0:0];
  _RAND_91 = {1{`RANDOM}};
  io_data_out_valid_r_11 = _RAND_91[0:0];
  _RAND_92 = {1{`RANDOM}};
  io_data_out_valid_r_12 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  io_data_out_valid_r_13 = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  io_data_out_valid_r_14 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  io_data_out_valid_r_15 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  io_data_out_valid_r_16 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  io_data_out_valid_r_17 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  io_data_out_valid_r_18 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  io_data_out_valid_r_19 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  io_data_out_valid_r_20 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  io_data_out_valid_r_21 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  io_data_out_valid_r_22 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  io_data_out_valid_r_23 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  io_data_out_valid_r_24 = _RAND_104[0:0];
  _RAND_105 = {1{`RANDOM}};
  io_data_out_valid_r_25 = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  io_data_out_valid_r_26 = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  io_data_out_valid_r_27 = _RAND_107[0:0];
  _RAND_108 = {1{`RANDOM}};
  io_data_out_valid_r_28 = _RAND_108[0:0];
  _RAND_109 = {1{`RANDOM}};
  io_data_out_valid_r_29 = _RAND_109[0:0];
  _RAND_110 = {1{`RANDOM}};
  io_data_out_valid_r_30 = _RAND_110[0:0];
  _RAND_111 = {1{`RANDOM}};
  io_data_out_valid_r_31 = _RAND_111[0:0];
  _RAND_112 = {1{`RANDOM}};
  io_data_out_valid_r_32 = _RAND_112[0:0];
  _RAND_113 = {1{`RANDOM}};
  io_data_out_valid_r_33 = _RAND_113[0:0];
  _RAND_114 = {1{`RANDOM}};
  io_data_out_valid_r_34 = _RAND_114[0:0];
  _RAND_115 = {1{`RANDOM}};
  io_data_out_valid_r_35 = _RAND_115[0:0];
  _RAND_116 = {1{`RANDOM}};
  io_data_out_valid_r_36 = _RAND_116[0:0];
  _RAND_117 = {1{`RANDOM}};
  io_data_out_valid_r_37 = _RAND_117[0:0];
  _RAND_118 = {1{`RANDOM}};
  io_data_out_valid_r_38 = _RAND_118[0:0];
  _RAND_119 = {1{`RANDOM}};
  io_data_out_valid_r_39 = _RAND_119[0:0];
  _RAND_120 = {1{`RANDOM}};
  io_data_out_valid_r_40 = _RAND_120[0:0];
  _RAND_121 = {1{`RANDOM}};
  io_data_out_valid_r_41 = _RAND_121[0:0];
  _RAND_122 = {1{`RANDOM}};
  io_data_out_valid_r_42 = _RAND_122[0:0];
  _RAND_123 = {1{`RANDOM}};
  io_data_out_valid_r_43 = _RAND_123[0:0];
  _RAND_124 = {1{`RANDOM}};
  io_data_out_valid_r_44 = _RAND_124[0:0];
  _RAND_125 = {1{`RANDOM}};
  io_data_out_valid_r_45 = _RAND_125[0:0];
  _RAND_126 = {1{`RANDOM}};
  io_data_out_valid_r_46 = _RAND_126[0:0];
  _RAND_127 = {1{`RANDOM}};
  io_data_out_valid_r_47 = _RAND_127[0:0];
  _RAND_128 = {1{`RANDOM}};
  io_data_out_valid_r_48 = _RAND_128[0:0];
  _RAND_129 = {1{`RANDOM}};
  io_data_out_valid_r_49 = _RAND_129[0:0];
  _RAND_130 = {1{`RANDOM}};
  io_data_out_valid_r_50 = _RAND_130[0:0];
  _RAND_131 = {1{`RANDOM}};
  io_data_out_valid_r_51 = _RAND_131[0:0];
  _RAND_132 = {1{`RANDOM}};
  io_data_out_valid_r_52 = _RAND_132[0:0];
  _RAND_133 = {1{`RANDOM}};
  io_data_out_valid_r_53 = _RAND_133[0:0];
  _RAND_134 = {1{`RANDOM}};
  io_data_out_valid_r_54 = _RAND_134[0:0];
  _RAND_135 = {1{`RANDOM}};
  io_data_out_valid_r_55 = _RAND_135[0:0];
  _RAND_136 = {1{`RANDOM}};
  io_data_out_valid_r_56 = _RAND_136[0:0];
  _RAND_137 = {1{`RANDOM}};
  io_data_out_valid_r_57 = _RAND_137[0:0];
  _RAND_138 = {1{`RANDOM}};
  io_data_out_valid_r_58 = _RAND_138[0:0];
  _RAND_139 = {1{`RANDOM}};
  io_data_out_valid_r_59 = _RAND_139[0:0];
  _RAND_140 = {1{`RANDOM}};
  io_data_out_valid_r_60 = _RAND_140[0:0];
  _RAND_141 = {1{`RANDOM}};
  io_data_out_valid_r_61 = _RAND_141[0:0];
  _RAND_142 = {1{`RANDOM}};
  io_data_out_valid_r_62 = _RAND_142[0:0];
  _RAND_143 = {1{`RANDOM}};
  io_data_out_valid_r_63 = _RAND_143[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
