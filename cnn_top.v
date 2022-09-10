module cnn_top(
  input         clock,
  input         reset,
  input  [15:0] io_matrix_input_matrix_port_0,
  input  [15:0] io_matrix_input_matrix_port_1,
  input  [15:0] io_matrix_input_matrix_port_2,
  input  [15:0] io_matrix_input_matrix_port_3,
  input  [15:0] io_matrix_input_matrix_port_4,
  input  [15:0] io_matrix_input_matrix_port_5,
  input  [15:0] io_matrix_input_matrix_port_6,
  input  [15:0] io_matrix_input_matrix_port_7,
  input  [15:0] io_matrix_input_matrix_port_8,
  input  [15:0] io_matrix_const_matrix_port_0,
  input  [15:0] io_matrix_const_matrix_port_1,
  input  [15:0] io_matrix_const_matrix_port_2,
  input  [15:0] io_matrix_const_matrix_port_3,
  input  [15:0] io_matrix_const_matrix_port_4,
  input  [15:0] io_matrix_const_matrix_port_5,
  input  [15:0] io_matrix_const_matrix_port_6,
  input  [15:0] io_matrix_const_matrix_port_7,
  input  [15:0] io_matrix_const_matrix_port_8,
  output [15:0] io_matrix_output
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
`endif // RANDOMIZE_REG_INIT
  reg [15:0] io_matrix_output_mul_data_reg_0; // @[basic_macro.scala 36:71]
  reg [15:0] io_matrix_output_mul_data_reg_1; // @[basic_macro.scala 36:71]
  reg [15:0] io_matrix_output_mul_data_reg_2; // @[basic_macro.scala 36:71]
  reg [15:0] io_matrix_output_mul_data_reg_3; // @[basic_macro.scala 36:71]
  reg [15:0] io_matrix_output_mul_data_reg_4; // @[basic_macro.scala 36:71]
  reg [15:0] io_matrix_output_mul_data_reg_5; // @[basic_macro.scala 36:71]
  reg [15:0] io_matrix_output_mul_data_reg_6; // @[basic_macro.scala 36:71]
  reg [15:0] io_matrix_output_mul_data_reg_7; // @[basic_macro.scala 36:71]
  reg [15:0] io_matrix_output_mul_data_reg_8; // @[basic_macro.scala 36:71]
  wire [31:0] _io_matrix_output_mul_data_reg_0_T = $signed(io_matrix_input_matrix_port_0) * $signed(
    io_matrix_const_matrix_port_0); // @[basic_macro.scala 38:38]
  wire [31:0] _io_matrix_output_mul_data_reg_1_T = $signed(io_matrix_input_matrix_port_1) * $signed(
    io_matrix_const_matrix_port_1); // @[basic_macro.scala 38:38]
  wire [31:0] _io_matrix_output_mul_data_reg_2_T = $signed(io_matrix_input_matrix_port_2) * $signed(
    io_matrix_const_matrix_port_2); // @[basic_macro.scala 38:38]
  wire [31:0] _io_matrix_output_mul_data_reg_3_T = $signed(io_matrix_input_matrix_port_3) * $signed(
    io_matrix_const_matrix_port_3); // @[basic_macro.scala 38:38]
  wire [31:0] _io_matrix_output_mul_data_reg_4_T = $signed(io_matrix_input_matrix_port_4) * $signed(
    io_matrix_const_matrix_port_4); // @[basic_macro.scala 38:38]
  wire [31:0] _io_matrix_output_mul_data_reg_5_T = $signed(io_matrix_input_matrix_port_5) * $signed(
    io_matrix_const_matrix_port_5); // @[basic_macro.scala 38:38]
  wire [31:0] _io_matrix_output_mul_data_reg_6_T = $signed(io_matrix_input_matrix_port_6) * $signed(
    io_matrix_const_matrix_port_6); // @[basic_macro.scala 38:38]
  wire [31:0] _io_matrix_output_mul_data_reg_7_T = $signed(io_matrix_input_matrix_port_7) * $signed(
    io_matrix_const_matrix_port_7); // @[basic_macro.scala 38:38]
  wire [31:0] _io_matrix_output_mul_data_reg_8_T = $signed(io_matrix_input_matrix_port_8) * $signed(
    io_matrix_const_matrix_port_8); // @[basic_macro.scala 38:38]
  reg [15:0] io_matrix_output_REG; // @[basic_macro.scala 28:20]
  reg [15:0] io_matrix_output_REG_1; // @[basic_macro.scala 28:20]
  reg [15:0] io_matrix_output_REG_2; // @[basic_macro.scala 30:20]
  reg [15:0] io_matrix_output_REG_3; // @[basic_macro.scala 32:20]
  reg [15:0] io_matrix_output_REG_4; // @[basic_macro.scala 32:20]
  reg [15:0] io_matrix_output_REG_5; // @[basic_macro.scala 30:20]
  reg [15:0] io_matrix_output_REG_6; // @[basic_macro.scala 28:20]
  reg [15:0] io_matrix_output_REG_7; // @[basic_macro.scala 30:20]
  reg [15:0] io_matrix_output_REG_8; // @[basic_macro.scala 32:20]
  reg [15:0] io_matrix_output_REG_9; // @[basic_macro.scala 32:20]
  reg [15:0] io_matrix_output_REG_10; // @[basic_macro.scala 32:20]
  wire [23:0] _GEN_0 = reset ? $signed(24'sh0) : $signed(_io_matrix_output_mul_data_reg_0_T[31:8]); // @[basic_macro.scala 36:{71,71} 38:33]
  wire [23:0] _GEN_2 = reset ? $signed(24'sh0) : $signed(_io_matrix_output_mul_data_reg_1_T[31:8]); // @[basic_macro.scala 36:{71,71} 38:33]
  wire [23:0] _GEN_4 = reset ? $signed(24'sh0) : $signed(_io_matrix_output_mul_data_reg_2_T[31:8]); // @[basic_macro.scala 36:{71,71} 38:33]
  wire [23:0] _GEN_6 = reset ? $signed(24'sh0) : $signed(_io_matrix_output_mul_data_reg_3_T[31:8]); // @[basic_macro.scala 36:{71,71} 38:33]
  wire [23:0] _GEN_8 = reset ? $signed(24'sh0) : $signed(_io_matrix_output_mul_data_reg_4_T[31:8]); // @[basic_macro.scala 36:{71,71} 38:33]
  wire [23:0] _GEN_10 = reset ? $signed(24'sh0) : $signed(_io_matrix_output_mul_data_reg_5_T[31:8]); // @[basic_macro.scala 36:{71,71} 38:33]
  wire [23:0] _GEN_12 = reset ? $signed(24'sh0) : $signed(_io_matrix_output_mul_data_reg_6_T[31:8]); // @[basic_macro.scala 36:{71,71} 38:33]
  wire [23:0] _GEN_14 = reset ? $signed(24'sh0) : $signed(_io_matrix_output_mul_data_reg_7_T[31:8]); // @[basic_macro.scala 36:{71,71} 38:33]
  wire [23:0] _GEN_16 = reset ? $signed(24'sh0) : $signed(_io_matrix_output_mul_data_reg_8_T[31:8]); // @[basic_macro.scala 36:{71,71} 38:33]
  assign io_matrix_output = io_matrix_output_REG_10; // @[cnn_top.scala 15:22]
  always @(posedge clock) begin
    io_matrix_output_mul_data_reg_0 <= _GEN_0[15:0]; // @[basic_macro.scala 36:{71,71} 38:33]
    io_matrix_output_mul_data_reg_1 <= _GEN_2[15:0]; // @[basic_macro.scala 36:{71,71} 38:33]
    io_matrix_output_mul_data_reg_2 <= _GEN_4[15:0]; // @[basic_macro.scala 36:{71,71} 38:33]
    io_matrix_output_mul_data_reg_3 <= _GEN_6[15:0]; // @[basic_macro.scala 36:{71,71} 38:33]
    io_matrix_output_mul_data_reg_4 <= _GEN_8[15:0]; // @[basic_macro.scala 36:{71,71} 38:33]
    io_matrix_output_mul_data_reg_5 <= _GEN_10[15:0]; // @[basic_macro.scala 36:{71,71} 38:33]
    io_matrix_output_mul_data_reg_6 <= _GEN_12[15:0]; // @[basic_macro.scala 36:{71,71} 38:33]
    io_matrix_output_mul_data_reg_7 <= _GEN_14[15:0]; // @[basic_macro.scala 36:{71,71} 38:33]
    io_matrix_output_mul_data_reg_8 <= _GEN_16[15:0]; // @[basic_macro.scala 36:{71,71} 38:33]
    io_matrix_output_REG <= io_matrix_output_mul_data_reg_0; // @[basic_macro.scala 28:20]
    io_matrix_output_REG_1 <= io_matrix_output_mul_data_reg_1; // @[basic_macro.scala 28:20]
    io_matrix_output_REG_2 <= $signed(io_matrix_output_mul_data_reg_2) + $signed(io_matrix_output_mul_data_reg_3); // @[basic_macro.scala 40:64]
    io_matrix_output_REG_3 <= $signed(io_matrix_output_REG_1) + $signed(io_matrix_output_REG_2); // @[basic_macro.scala 40:64]
    io_matrix_output_REG_4 <= $signed(io_matrix_output_REG) + $signed(io_matrix_output_REG_3); // @[basic_macro.scala 40:64]
    io_matrix_output_REG_5 <= $signed(io_matrix_output_mul_data_reg_4) + $signed(io_matrix_output_mul_data_reg_5); // @[basic_macro.scala 40:64]
    io_matrix_output_REG_6 <= io_matrix_output_mul_data_reg_6; // @[basic_macro.scala 28:20]
    io_matrix_output_REG_7 <= $signed(io_matrix_output_mul_data_reg_7) + $signed(io_matrix_output_mul_data_reg_8); // @[basic_macro.scala 40:64]
    io_matrix_output_REG_8 <= $signed(io_matrix_output_REG_6) + $signed(io_matrix_output_REG_7); // @[basic_macro.scala 40:64]
    io_matrix_output_REG_9 <= $signed(io_matrix_output_REG_5) + $signed(io_matrix_output_REG_8); // @[basic_macro.scala 40:64]
    io_matrix_output_REG_10 <= $signed(io_matrix_output_REG_4) + $signed(io_matrix_output_REG_9); // @[basic_macro.scala 40:64]
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
  io_matrix_output_mul_data_reg_0 = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  io_matrix_output_mul_data_reg_1 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  io_matrix_output_mul_data_reg_2 = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  io_matrix_output_mul_data_reg_3 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  io_matrix_output_mul_data_reg_4 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  io_matrix_output_mul_data_reg_5 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  io_matrix_output_mul_data_reg_6 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  io_matrix_output_mul_data_reg_7 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  io_matrix_output_mul_data_reg_8 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  io_matrix_output_REG = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  io_matrix_output_REG_1 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  io_matrix_output_REG_2 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  io_matrix_output_REG_3 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  io_matrix_output_REG_4 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  io_matrix_output_REG_5 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  io_matrix_output_REG_6 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  io_matrix_output_REG_7 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  io_matrix_output_REG_8 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  io_matrix_output_REG_9 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  io_matrix_output_REG_10 = _RAND_19[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
