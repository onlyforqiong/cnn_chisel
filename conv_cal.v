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
  output [15:0] io_data_out
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
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module sliding_window_filter(
  input         clock,
  input         reset,
  input  [15:0] io_data_in_0,
  input         io_data_valid_0,
  input  [15:0] io_const_in_matrix_port_0,
  input  [15:0] io_const_in_matrix_port_1,
  input  [15:0] io_const_in_matrix_port_2,
  input  [15:0] io_const_in_matrix_port_3,
  input  [15:0] io_const_in_matrix_port_4,
  input  [15:0] io_const_in_matrix_port_5,
  input  [15:0] io_const_in_matrix_port_6,
  input  [15:0] io_const_in_matrix_port_7,
  input  [15:0] io_const_in_matrix_port_8,
  output [15:0] io_data_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  sliding_window_clock; // @[conv_cal.scala 25:55]
  wire  sliding_window_reset; // @[conv_cal.scala 25:55]
  wire [15:0] sliding_window_io_data_in; // @[conv_cal.scala 25:55]
  wire [15:0] sliding_window_io_const_in_matrix_port_0; // @[conv_cal.scala 25:55]
  wire [15:0] sliding_window_io_const_in_matrix_port_1; // @[conv_cal.scala 25:55]
  wire [15:0] sliding_window_io_const_in_matrix_port_2; // @[conv_cal.scala 25:55]
  wire [15:0] sliding_window_io_const_in_matrix_port_3; // @[conv_cal.scala 25:55]
  wire [15:0] sliding_window_io_const_in_matrix_port_4; // @[conv_cal.scala 25:55]
  wire [15:0] sliding_window_io_const_in_matrix_port_5; // @[conv_cal.scala 25:55]
  wire [15:0] sliding_window_io_const_in_matrix_port_6; // @[conv_cal.scala 25:55]
  wire [15:0] sliding_window_io_const_in_matrix_port_7; // @[conv_cal.scala 25:55]
  wire [15:0] sliding_window_io_const_in_matrix_port_8; // @[conv_cal.scala 25:55]
  wire  sliding_window_io_data_valid; // @[conv_cal.scala 25:55]
  wire [15:0] sliding_window_io_data_out; // @[conv_cal.scala 25:55]
  reg [15:0] filter_answer_0; // @[conv_cal.scala 35:54]
  reg [15:0] io_data_out_REG; // @[basic_macro.scala 28:21]
  wire [15:0] answer_0_data_out = sliding_window_io_data_out; // @[conv_cal.scala 25:{30,30}]
  sliding_window sliding_window ( // @[conv_cal.scala 25:55]
    .clock(sliding_window_clock),
    .reset(sliding_window_reset),
    .io_data_in(sliding_window_io_data_in),
    .io_const_in_matrix_port_0(sliding_window_io_const_in_matrix_port_0),
    .io_const_in_matrix_port_1(sliding_window_io_const_in_matrix_port_1),
    .io_const_in_matrix_port_2(sliding_window_io_const_in_matrix_port_2),
    .io_const_in_matrix_port_3(sliding_window_io_const_in_matrix_port_3),
    .io_const_in_matrix_port_4(sliding_window_io_const_in_matrix_port_4),
    .io_const_in_matrix_port_5(sliding_window_io_const_in_matrix_port_5),
    .io_const_in_matrix_port_6(sliding_window_io_const_in_matrix_port_6),
    .io_const_in_matrix_port_7(sliding_window_io_const_in_matrix_port_7),
    .io_const_in_matrix_port_8(sliding_window_io_const_in_matrix_port_8),
    .io_data_valid(sliding_window_io_data_valid),
    .io_data_out(sliding_window_io_data_out)
  );
  assign io_data_out = io_data_out_REG; // @[conv_cal.scala 44:21]
  assign sliding_window_clock = clock;
  assign sliding_window_reset = reset;
  assign sliding_window_io_data_in = io_data_in_0; // @[conv_cal.scala 25:30 38:25]
  assign sliding_window_io_const_in_matrix_port_0 = io_const_in_matrix_port_0; // @[conv_cal.scala 25:30 37:25]
  assign sliding_window_io_const_in_matrix_port_1 = io_const_in_matrix_port_1; // @[conv_cal.scala 25:30 37:25]
  assign sliding_window_io_const_in_matrix_port_2 = io_const_in_matrix_port_2; // @[conv_cal.scala 25:30 37:25]
  assign sliding_window_io_const_in_matrix_port_3 = io_const_in_matrix_port_3; // @[conv_cal.scala 25:30 37:25]
  assign sliding_window_io_const_in_matrix_port_4 = io_const_in_matrix_port_4; // @[conv_cal.scala 25:30 37:25]
  assign sliding_window_io_const_in_matrix_port_5 = io_const_in_matrix_port_5; // @[conv_cal.scala 25:30 37:25]
  assign sliding_window_io_const_in_matrix_port_6 = io_const_in_matrix_port_6; // @[conv_cal.scala 25:30 37:25]
  assign sliding_window_io_const_in_matrix_port_7 = io_const_in_matrix_port_7; // @[conv_cal.scala 25:30 37:25]
  assign sliding_window_io_const_in_matrix_port_8 = io_const_in_matrix_port_8; // @[conv_cal.scala 25:30 37:25]
  assign sliding_window_io_data_valid = io_data_valid_0; // @[conv_cal.scala 25:30 40:27]
  always @(posedge clock) begin
    if (reset) begin // @[conv_cal.scala 35:54]
      filter_answer_0 <= 16'sh0; // @[conv_cal.scala 35:54]
    end else begin
      filter_answer_0 <= answer_0_data_out; // @[conv_cal.scala 41:34]
    end
    io_data_out_REG <= filter_answer_0; // @[basic_macro.scala 28:21]
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
  filter_answer_0 = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_data_out_REG = _RAND_1[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module conv_cal(
  input         clock,
  input         reset,
  input  [15:0] io_data_in_0,
  input         io_data_valid_0,
  input         io_conv_start_0,
  input         io_data_refresh,
  output [15:0] io_data_out_0,
  output [15:0] io_data_out_1,
  output [15:0] io_data_out_2,
  output [15:0] io_data_out_3,
  output [15:0] io_data_out_4,
  output [15:0] io_data_out_5,
  output [15:0] io_data_out_6,
  output [15:0] io_data_out_7,
  output [15:0] io_data_out_8,
  output [15:0] io_data_out_9,
  output        io_conv_end_0,
  output        io_conv_end_1,
  output        io_conv_end_2,
  output        io_conv_end_3,
  output        io_conv_end_4,
  output        io_conv_end_5,
  output        io_conv_end_6,
  output        io_conv_end_7,
  output        io_conv_end_8,
  output        io_conv_end_9,
  input  [15:0] io_const_in_0_matrix_port_0,
  input  [15:0] io_const_in_0_matrix_port_1,
  input  [15:0] io_const_in_0_matrix_port_2,
  input  [15:0] io_const_in_0_matrix_port_3,
  input  [15:0] io_const_in_0_matrix_port_4,
  input  [15:0] io_const_in_0_matrix_port_5,
  input  [15:0] io_const_in_0_matrix_port_6,
  input  [15:0] io_const_in_0_matrix_port_7,
  input  [15:0] io_const_in_0_matrix_port_8,
  input  [15:0] io_const_in_1_matrix_port_0,
  input  [15:0] io_const_in_1_matrix_port_1,
  input  [15:0] io_const_in_1_matrix_port_2,
  input  [15:0] io_const_in_1_matrix_port_3,
  input  [15:0] io_const_in_1_matrix_port_4,
  input  [15:0] io_const_in_1_matrix_port_5,
  input  [15:0] io_const_in_1_matrix_port_6,
  input  [15:0] io_const_in_1_matrix_port_7,
  input  [15:0] io_const_in_1_matrix_port_8,
  input  [15:0] io_const_in_2_matrix_port_0,
  input  [15:0] io_const_in_2_matrix_port_1,
  input  [15:0] io_const_in_2_matrix_port_2,
  input  [15:0] io_const_in_2_matrix_port_3,
  input  [15:0] io_const_in_2_matrix_port_4,
  input  [15:0] io_const_in_2_matrix_port_5,
  input  [15:0] io_const_in_2_matrix_port_6,
  input  [15:0] io_const_in_2_matrix_port_7,
  input  [15:0] io_const_in_2_matrix_port_8,
  input  [15:0] io_const_in_3_matrix_port_0,
  input  [15:0] io_const_in_3_matrix_port_1,
  input  [15:0] io_const_in_3_matrix_port_2,
  input  [15:0] io_const_in_3_matrix_port_3,
  input  [15:0] io_const_in_3_matrix_port_4,
  input  [15:0] io_const_in_3_matrix_port_5,
  input  [15:0] io_const_in_3_matrix_port_6,
  input  [15:0] io_const_in_3_matrix_port_7,
  input  [15:0] io_const_in_3_matrix_port_8,
  input  [15:0] io_const_in_4_matrix_port_0,
  input  [15:0] io_const_in_4_matrix_port_1,
  input  [15:0] io_const_in_4_matrix_port_2,
  input  [15:0] io_const_in_4_matrix_port_3,
  input  [15:0] io_const_in_4_matrix_port_4,
  input  [15:0] io_const_in_4_matrix_port_5,
  input  [15:0] io_const_in_4_matrix_port_6,
  input  [15:0] io_const_in_4_matrix_port_7,
  input  [15:0] io_const_in_4_matrix_port_8,
  input  [15:0] io_const_in_5_matrix_port_0,
  input  [15:0] io_const_in_5_matrix_port_1,
  input  [15:0] io_const_in_5_matrix_port_2,
  input  [15:0] io_const_in_5_matrix_port_3,
  input  [15:0] io_const_in_5_matrix_port_4,
  input  [15:0] io_const_in_5_matrix_port_5,
  input  [15:0] io_const_in_5_matrix_port_6,
  input  [15:0] io_const_in_5_matrix_port_7,
  input  [15:0] io_const_in_5_matrix_port_8,
  input  [15:0] io_const_in_6_matrix_port_0,
  input  [15:0] io_const_in_6_matrix_port_1,
  input  [15:0] io_const_in_6_matrix_port_2,
  input  [15:0] io_const_in_6_matrix_port_3,
  input  [15:0] io_const_in_6_matrix_port_4,
  input  [15:0] io_const_in_6_matrix_port_5,
  input  [15:0] io_const_in_6_matrix_port_6,
  input  [15:0] io_const_in_6_matrix_port_7,
  input  [15:0] io_const_in_6_matrix_port_8,
  input  [15:0] io_const_in_7_matrix_port_0,
  input  [15:0] io_const_in_7_matrix_port_1,
  input  [15:0] io_const_in_7_matrix_port_2,
  input  [15:0] io_const_in_7_matrix_port_3,
  input  [15:0] io_const_in_7_matrix_port_4,
  input  [15:0] io_const_in_7_matrix_port_5,
  input  [15:0] io_const_in_7_matrix_port_6,
  input  [15:0] io_const_in_7_matrix_port_7,
  input  [15:0] io_const_in_7_matrix_port_8,
  input  [15:0] io_const_in_8_matrix_port_0,
  input  [15:0] io_const_in_8_matrix_port_1,
  input  [15:0] io_const_in_8_matrix_port_2,
  input  [15:0] io_const_in_8_matrix_port_3,
  input  [15:0] io_const_in_8_matrix_port_4,
  input  [15:0] io_const_in_8_matrix_port_5,
  input  [15:0] io_const_in_8_matrix_port_6,
  input  [15:0] io_const_in_8_matrix_port_7,
  input  [15:0] io_const_in_8_matrix_port_8,
  input  [15:0] io_const_in_9_matrix_port_0,
  input  [15:0] io_const_in_9_matrix_port_1,
  input  [15:0] io_const_in_9_matrix_port_2,
  input  [15:0] io_const_in_9_matrix_port_3,
  input  [15:0] io_const_in_9_matrix_port_4,
  input  [15:0] io_const_in_9_matrix_port_5,
  input  [15:0] io_const_in_9_matrix_port_6,
  input  [15:0] io_const_in_9_matrix_port_7,
  input  [15:0] io_const_in_9_matrix_port_8,
  output [31:0] io_io_out_data
);
  wire  sliding_window_filter_clock; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_reset; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_io_data_in_0; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_io_data_valid_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_io_const_in_matrix_port_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_io_const_in_matrix_port_1; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_io_const_in_matrix_port_2; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_io_const_in_matrix_port_3; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_io_const_in_matrix_port_4; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_io_const_in_matrix_port_5; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_io_const_in_matrix_port_6; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_io_const_in_matrix_port_7; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_io_const_in_matrix_port_8; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_io_data_out; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_1_clock; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_1_reset; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_1_io_data_in_0; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_1_io_data_valid_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_1_io_const_in_matrix_port_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_1_io_const_in_matrix_port_1; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_1_io_const_in_matrix_port_2; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_1_io_const_in_matrix_port_3; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_1_io_const_in_matrix_port_4; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_1_io_const_in_matrix_port_5; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_1_io_const_in_matrix_port_6; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_1_io_const_in_matrix_port_7; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_1_io_const_in_matrix_port_8; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_1_io_data_out; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_2_clock; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_2_reset; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_2_io_data_in_0; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_2_io_data_valid_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_2_io_const_in_matrix_port_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_2_io_const_in_matrix_port_1; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_2_io_const_in_matrix_port_2; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_2_io_const_in_matrix_port_3; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_2_io_const_in_matrix_port_4; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_2_io_const_in_matrix_port_5; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_2_io_const_in_matrix_port_6; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_2_io_const_in_matrix_port_7; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_2_io_const_in_matrix_port_8; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_2_io_data_out; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_3_clock; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_3_reset; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_3_io_data_in_0; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_3_io_data_valid_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_3_io_const_in_matrix_port_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_3_io_const_in_matrix_port_1; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_3_io_const_in_matrix_port_2; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_3_io_const_in_matrix_port_3; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_3_io_const_in_matrix_port_4; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_3_io_const_in_matrix_port_5; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_3_io_const_in_matrix_port_6; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_3_io_const_in_matrix_port_7; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_3_io_const_in_matrix_port_8; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_3_io_data_out; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_4_clock; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_4_reset; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_4_io_data_in_0; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_4_io_data_valid_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_4_io_const_in_matrix_port_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_4_io_const_in_matrix_port_1; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_4_io_const_in_matrix_port_2; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_4_io_const_in_matrix_port_3; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_4_io_const_in_matrix_port_4; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_4_io_const_in_matrix_port_5; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_4_io_const_in_matrix_port_6; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_4_io_const_in_matrix_port_7; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_4_io_const_in_matrix_port_8; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_4_io_data_out; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_5_clock; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_5_reset; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_5_io_data_in_0; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_5_io_data_valid_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_5_io_const_in_matrix_port_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_5_io_const_in_matrix_port_1; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_5_io_const_in_matrix_port_2; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_5_io_const_in_matrix_port_3; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_5_io_const_in_matrix_port_4; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_5_io_const_in_matrix_port_5; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_5_io_const_in_matrix_port_6; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_5_io_const_in_matrix_port_7; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_5_io_const_in_matrix_port_8; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_5_io_data_out; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_6_clock; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_6_reset; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_6_io_data_in_0; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_6_io_data_valid_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_6_io_const_in_matrix_port_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_6_io_const_in_matrix_port_1; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_6_io_const_in_matrix_port_2; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_6_io_const_in_matrix_port_3; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_6_io_const_in_matrix_port_4; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_6_io_const_in_matrix_port_5; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_6_io_const_in_matrix_port_6; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_6_io_const_in_matrix_port_7; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_6_io_const_in_matrix_port_8; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_6_io_data_out; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_7_clock; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_7_reset; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_7_io_data_in_0; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_7_io_data_valid_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_7_io_const_in_matrix_port_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_7_io_const_in_matrix_port_1; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_7_io_const_in_matrix_port_2; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_7_io_const_in_matrix_port_3; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_7_io_const_in_matrix_port_4; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_7_io_const_in_matrix_port_5; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_7_io_const_in_matrix_port_6; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_7_io_const_in_matrix_port_7; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_7_io_const_in_matrix_port_8; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_7_io_data_out; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_8_clock; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_8_reset; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_8_io_data_in_0; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_8_io_data_valid_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_8_io_const_in_matrix_port_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_8_io_const_in_matrix_port_1; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_8_io_const_in_matrix_port_2; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_8_io_const_in_matrix_port_3; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_8_io_const_in_matrix_port_4; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_8_io_const_in_matrix_port_5; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_8_io_const_in_matrix_port_6; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_8_io_const_in_matrix_port_7; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_8_io_const_in_matrix_port_8; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_8_io_data_out; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_9_clock; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_9_reset; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_9_io_data_in_0; // @[conv_cal.scala 48:66]
  wire  sliding_window_filter_9_io_data_valid_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_9_io_const_in_matrix_port_0; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_9_io_const_in_matrix_port_1; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_9_io_const_in_matrix_port_2; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_9_io_const_in_matrix_port_3; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_9_io_const_in_matrix_port_4; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_9_io_const_in_matrix_port_5; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_9_io_const_in_matrix_port_6; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_9_io_const_in_matrix_port_7; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_9_io_const_in_matrix_port_8; // @[conv_cal.scala 48:66]
  wire [15:0] sliding_window_filter_9_io_data_out; // @[conv_cal.scala 48:66]
  sliding_window_filter sliding_window_filter ( // @[conv_cal.scala 48:66]
    .clock(sliding_window_filter_clock),
    .reset(sliding_window_filter_reset),
    .io_data_in_0(sliding_window_filter_io_data_in_0),
    .io_data_valid_0(sliding_window_filter_io_data_valid_0),
    .io_const_in_matrix_port_0(sliding_window_filter_io_const_in_matrix_port_0),
    .io_const_in_matrix_port_1(sliding_window_filter_io_const_in_matrix_port_1),
    .io_const_in_matrix_port_2(sliding_window_filter_io_const_in_matrix_port_2),
    .io_const_in_matrix_port_3(sliding_window_filter_io_const_in_matrix_port_3),
    .io_const_in_matrix_port_4(sliding_window_filter_io_const_in_matrix_port_4),
    .io_const_in_matrix_port_5(sliding_window_filter_io_const_in_matrix_port_5),
    .io_const_in_matrix_port_6(sliding_window_filter_io_const_in_matrix_port_6),
    .io_const_in_matrix_port_7(sliding_window_filter_io_const_in_matrix_port_7),
    .io_const_in_matrix_port_8(sliding_window_filter_io_const_in_matrix_port_8),
    .io_data_out(sliding_window_filter_io_data_out)
  );
  sliding_window_filter sliding_window_filter_1 ( // @[conv_cal.scala 48:66]
    .clock(sliding_window_filter_1_clock),
    .reset(sliding_window_filter_1_reset),
    .io_data_in_0(sliding_window_filter_1_io_data_in_0),
    .io_data_valid_0(sliding_window_filter_1_io_data_valid_0),
    .io_const_in_matrix_port_0(sliding_window_filter_1_io_const_in_matrix_port_0),
    .io_const_in_matrix_port_1(sliding_window_filter_1_io_const_in_matrix_port_1),
    .io_const_in_matrix_port_2(sliding_window_filter_1_io_const_in_matrix_port_2),
    .io_const_in_matrix_port_3(sliding_window_filter_1_io_const_in_matrix_port_3),
    .io_const_in_matrix_port_4(sliding_window_filter_1_io_const_in_matrix_port_4),
    .io_const_in_matrix_port_5(sliding_window_filter_1_io_const_in_matrix_port_5),
    .io_const_in_matrix_port_6(sliding_window_filter_1_io_const_in_matrix_port_6),
    .io_const_in_matrix_port_7(sliding_window_filter_1_io_const_in_matrix_port_7),
    .io_const_in_matrix_port_8(sliding_window_filter_1_io_const_in_matrix_port_8),
    .io_data_out(sliding_window_filter_1_io_data_out)
  );
  sliding_window_filter sliding_window_filter_2 ( // @[conv_cal.scala 48:66]
    .clock(sliding_window_filter_2_clock),
    .reset(sliding_window_filter_2_reset),
    .io_data_in_0(sliding_window_filter_2_io_data_in_0),
    .io_data_valid_0(sliding_window_filter_2_io_data_valid_0),
    .io_const_in_matrix_port_0(sliding_window_filter_2_io_const_in_matrix_port_0),
    .io_const_in_matrix_port_1(sliding_window_filter_2_io_const_in_matrix_port_1),
    .io_const_in_matrix_port_2(sliding_window_filter_2_io_const_in_matrix_port_2),
    .io_const_in_matrix_port_3(sliding_window_filter_2_io_const_in_matrix_port_3),
    .io_const_in_matrix_port_4(sliding_window_filter_2_io_const_in_matrix_port_4),
    .io_const_in_matrix_port_5(sliding_window_filter_2_io_const_in_matrix_port_5),
    .io_const_in_matrix_port_6(sliding_window_filter_2_io_const_in_matrix_port_6),
    .io_const_in_matrix_port_7(sliding_window_filter_2_io_const_in_matrix_port_7),
    .io_const_in_matrix_port_8(sliding_window_filter_2_io_const_in_matrix_port_8),
    .io_data_out(sliding_window_filter_2_io_data_out)
  );
  sliding_window_filter sliding_window_filter_3 ( // @[conv_cal.scala 48:66]
    .clock(sliding_window_filter_3_clock),
    .reset(sliding_window_filter_3_reset),
    .io_data_in_0(sliding_window_filter_3_io_data_in_0),
    .io_data_valid_0(sliding_window_filter_3_io_data_valid_0),
    .io_const_in_matrix_port_0(sliding_window_filter_3_io_const_in_matrix_port_0),
    .io_const_in_matrix_port_1(sliding_window_filter_3_io_const_in_matrix_port_1),
    .io_const_in_matrix_port_2(sliding_window_filter_3_io_const_in_matrix_port_2),
    .io_const_in_matrix_port_3(sliding_window_filter_3_io_const_in_matrix_port_3),
    .io_const_in_matrix_port_4(sliding_window_filter_3_io_const_in_matrix_port_4),
    .io_const_in_matrix_port_5(sliding_window_filter_3_io_const_in_matrix_port_5),
    .io_const_in_matrix_port_6(sliding_window_filter_3_io_const_in_matrix_port_6),
    .io_const_in_matrix_port_7(sliding_window_filter_3_io_const_in_matrix_port_7),
    .io_const_in_matrix_port_8(sliding_window_filter_3_io_const_in_matrix_port_8),
    .io_data_out(sliding_window_filter_3_io_data_out)
  );
  sliding_window_filter sliding_window_filter_4 ( // @[conv_cal.scala 48:66]
    .clock(sliding_window_filter_4_clock),
    .reset(sliding_window_filter_4_reset),
    .io_data_in_0(sliding_window_filter_4_io_data_in_0),
    .io_data_valid_0(sliding_window_filter_4_io_data_valid_0),
    .io_const_in_matrix_port_0(sliding_window_filter_4_io_const_in_matrix_port_0),
    .io_const_in_matrix_port_1(sliding_window_filter_4_io_const_in_matrix_port_1),
    .io_const_in_matrix_port_2(sliding_window_filter_4_io_const_in_matrix_port_2),
    .io_const_in_matrix_port_3(sliding_window_filter_4_io_const_in_matrix_port_3),
    .io_const_in_matrix_port_4(sliding_window_filter_4_io_const_in_matrix_port_4),
    .io_const_in_matrix_port_5(sliding_window_filter_4_io_const_in_matrix_port_5),
    .io_const_in_matrix_port_6(sliding_window_filter_4_io_const_in_matrix_port_6),
    .io_const_in_matrix_port_7(sliding_window_filter_4_io_const_in_matrix_port_7),
    .io_const_in_matrix_port_8(sliding_window_filter_4_io_const_in_matrix_port_8),
    .io_data_out(sliding_window_filter_4_io_data_out)
  );
  sliding_window_filter sliding_window_filter_5 ( // @[conv_cal.scala 48:66]
    .clock(sliding_window_filter_5_clock),
    .reset(sliding_window_filter_5_reset),
    .io_data_in_0(sliding_window_filter_5_io_data_in_0),
    .io_data_valid_0(sliding_window_filter_5_io_data_valid_0),
    .io_const_in_matrix_port_0(sliding_window_filter_5_io_const_in_matrix_port_0),
    .io_const_in_matrix_port_1(sliding_window_filter_5_io_const_in_matrix_port_1),
    .io_const_in_matrix_port_2(sliding_window_filter_5_io_const_in_matrix_port_2),
    .io_const_in_matrix_port_3(sliding_window_filter_5_io_const_in_matrix_port_3),
    .io_const_in_matrix_port_4(sliding_window_filter_5_io_const_in_matrix_port_4),
    .io_const_in_matrix_port_5(sliding_window_filter_5_io_const_in_matrix_port_5),
    .io_const_in_matrix_port_6(sliding_window_filter_5_io_const_in_matrix_port_6),
    .io_const_in_matrix_port_7(sliding_window_filter_5_io_const_in_matrix_port_7),
    .io_const_in_matrix_port_8(sliding_window_filter_5_io_const_in_matrix_port_8),
    .io_data_out(sliding_window_filter_5_io_data_out)
  );
  sliding_window_filter sliding_window_filter_6 ( // @[conv_cal.scala 48:66]
    .clock(sliding_window_filter_6_clock),
    .reset(sliding_window_filter_6_reset),
    .io_data_in_0(sliding_window_filter_6_io_data_in_0),
    .io_data_valid_0(sliding_window_filter_6_io_data_valid_0),
    .io_const_in_matrix_port_0(sliding_window_filter_6_io_const_in_matrix_port_0),
    .io_const_in_matrix_port_1(sliding_window_filter_6_io_const_in_matrix_port_1),
    .io_const_in_matrix_port_2(sliding_window_filter_6_io_const_in_matrix_port_2),
    .io_const_in_matrix_port_3(sliding_window_filter_6_io_const_in_matrix_port_3),
    .io_const_in_matrix_port_4(sliding_window_filter_6_io_const_in_matrix_port_4),
    .io_const_in_matrix_port_5(sliding_window_filter_6_io_const_in_matrix_port_5),
    .io_const_in_matrix_port_6(sliding_window_filter_6_io_const_in_matrix_port_6),
    .io_const_in_matrix_port_7(sliding_window_filter_6_io_const_in_matrix_port_7),
    .io_const_in_matrix_port_8(sliding_window_filter_6_io_const_in_matrix_port_8),
    .io_data_out(sliding_window_filter_6_io_data_out)
  );
  sliding_window_filter sliding_window_filter_7 ( // @[conv_cal.scala 48:66]
    .clock(sliding_window_filter_7_clock),
    .reset(sliding_window_filter_7_reset),
    .io_data_in_0(sliding_window_filter_7_io_data_in_0),
    .io_data_valid_0(sliding_window_filter_7_io_data_valid_0),
    .io_const_in_matrix_port_0(sliding_window_filter_7_io_const_in_matrix_port_0),
    .io_const_in_matrix_port_1(sliding_window_filter_7_io_const_in_matrix_port_1),
    .io_const_in_matrix_port_2(sliding_window_filter_7_io_const_in_matrix_port_2),
    .io_const_in_matrix_port_3(sliding_window_filter_7_io_const_in_matrix_port_3),
    .io_const_in_matrix_port_4(sliding_window_filter_7_io_const_in_matrix_port_4),
    .io_const_in_matrix_port_5(sliding_window_filter_7_io_const_in_matrix_port_5),
    .io_const_in_matrix_port_6(sliding_window_filter_7_io_const_in_matrix_port_6),
    .io_const_in_matrix_port_7(sliding_window_filter_7_io_const_in_matrix_port_7),
    .io_const_in_matrix_port_8(sliding_window_filter_7_io_const_in_matrix_port_8),
    .io_data_out(sliding_window_filter_7_io_data_out)
  );
  sliding_window_filter sliding_window_filter_8 ( // @[conv_cal.scala 48:66]
    .clock(sliding_window_filter_8_clock),
    .reset(sliding_window_filter_8_reset),
    .io_data_in_0(sliding_window_filter_8_io_data_in_0),
    .io_data_valid_0(sliding_window_filter_8_io_data_valid_0),
    .io_const_in_matrix_port_0(sliding_window_filter_8_io_const_in_matrix_port_0),
    .io_const_in_matrix_port_1(sliding_window_filter_8_io_const_in_matrix_port_1),
    .io_const_in_matrix_port_2(sliding_window_filter_8_io_const_in_matrix_port_2),
    .io_const_in_matrix_port_3(sliding_window_filter_8_io_const_in_matrix_port_3),
    .io_const_in_matrix_port_4(sliding_window_filter_8_io_const_in_matrix_port_4),
    .io_const_in_matrix_port_5(sliding_window_filter_8_io_const_in_matrix_port_5),
    .io_const_in_matrix_port_6(sliding_window_filter_8_io_const_in_matrix_port_6),
    .io_const_in_matrix_port_7(sliding_window_filter_8_io_const_in_matrix_port_7),
    .io_const_in_matrix_port_8(sliding_window_filter_8_io_const_in_matrix_port_8),
    .io_data_out(sliding_window_filter_8_io_data_out)
  );
  sliding_window_filter sliding_window_filter_9 ( // @[conv_cal.scala 48:66]
    .clock(sliding_window_filter_9_clock),
    .reset(sliding_window_filter_9_reset),
    .io_data_in_0(sliding_window_filter_9_io_data_in_0),
    .io_data_valid_0(sliding_window_filter_9_io_data_valid_0),
    .io_const_in_matrix_port_0(sliding_window_filter_9_io_const_in_matrix_port_0),
    .io_const_in_matrix_port_1(sliding_window_filter_9_io_const_in_matrix_port_1),
    .io_const_in_matrix_port_2(sliding_window_filter_9_io_const_in_matrix_port_2),
    .io_const_in_matrix_port_3(sliding_window_filter_9_io_const_in_matrix_port_3),
    .io_const_in_matrix_port_4(sliding_window_filter_9_io_const_in_matrix_port_4),
    .io_const_in_matrix_port_5(sliding_window_filter_9_io_const_in_matrix_port_5),
    .io_const_in_matrix_port_6(sliding_window_filter_9_io_const_in_matrix_port_6),
    .io_const_in_matrix_port_7(sliding_window_filter_9_io_const_in_matrix_port_7),
    .io_const_in_matrix_port_8(sliding_window_filter_9_io_const_in_matrix_port_8),
    .io_data_out(sliding_window_filter_9_io_data_out)
  );
  assign io_data_out_0 = sliding_window_filter_io_data_out; // @[conv_cal.scala 48:{38,38}]
  assign io_data_out_1 = sliding_window_filter_1_io_data_out; // @[conv_cal.scala 48:{38,38}]
  assign io_data_out_2 = sliding_window_filter_2_io_data_out; // @[conv_cal.scala 48:{38,38}]
  assign io_data_out_3 = sliding_window_filter_3_io_data_out; // @[conv_cal.scala 48:{38,38}]
  assign io_data_out_4 = sliding_window_filter_4_io_data_out; // @[conv_cal.scala 48:{38,38}]
  assign io_data_out_5 = sliding_window_filter_5_io_data_out; // @[conv_cal.scala 48:{38,38}]
  assign io_data_out_6 = sliding_window_filter_6_io_data_out; // @[conv_cal.scala 48:{38,38}]
  assign io_data_out_7 = sliding_window_filter_7_io_data_out; // @[conv_cal.scala 48:{38,38}]
  assign io_data_out_8 = sliding_window_filter_8_io_data_out; // @[conv_cal.scala 48:{38,38}]
  assign io_data_out_9 = sliding_window_filter_9_io_data_out; // @[conv_cal.scala 48:{38,38}]
  assign io_conv_end_0 = 1'h0; // @[conv_cal.scala 55:28]
  assign io_conv_end_1 = 1'h0; // @[conv_cal.scala 55:28]
  assign io_conv_end_2 = 1'h0; // @[conv_cal.scala 55:28]
  assign io_conv_end_3 = 1'h0; // @[conv_cal.scala 55:28]
  assign io_conv_end_4 = 1'h0; // @[conv_cal.scala 55:28]
  assign io_conv_end_5 = 1'h0; // @[conv_cal.scala 55:28]
  assign io_conv_end_6 = 1'h0; // @[conv_cal.scala 55:28]
  assign io_conv_end_7 = 1'h0; // @[conv_cal.scala 55:28]
  assign io_conv_end_8 = 1'h0; // @[conv_cal.scala 55:28]
  assign io_conv_end_9 = 1'h0; // @[conv_cal.scala 55:28]
  assign io_io_out_data = 32'h0; // @[conv_cal.scala 56:28]
  assign sliding_window_filter_clock = clock;
  assign sliding_window_filter_reset = reset;
  assign sliding_window_filter_io_data_in_0 = io_data_in_0; // @[conv_cal.scala 48:38 50:19]
  assign sliding_window_filter_io_data_valid_0 = io_data_valid_0; // @[conv_cal.scala 48:38 53:22]
  assign sliding_window_filter_io_const_in_matrix_port_0 = io_const_in_0_matrix_port_0; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_io_const_in_matrix_port_1 = io_const_in_0_matrix_port_1; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_io_const_in_matrix_port_2 = io_const_in_0_matrix_port_2; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_io_const_in_matrix_port_3 = io_const_in_0_matrix_port_3; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_io_const_in_matrix_port_4 = io_const_in_0_matrix_port_4; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_io_const_in_matrix_port_5 = io_const_in_0_matrix_port_5; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_io_const_in_matrix_port_6 = io_const_in_0_matrix_port_6; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_io_const_in_matrix_port_7 = io_const_in_0_matrix_port_7; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_io_const_in_matrix_port_8 = io_const_in_0_matrix_port_8; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_1_clock = clock;
  assign sliding_window_filter_1_reset = reset;
  assign sliding_window_filter_1_io_data_in_0 = io_data_in_0; // @[conv_cal.scala 48:38 50:19]
  assign sliding_window_filter_1_io_data_valid_0 = io_data_valid_0; // @[conv_cal.scala 48:38 53:22]
  assign sliding_window_filter_1_io_const_in_matrix_port_0 = io_const_in_1_matrix_port_0; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_1_io_const_in_matrix_port_1 = io_const_in_1_matrix_port_1; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_1_io_const_in_matrix_port_2 = io_const_in_1_matrix_port_2; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_1_io_const_in_matrix_port_3 = io_const_in_1_matrix_port_3; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_1_io_const_in_matrix_port_4 = io_const_in_1_matrix_port_4; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_1_io_const_in_matrix_port_5 = io_const_in_1_matrix_port_5; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_1_io_const_in_matrix_port_6 = io_const_in_1_matrix_port_6; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_1_io_const_in_matrix_port_7 = io_const_in_1_matrix_port_7; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_1_io_const_in_matrix_port_8 = io_const_in_1_matrix_port_8; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_2_clock = clock;
  assign sliding_window_filter_2_reset = reset;
  assign sliding_window_filter_2_io_data_in_0 = io_data_in_0; // @[conv_cal.scala 48:38 50:19]
  assign sliding_window_filter_2_io_data_valid_0 = io_data_valid_0; // @[conv_cal.scala 48:38 53:22]
  assign sliding_window_filter_2_io_const_in_matrix_port_0 = io_const_in_2_matrix_port_0; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_2_io_const_in_matrix_port_1 = io_const_in_2_matrix_port_1; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_2_io_const_in_matrix_port_2 = io_const_in_2_matrix_port_2; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_2_io_const_in_matrix_port_3 = io_const_in_2_matrix_port_3; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_2_io_const_in_matrix_port_4 = io_const_in_2_matrix_port_4; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_2_io_const_in_matrix_port_5 = io_const_in_2_matrix_port_5; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_2_io_const_in_matrix_port_6 = io_const_in_2_matrix_port_6; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_2_io_const_in_matrix_port_7 = io_const_in_2_matrix_port_7; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_2_io_const_in_matrix_port_8 = io_const_in_2_matrix_port_8; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_3_clock = clock;
  assign sliding_window_filter_3_reset = reset;
  assign sliding_window_filter_3_io_data_in_0 = io_data_in_0; // @[conv_cal.scala 48:38 50:19]
  assign sliding_window_filter_3_io_data_valid_0 = io_data_valid_0; // @[conv_cal.scala 48:38 53:22]
  assign sliding_window_filter_3_io_const_in_matrix_port_0 = io_const_in_3_matrix_port_0; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_3_io_const_in_matrix_port_1 = io_const_in_3_matrix_port_1; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_3_io_const_in_matrix_port_2 = io_const_in_3_matrix_port_2; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_3_io_const_in_matrix_port_3 = io_const_in_3_matrix_port_3; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_3_io_const_in_matrix_port_4 = io_const_in_3_matrix_port_4; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_3_io_const_in_matrix_port_5 = io_const_in_3_matrix_port_5; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_3_io_const_in_matrix_port_6 = io_const_in_3_matrix_port_6; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_3_io_const_in_matrix_port_7 = io_const_in_3_matrix_port_7; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_3_io_const_in_matrix_port_8 = io_const_in_3_matrix_port_8; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_4_clock = clock;
  assign sliding_window_filter_4_reset = reset;
  assign sliding_window_filter_4_io_data_in_0 = io_data_in_0; // @[conv_cal.scala 48:38 50:19]
  assign sliding_window_filter_4_io_data_valid_0 = io_data_valid_0; // @[conv_cal.scala 48:38 53:22]
  assign sliding_window_filter_4_io_const_in_matrix_port_0 = io_const_in_4_matrix_port_0; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_4_io_const_in_matrix_port_1 = io_const_in_4_matrix_port_1; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_4_io_const_in_matrix_port_2 = io_const_in_4_matrix_port_2; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_4_io_const_in_matrix_port_3 = io_const_in_4_matrix_port_3; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_4_io_const_in_matrix_port_4 = io_const_in_4_matrix_port_4; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_4_io_const_in_matrix_port_5 = io_const_in_4_matrix_port_5; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_4_io_const_in_matrix_port_6 = io_const_in_4_matrix_port_6; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_4_io_const_in_matrix_port_7 = io_const_in_4_matrix_port_7; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_4_io_const_in_matrix_port_8 = io_const_in_4_matrix_port_8; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_5_clock = clock;
  assign sliding_window_filter_5_reset = reset;
  assign sliding_window_filter_5_io_data_in_0 = io_data_in_0; // @[conv_cal.scala 48:38 50:19]
  assign sliding_window_filter_5_io_data_valid_0 = io_data_valid_0; // @[conv_cal.scala 48:38 53:22]
  assign sliding_window_filter_5_io_const_in_matrix_port_0 = io_const_in_5_matrix_port_0; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_5_io_const_in_matrix_port_1 = io_const_in_5_matrix_port_1; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_5_io_const_in_matrix_port_2 = io_const_in_5_matrix_port_2; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_5_io_const_in_matrix_port_3 = io_const_in_5_matrix_port_3; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_5_io_const_in_matrix_port_4 = io_const_in_5_matrix_port_4; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_5_io_const_in_matrix_port_5 = io_const_in_5_matrix_port_5; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_5_io_const_in_matrix_port_6 = io_const_in_5_matrix_port_6; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_5_io_const_in_matrix_port_7 = io_const_in_5_matrix_port_7; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_5_io_const_in_matrix_port_8 = io_const_in_5_matrix_port_8; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_6_clock = clock;
  assign sliding_window_filter_6_reset = reset;
  assign sliding_window_filter_6_io_data_in_0 = io_data_in_0; // @[conv_cal.scala 48:38 50:19]
  assign sliding_window_filter_6_io_data_valid_0 = io_data_valid_0; // @[conv_cal.scala 48:38 53:22]
  assign sliding_window_filter_6_io_const_in_matrix_port_0 = io_const_in_6_matrix_port_0; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_6_io_const_in_matrix_port_1 = io_const_in_6_matrix_port_1; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_6_io_const_in_matrix_port_2 = io_const_in_6_matrix_port_2; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_6_io_const_in_matrix_port_3 = io_const_in_6_matrix_port_3; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_6_io_const_in_matrix_port_4 = io_const_in_6_matrix_port_4; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_6_io_const_in_matrix_port_5 = io_const_in_6_matrix_port_5; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_6_io_const_in_matrix_port_6 = io_const_in_6_matrix_port_6; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_6_io_const_in_matrix_port_7 = io_const_in_6_matrix_port_7; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_6_io_const_in_matrix_port_8 = io_const_in_6_matrix_port_8; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_7_clock = clock;
  assign sliding_window_filter_7_reset = reset;
  assign sliding_window_filter_7_io_data_in_0 = io_data_in_0; // @[conv_cal.scala 48:38 50:19]
  assign sliding_window_filter_7_io_data_valid_0 = io_data_valid_0; // @[conv_cal.scala 48:38 53:22]
  assign sliding_window_filter_7_io_const_in_matrix_port_0 = io_const_in_7_matrix_port_0; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_7_io_const_in_matrix_port_1 = io_const_in_7_matrix_port_1; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_7_io_const_in_matrix_port_2 = io_const_in_7_matrix_port_2; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_7_io_const_in_matrix_port_3 = io_const_in_7_matrix_port_3; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_7_io_const_in_matrix_port_4 = io_const_in_7_matrix_port_4; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_7_io_const_in_matrix_port_5 = io_const_in_7_matrix_port_5; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_7_io_const_in_matrix_port_6 = io_const_in_7_matrix_port_6; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_7_io_const_in_matrix_port_7 = io_const_in_7_matrix_port_7; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_7_io_const_in_matrix_port_8 = io_const_in_7_matrix_port_8; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_8_clock = clock;
  assign sliding_window_filter_8_reset = reset;
  assign sliding_window_filter_8_io_data_in_0 = io_data_in_0; // @[conv_cal.scala 48:38 50:19]
  assign sliding_window_filter_8_io_data_valid_0 = io_data_valid_0; // @[conv_cal.scala 48:38 53:22]
  assign sliding_window_filter_8_io_const_in_matrix_port_0 = io_const_in_8_matrix_port_0; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_8_io_const_in_matrix_port_1 = io_const_in_8_matrix_port_1; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_8_io_const_in_matrix_port_2 = io_const_in_8_matrix_port_2; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_8_io_const_in_matrix_port_3 = io_const_in_8_matrix_port_3; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_8_io_const_in_matrix_port_4 = io_const_in_8_matrix_port_4; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_8_io_const_in_matrix_port_5 = io_const_in_8_matrix_port_5; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_8_io_const_in_matrix_port_6 = io_const_in_8_matrix_port_6; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_8_io_const_in_matrix_port_7 = io_const_in_8_matrix_port_7; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_8_io_const_in_matrix_port_8 = io_const_in_8_matrix_port_8; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_9_clock = clock;
  assign sliding_window_filter_9_reset = reset;
  assign sliding_window_filter_9_io_data_in_0 = io_data_in_0; // @[conv_cal.scala 48:38 50:19]
  assign sliding_window_filter_9_io_data_valid_0 = io_data_valid_0; // @[conv_cal.scala 48:38 53:22]
  assign sliding_window_filter_9_io_const_in_matrix_port_0 = io_const_in_9_matrix_port_0; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_9_io_const_in_matrix_port_1 = io_const_in_9_matrix_port_1; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_9_io_const_in_matrix_port_2 = io_const_in_9_matrix_port_2; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_9_io_const_in_matrix_port_3 = io_const_in_9_matrix_port_3; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_9_io_const_in_matrix_port_4 = io_const_in_9_matrix_port_4; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_9_io_const_in_matrix_port_5 = io_const_in_9_matrix_port_5; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_9_io_const_in_matrix_port_6 = io_const_in_9_matrix_port_6; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_9_io_const_in_matrix_port_7 = io_const_in_9_matrix_port_7; // @[conv_cal.scala 48:38 51:20]
  assign sliding_window_filter_9_io_const_in_matrix_port_8 = io_const_in_9_matrix_port_8; // @[conv_cal.scala 48:38 51:20]
endmodule
