circuit cnn_top :
  module cnn_top :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip matrix_input : { matrix_port : Fixed<16><<8>>[9]}, flip matrix_const : { matrix_port : Fixed<16><<8>>[9]}, matrix_output : Fixed<16><<8>>}

    reg io_matrix_output_mul_data_reg_0 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 36:71]
    reg io_matrix_output_mul_data_reg_1 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 36:71]
    reg io_matrix_output_mul_data_reg_2 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 36:71]
    reg io_matrix_output_mul_data_reg_3 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 36:71]
    reg io_matrix_output_mul_data_reg_4 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 36:71]
    reg io_matrix_output_mul_data_reg_5 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 36:71]
    reg io_matrix_output_mul_data_reg_6 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 36:71]
    reg io_matrix_output_mul_data_reg_7 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 36:71]
    reg io_matrix_output_mul_data_reg_8 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 36:71]
    node _io_matrix_output_mul_data_reg_0_T = mul(io.matrix_input.matrix_port[0], io.matrix_const.matrix_port[0]) @[basic_macro.scala 38:38]
    io_matrix_output_mul_data_reg_0 <= _io_matrix_output_mul_data_reg_0_T @[basic_macro.scala 38:33]
    node _io_matrix_output_mul_data_reg_1_T = mul(io.matrix_input.matrix_port[1], io.matrix_const.matrix_port[1]) @[basic_macro.scala 38:38]
    io_matrix_output_mul_data_reg_1 <= _io_matrix_output_mul_data_reg_1_T @[basic_macro.scala 38:33]
    node _io_matrix_output_mul_data_reg_2_T = mul(io.matrix_input.matrix_port[2], io.matrix_const.matrix_port[2]) @[basic_macro.scala 38:38]
    io_matrix_output_mul_data_reg_2 <= _io_matrix_output_mul_data_reg_2_T @[basic_macro.scala 38:33]
    node _io_matrix_output_mul_data_reg_3_T = mul(io.matrix_input.matrix_port[3], io.matrix_const.matrix_port[3]) @[basic_macro.scala 38:38]
    io_matrix_output_mul_data_reg_3 <= _io_matrix_output_mul_data_reg_3_T @[basic_macro.scala 38:33]
    node _io_matrix_output_mul_data_reg_4_T = mul(io.matrix_input.matrix_port[4], io.matrix_const.matrix_port[4]) @[basic_macro.scala 38:38]
    io_matrix_output_mul_data_reg_4 <= _io_matrix_output_mul_data_reg_4_T @[basic_macro.scala 38:33]
    node _io_matrix_output_mul_data_reg_5_T = mul(io.matrix_input.matrix_port[5], io.matrix_const.matrix_port[5]) @[basic_macro.scala 38:38]
    io_matrix_output_mul_data_reg_5 <= _io_matrix_output_mul_data_reg_5_T @[basic_macro.scala 38:33]
    node _io_matrix_output_mul_data_reg_6_T = mul(io.matrix_input.matrix_port[6], io.matrix_const.matrix_port[6]) @[basic_macro.scala 38:38]
    io_matrix_output_mul_data_reg_6 <= _io_matrix_output_mul_data_reg_6_T @[basic_macro.scala 38:33]
    node _io_matrix_output_mul_data_reg_7_T = mul(io.matrix_input.matrix_port[7], io.matrix_const.matrix_port[7]) @[basic_macro.scala 38:38]
    io_matrix_output_mul_data_reg_7 <= _io_matrix_output_mul_data_reg_7_T @[basic_macro.scala 38:33]
    node _io_matrix_output_mul_data_reg_8_T = mul(io.matrix_input.matrix_port[8], io.matrix_const.matrix_port[8]) @[basic_macro.scala 38:38]
    io_matrix_output_mul_data_reg_8 <= _io_matrix_output_mul_data_reg_8_T @[basic_macro.scala 38:33]
    reg io_matrix_output_REG : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_matrix_output_REG) @[basic_macro.scala 28:20]
    io_matrix_output_REG <= io_matrix_output_mul_data_reg_0 @[basic_macro.scala 28:20]
    reg io_matrix_output_REG_1 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_matrix_output_REG_1) @[basic_macro.scala 28:20]
    io_matrix_output_REG_1 <= io_matrix_output_mul_data_reg_1 @[basic_macro.scala 28:20]
    node _io_matrix_output_T = add(io_matrix_output_mul_data_reg_2, io_matrix_output_mul_data_reg_3) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_1 = tail(_io_matrix_output_T, 1) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_2 = asFixedPoint(_io_matrix_output_T_1, 8) @[basic_macro.scala 40:64]
    reg io_matrix_output_REG_2 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_matrix_output_REG_2) @[basic_macro.scala 30:20]
    io_matrix_output_REG_2 <= _io_matrix_output_T_2 @[basic_macro.scala 30:20]
    node _io_matrix_output_T_3 = add(io_matrix_output_REG_1, io_matrix_output_REG_2) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_4 = tail(_io_matrix_output_T_3, 1) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_5 = asFixedPoint(_io_matrix_output_T_4, 8) @[basic_macro.scala 40:64]
    reg io_matrix_output_REG_3 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_matrix_output_REG_3) @[basic_macro.scala 32:20]
    io_matrix_output_REG_3 <= _io_matrix_output_T_5 @[basic_macro.scala 32:20]
    node _io_matrix_output_T_6 = add(io_matrix_output_REG, io_matrix_output_REG_3) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_7 = tail(_io_matrix_output_T_6, 1) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_8 = asFixedPoint(_io_matrix_output_T_7, 8) @[basic_macro.scala 40:64]
    reg io_matrix_output_REG_4 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_matrix_output_REG_4) @[basic_macro.scala 32:20]
    io_matrix_output_REG_4 <= _io_matrix_output_T_8 @[basic_macro.scala 32:20]
    node _io_matrix_output_T_9 = add(io_matrix_output_mul_data_reg_4, io_matrix_output_mul_data_reg_5) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_10 = tail(_io_matrix_output_T_9, 1) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_11 = asFixedPoint(_io_matrix_output_T_10, 8) @[basic_macro.scala 40:64]
    reg io_matrix_output_REG_5 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_matrix_output_REG_5) @[basic_macro.scala 30:20]
    io_matrix_output_REG_5 <= _io_matrix_output_T_11 @[basic_macro.scala 30:20]
    reg io_matrix_output_REG_6 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_matrix_output_REG_6) @[basic_macro.scala 28:20]
    io_matrix_output_REG_6 <= io_matrix_output_mul_data_reg_6 @[basic_macro.scala 28:20]
    node _io_matrix_output_T_12 = add(io_matrix_output_mul_data_reg_7, io_matrix_output_mul_data_reg_8) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_13 = tail(_io_matrix_output_T_12, 1) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_14 = asFixedPoint(_io_matrix_output_T_13, 8) @[basic_macro.scala 40:64]
    reg io_matrix_output_REG_7 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_matrix_output_REG_7) @[basic_macro.scala 30:20]
    io_matrix_output_REG_7 <= _io_matrix_output_T_14 @[basic_macro.scala 30:20]
    node _io_matrix_output_T_15 = add(io_matrix_output_REG_6, io_matrix_output_REG_7) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_16 = tail(_io_matrix_output_T_15, 1) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_17 = asFixedPoint(_io_matrix_output_T_16, 8) @[basic_macro.scala 40:64]
    reg io_matrix_output_REG_8 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_matrix_output_REG_8) @[basic_macro.scala 32:20]
    io_matrix_output_REG_8 <= _io_matrix_output_T_17 @[basic_macro.scala 32:20]
    node _io_matrix_output_T_18 = add(io_matrix_output_REG_5, io_matrix_output_REG_8) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_19 = tail(_io_matrix_output_T_18, 1) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_20 = asFixedPoint(_io_matrix_output_T_19, 8) @[basic_macro.scala 40:64]
    reg io_matrix_output_REG_9 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_matrix_output_REG_9) @[basic_macro.scala 32:20]
    io_matrix_output_REG_9 <= _io_matrix_output_T_20 @[basic_macro.scala 32:20]
    node _io_matrix_output_T_21 = add(io_matrix_output_REG_4, io_matrix_output_REG_9) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_22 = tail(_io_matrix_output_T_21, 1) @[basic_macro.scala 40:64]
    node _io_matrix_output_T_23 = asFixedPoint(_io_matrix_output_T_22, 8) @[basic_macro.scala 40:64]
    reg io_matrix_output_REG_10 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_matrix_output_REG_10) @[basic_macro.scala 32:20]
    io_matrix_output_REG_10 <= _io_matrix_output_T_23 @[basic_macro.scala 32:20]
    io.matrix_output <= io_matrix_output_REG_10 @[cnn_top.scala 15:22]

