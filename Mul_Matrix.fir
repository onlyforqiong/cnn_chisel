circuit Mul_Matrix :
  module Mul_Matrix :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : { matrix_port : Fixed<16><<8>>[9]}, flip valid : UInt<1>, out : Fixed<16><<8>>, flip consts : { matrix_port : Fixed<16><<8>>[9]}}

    reg io_out_mul_data_reg_0 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_out_mul_data_reg_1 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_out_mul_data_reg_2 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_out_mul_data_reg_3 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_out_mul_data_reg_4 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_out_mul_data_reg_5 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_out_mul_data_reg_6 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_out_mul_data_reg_7 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_out_mul_data_reg_8 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    node _io_out_mul_data_reg_0_T = mul(io.in.matrix_port[0], io.consts.matrix_port[0]) @[basic_macro.scala 43:38]
    io_out_mul_data_reg_0 <= _io_out_mul_data_reg_0_T @[basic_macro.scala 43:33]
    node _io_out_mul_data_reg_1_T = mul(io.in.matrix_port[1], io.consts.matrix_port[1]) @[basic_macro.scala 43:38]
    io_out_mul_data_reg_1 <= _io_out_mul_data_reg_1_T @[basic_macro.scala 43:33]
    node _io_out_mul_data_reg_2_T = mul(io.in.matrix_port[2], io.consts.matrix_port[2]) @[basic_macro.scala 43:38]
    io_out_mul_data_reg_2 <= _io_out_mul_data_reg_2_T @[basic_macro.scala 43:33]
    node _io_out_mul_data_reg_3_T = mul(io.in.matrix_port[3], io.consts.matrix_port[3]) @[basic_macro.scala 43:38]
    io_out_mul_data_reg_3 <= _io_out_mul_data_reg_3_T @[basic_macro.scala 43:33]
    node _io_out_mul_data_reg_4_T = mul(io.in.matrix_port[4], io.consts.matrix_port[4]) @[basic_macro.scala 43:38]
    io_out_mul_data_reg_4 <= _io_out_mul_data_reg_4_T @[basic_macro.scala 43:33]
    node _io_out_mul_data_reg_5_T = mul(io.in.matrix_port[5], io.consts.matrix_port[5]) @[basic_macro.scala 43:38]
    io_out_mul_data_reg_5 <= _io_out_mul_data_reg_5_T @[basic_macro.scala 43:33]
    node _io_out_mul_data_reg_6_T = mul(io.in.matrix_port[6], io.consts.matrix_port[6]) @[basic_macro.scala 43:38]
    io_out_mul_data_reg_6 <= _io_out_mul_data_reg_6_T @[basic_macro.scala 43:33]
    node _io_out_mul_data_reg_7_T = mul(io.in.matrix_port[7], io.consts.matrix_port[7]) @[basic_macro.scala 43:38]
    io_out_mul_data_reg_7 <= _io_out_mul_data_reg_7_T @[basic_macro.scala 43:33]
    node _io_out_mul_data_reg_8_T = mul(io.in.matrix_port[8], io.consts.matrix_port[8]) @[basic_macro.scala 43:38]
    io_out_mul_data_reg_8 <= _io_out_mul_data_reg_8_T @[basic_macro.scala 43:33]
    reg io_out_REG : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_out_REG) @[basic_macro.scala 28:21]
    io_out_REG <= io_out_mul_data_reg_0 @[basic_macro.scala 28:21]
    reg io_out_REG_1 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_out_REG_1) @[basic_macro.scala 28:21]
    io_out_REG_1 <= io_out_mul_data_reg_1 @[basic_macro.scala 28:21]
    node _io_out_T = add(io_out_mul_data_reg_2, io_out_mul_data_reg_3) @[basic_macro.scala 37:60]
    node _io_out_T_1 = tail(_io_out_T, 1) @[basic_macro.scala 37:60]
    node _io_out_T_2 = asFixedPoint(_io_out_T_1, 8) @[basic_macro.scala 37:60]
    reg io_out_REG_2 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_out_REG_2) @[basic_macro.scala 31:21]
    io_out_REG_2 <= _io_out_T_2 @[basic_macro.scala 31:21]
    node _io_out_T_3 = add(io_out_REG_1, io_out_REG_2) @[basic_macro.scala 37:60]
    node _io_out_T_4 = tail(_io_out_T_3, 1) @[basic_macro.scala 37:60]
    node _io_out_T_5 = asFixedPoint(_io_out_T_4, 8) @[basic_macro.scala 37:60]
    reg io_out_REG_3 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_out_REG_3) @[basic_macro.scala 33:20]
    io_out_REG_3 <= _io_out_T_5 @[basic_macro.scala 33:20]
    node _io_out_T_6 = add(io_out_REG, io_out_REG_3) @[basic_macro.scala 37:60]
    node _io_out_T_7 = tail(_io_out_T_6, 1) @[basic_macro.scala 37:60]
    node _io_out_T_8 = asFixedPoint(_io_out_T_7, 8) @[basic_macro.scala 37:60]
    reg io_out_REG_4 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_out_REG_4) @[basic_macro.scala 33:20]
    io_out_REG_4 <= _io_out_T_8 @[basic_macro.scala 33:20]
    node _io_out_T_9 = add(io_out_mul_data_reg_4, io_out_mul_data_reg_5) @[basic_macro.scala 37:60]
    node _io_out_T_10 = tail(_io_out_T_9, 1) @[basic_macro.scala 37:60]
    node _io_out_T_11 = asFixedPoint(_io_out_T_10, 8) @[basic_macro.scala 37:60]
    reg io_out_REG_5 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_out_REG_5) @[basic_macro.scala 31:21]
    io_out_REG_5 <= _io_out_T_11 @[basic_macro.scala 31:21]
    reg io_out_REG_6 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_out_REG_6) @[basic_macro.scala 28:21]
    io_out_REG_6 <= io_out_mul_data_reg_6 @[basic_macro.scala 28:21]
    node _io_out_T_12 = add(io_out_mul_data_reg_7, io_out_mul_data_reg_8) @[basic_macro.scala 37:60]
    node _io_out_T_13 = tail(_io_out_T_12, 1) @[basic_macro.scala 37:60]
    node _io_out_T_14 = asFixedPoint(_io_out_T_13, 8) @[basic_macro.scala 37:60]
    reg io_out_REG_7 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_out_REG_7) @[basic_macro.scala 31:21]
    io_out_REG_7 <= _io_out_T_14 @[basic_macro.scala 31:21]
    node _io_out_T_15 = add(io_out_REG_6, io_out_REG_7) @[basic_macro.scala 37:60]
    node _io_out_T_16 = tail(_io_out_T_15, 1) @[basic_macro.scala 37:60]
    node _io_out_T_17 = asFixedPoint(_io_out_T_16, 8) @[basic_macro.scala 37:60]
    reg io_out_REG_8 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_out_REG_8) @[basic_macro.scala 33:20]
    io_out_REG_8 <= _io_out_T_17 @[basic_macro.scala 33:20]
    node _io_out_T_18 = add(io_out_REG_5, io_out_REG_8) @[basic_macro.scala 37:60]
    node _io_out_T_19 = tail(_io_out_T_18, 1) @[basic_macro.scala 37:60]
    node _io_out_T_20 = asFixedPoint(_io_out_T_19, 8) @[basic_macro.scala 37:60]
    reg io_out_REG_9 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_out_REG_9) @[basic_macro.scala 33:20]
    io_out_REG_9 <= _io_out_T_20 @[basic_macro.scala 33:20]
    node _io_out_T_21 = add(io_out_REG_4, io_out_REG_9) @[basic_macro.scala 37:60]
    node _io_out_T_22 = tail(_io_out_T_21, 1) @[basic_macro.scala 37:60]
    node _io_out_T_23 = asFixedPoint(_io_out_T_22, 8) @[basic_macro.scala 37:60]
    reg io_out_REG_10 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_out_REG_10) @[basic_macro.scala 33:20]
    io_out_REG_10 <= _io_out_T_23 @[basic_macro.scala 33:20]
    node _io_out_T_24 = mux(io.valid, io_out_REG_10, asFixedPoint(UInt<16>("h0"), 8)) @[function_test.scala 31:16]
    io.out <= _io_out_T_24 @[function_test.scala 31:10]

