circuit sliding_window :
  module matrix_bundle_cross_bar :
    input clock : Clock
    input reset : Reset
    output io : { flip matrix_input : { matrix_port : Fixed<16><<8>>[9]}, matrix_output : { matrix_port : Fixed<16><<8>>[9]}}

    io.matrix_output.matrix_port[0] <= io.matrix_input.matrix_port[0] @[basic_macro.scala 63:26]
    io.matrix_output.matrix_port[1] <= io.matrix_input.matrix_port[1] @[basic_macro.scala 63:26]
    io.matrix_output.matrix_port[2] <= io.matrix_input.matrix_port[2] @[basic_macro.scala 63:26]
    io.matrix_output.matrix_port[3] <= io.matrix_input.matrix_port[3] @[basic_macro.scala 63:26]
    io.matrix_output.matrix_port[4] <= io.matrix_input.matrix_port[4] @[basic_macro.scala 63:26]
    io.matrix_output.matrix_port[5] <= io.matrix_input.matrix_port[5] @[basic_macro.scala 63:26]
    io.matrix_output.matrix_port[6] <= io.matrix_input.matrix_port[6] @[basic_macro.scala 63:26]
    io.matrix_output.matrix_port[7] <= io.matrix_input.matrix_port[7] @[basic_macro.scala 63:26]
    io.matrix_output.matrix_port[8] <= io.matrix_input.matrix_port[8] @[basic_macro.scala 63:26]

  module sliding_window :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip data_in : Fixed<16><<8>>, flip const_in : { matrix_port : Fixed<16><<8>>[9]}, flip data_valid : UInt<1>, flip data_refresh : UInt<1>, data_out : Fixed<16><<8>>, data_out_valid : UInt<1>, sliding_end : UInt<1>}

    reg data_shift_0 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_1 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_2 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_3 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_4 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_5 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_6 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_7 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_8 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_9 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_10 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_11 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_12 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_13 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_14 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_15 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_16 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_17 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_18 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_19 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_20 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_21 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_22 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_23 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_24 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_25 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_26 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_27 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_28 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_29 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_30 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_31 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_32 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_33 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_34 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_35 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_36 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_37 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_38 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_39 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_40 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_41 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_42 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_43 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_44 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_45 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_46 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_47 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_48 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_49 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_50 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_51 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_52 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_53 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_54 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_55 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_56 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_57 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    reg data_shift_58 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[sliding_window.scala 25:90]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_0 <= io.data_in @[sliding_window.scala 31:37]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_1 <= data_shift_0 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_2 <= data_shift_1 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_3 <= data_shift_2 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_4 <= data_shift_3 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_5 <= data_shift_4 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_6 <= data_shift_5 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_7 <= data_shift_6 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_8 <= data_shift_7 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_9 <= data_shift_8 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_10 <= data_shift_9 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_11 <= data_shift_10 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_12 <= data_shift_11 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_13 <= data_shift_12 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_14 <= data_shift_13 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_15 <= data_shift_14 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_16 <= data_shift_15 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_17 <= data_shift_16 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_18 <= data_shift_17 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_19 <= data_shift_18 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_20 <= data_shift_19 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_21 <= data_shift_20 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_22 <= data_shift_21 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_23 <= data_shift_22 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_24 <= data_shift_23 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_25 <= data_shift_24 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_26 <= data_shift_25 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_27 <= data_shift_26 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_28 <= data_shift_27 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_29 <= data_shift_28 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_30 <= data_shift_29 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_31 <= data_shift_30 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_32 <= data_shift_31 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_33 <= data_shift_32 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_34 <= data_shift_33 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_35 <= data_shift_34 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_36 <= data_shift_35 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_37 <= data_shift_36 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_38 <= data_shift_37 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_39 <= data_shift_38 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_40 <= data_shift_39 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_41 <= data_shift_40 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_42 <= data_shift_41 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_43 <= data_shift_42 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_44 <= data_shift_43 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_45 <= data_shift_44 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_46 <= data_shift_45 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_47 <= data_shift_46 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_48 <= data_shift_47 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_49 <= data_shift_48 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_50 <= data_shift_49 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_51 <= data_shift_50 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_52 <= data_shift_51 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_53 <= data_shift_52 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_54 <= data_shift_53 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_55 <= data_shift_54 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_56 <= data_shift_55 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_57 <= data_shift_56 @[sliding_window.scala 33:35]
    when io.data_valid : @[sliding_window.scala 27:29]
      skip
    else :
      data_shift_58 <= data_shift_57 @[sliding_window.scala 33:35]
    inst slid_windows_port of matrix_bundle_cross_bar @[sliding_window.scala 39:35]
    slid_windows_port.clock <= clock
    slid_windows_port.reset <= reset
    slid_windows_port.io.matrix_input.matrix_port[0] <= data_shift_0 @[sliding_window.scala 41:62]
    slid_windows_port.io.matrix_input.matrix_port[1] <= data_shift_1 @[sliding_window.scala 41:62]
    slid_windows_port.io.matrix_input.matrix_port[2] <= data_shift_2 @[sliding_window.scala 41:62]
    slid_windows_port.io.matrix_input.matrix_port[3] <= data_shift_28 @[sliding_window.scala 41:62]
    slid_windows_port.io.matrix_input.matrix_port[4] <= data_shift_29 @[sliding_window.scala 41:62]
    slid_windows_port.io.matrix_input.matrix_port[5] <= data_shift_30 @[sliding_window.scala 41:62]
    slid_windows_port.io.matrix_input.matrix_port[6] <= data_shift_56 @[sliding_window.scala 41:62]
    slid_windows_port.io.matrix_input.matrix_port[7] <= data_shift_57 @[sliding_window.scala 41:62]
    slid_windows_port.io.matrix_input.matrix_port[8] <= data_shift_58 @[sliding_window.scala 41:62]
    reg io_data_out_mul_data_reg_0 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_data_out_mul_data_reg_1 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_data_out_mul_data_reg_2 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_data_out_mul_data_reg_3 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_data_out_mul_data_reg_4 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_data_out_mul_data_reg_5 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_data_out_mul_data_reg_6 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_data_out_mul_data_reg_7 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    reg io_data_out_mul_data_reg_8 : Fixed<16><<8>>, clock with :
      reset => (reset, asFixedPoint(UInt<16>("h0"), 8)) @[basic_macro.scala 41:71]
    node _io_data_out_mul_data_reg_0_T = mul(slid_windows_port.io.matrix_output.matrix_port[0], io.const_in.matrix_port[0]) @[basic_macro.scala 43:38]
    io_data_out_mul_data_reg_0 <= _io_data_out_mul_data_reg_0_T @[basic_macro.scala 43:33]
    node _io_data_out_mul_data_reg_1_T = mul(slid_windows_port.io.matrix_output.matrix_port[1], io.const_in.matrix_port[1]) @[basic_macro.scala 43:38]
    io_data_out_mul_data_reg_1 <= _io_data_out_mul_data_reg_1_T @[basic_macro.scala 43:33]
    node _io_data_out_mul_data_reg_2_T = mul(slid_windows_port.io.matrix_output.matrix_port[2], io.const_in.matrix_port[2]) @[basic_macro.scala 43:38]
    io_data_out_mul_data_reg_2 <= _io_data_out_mul_data_reg_2_T @[basic_macro.scala 43:33]
    node _io_data_out_mul_data_reg_3_T = mul(slid_windows_port.io.matrix_output.matrix_port[3], io.const_in.matrix_port[3]) @[basic_macro.scala 43:38]
    io_data_out_mul_data_reg_3 <= _io_data_out_mul_data_reg_3_T @[basic_macro.scala 43:33]
    node _io_data_out_mul_data_reg_4_T = mul(slid_windows_port.io.matrix_output.matrix_port[4], io.const_in.matrix_port[4]) @[basic_macro.scala 43:38]
    io_data_out_mul_data_reg_4 <= _io_data_out_mul_data_reg_4_T @[basic_macro.scala 43:33]
    node _io_data_out_mul_data_reg_5_T = mul(slid_windows_port.io.matrix_output.matrix_port[5], io.const_in.matrix_port[5]) @[basic_macro.scala 43:38]
    io_data_out_mul_data_reg_5 <= _io_data_out_mul_data_reg_5_T @[basic_macro.scala 43:33]
    node _io_data_out_mul_data_reg_6_T = mul(slid_windows_port.io.matrix_output.matrix_port[6], io.const_in.matrix_port[6]) @[basic_macro.scala 43:38]
    io_data_out_mul_data_reg_6 <= _io_data_out_mul_data_reg_6_T @[basic_macro.scala 43:33]
    node _io_data_out_mul_data_reg_7_T = mul(slid_windows_port.io.matrix_output.matrix_port[7], io.const_in.matrix_port[7]) @[basic_macro.scala 43:38]
    io_data_out_mul_data_reg_7 <= _io_data_out_mul_data_reg_7_T @[basic_macro.scala 43:33]
    node _io_data_out_mul_data_reg_8_T = mul(slid_windows_port.io.matrix_output.matrix_port[8], io.const_in.matrix_port[8]) @[basic_macro.scala 43:38]
    io_data_out_mul_data_reg_8 <= _io_data_out_mul_data_reg_8_T @[basic_macro.scala 43:33]
    reg io_data_out_REG : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_data_out_REG) @[basic_macro.scala 28:21]
    io_data_out_REG <= io_data_out_mul_data_reg_0 @[basic_macro.scala 28:21]
    reg io_data_out_REG_1 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_data_out_REG_1) @[basic_macro.scala 28:21]
    io_data_out_REG_1 <= io_data_out_mul_data_reg_1 @[basic_macro.scala 28:21]
    node _io_data_out_T = add(io_data_out_mul_data_reg_2, io_data_out_mul_data_reg_3) @[basic_macro.scala 37:60]
    node _io_data_out_T_1 = tail(_io_data_out_T, 1) @[basic_macro.scala 37:60]
    node _io_data_out_T_2 = asFixedPoint(_io_data_out_T_1, 8) @[basic_macro.scala 37:60]
    reg io_data_out_REG_2 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_data_out_REG_2) @[basic_macro.scala 31:21]
    io_data_out_REG_2 <= _io_data_out_T_2 @[basic_macro.scala 31:21]
    node _io_data_out_T_3 = add(io_data_out_REG_1, io_data_out_REG_2) @[basic_macro.scala 37:60]
    node _io_data_out_T_4 = tail(_io_data_out_T_3, 1) @[basic_macro.scala 37:60]
    node _io_data_out_T_5 = asFixedPoint(_io_data_out_T_4, 8) @[basic_macro.scala 37:60]
    reg io_data_out_REG_3 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_data_out_REG_3) @[basic_macro.scala 33:20]
    io_data_out_REG_3 <= _io_data_out_T_5 @[basic_macro.scala 33:20]
    node _io_data_out_T_6 = add(io_data_out_REG, io_data_out_REG_3) @[basic_macro.scala 37:60]
    node _io_data_out_T_7 = tail(_io_data_out_T_6, 1) @[basic_macro.scala 37:60]
    node _io_data_out_T_8 = asFixedPoint(_io_data_out_T_7, 8) @[basic_macro.scala 37:60]
    reg io_data_out_REG_4 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_data_out_REG_4) @[basic_macro.scala 33:20]
    io_data_out_REG_4 <= _io_data_out_T_8 @[basic_macro.scala 33:20]
    node _io_data_out_T_9 = add(io_data_out_mul_data_reg_4, io_data_out_mul_data_reg_5) @[basic_macro.scala 37:60]
    node _io_data_out_T_10 = tail(_io_data_out_T_9, 1) @[basic_macro.scala 37:60]
    node _io_data_out_T_11 = asFixedPoint(_io_data_out_T_10, 8) @[basic_macro.scala 37:60]
    reg io_data_out_REG_5 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_data_out_REG_5) @[basic_macro.scala 31:21]
    io_data_out_REG_5 <= _io_data_out_T_11 @[basic_macro.scala 31:21]
    reg io_data_out_REG_6 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_data_out_REG_6) @[basic_macro.scala 28:21]
    io_data_out_REG_6 <= io_data_out_mul_data_reg_6 @[basic_macro.scala 28:21]
    node _io_data_out_T_12 = add(io_data_out_mul_data_reg_7, io_data_out_mul_data_reg_8) @[basic_macro.scala 37:60]
    node _io_data_out_T_13 = tail(_io_data_out_T_12, 1) @[basic_macro.scala 37:60]
    node _io_data_out_T_14 = asFixedPoint(_io_data_out_T_13, 8) @[basic_macro.scala 37:60]
    reg io_data_out_REG_7 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_data_out_REG_7) @[basic_macro.scala 31:21]
    io_data_out_REG_7 <= _io_data_out_T_14 @[basic_macro.scala 31:21]
    node _io_data_out_T_15 = add(io_data_out_REG_6, io_data_out_REG_7) @[basic_macro.scala 37:60]
    node _io_data_out_T_16 = tail(_io_data_out_T_15, 1) @[basic_macro.scala 37:60]
    node _io_data_out_T_17 = asFixedPoint(_io_data_out_T_16, 8) @[basic_macro.scala 37:60]
    reg io_data_out_REG_8 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_data_out_REG_8) @[basic_macro.scala 33:20]
    io_data_out_REG_8 <= _io_data_out_T_17 @[basic_macro.scala 33:20]
    node _io_data_out_T_18 = add(io_data_out_REG_5, io_data_out_REG_8) @[basic_macro.scala 37:60]
    node _io_data_out_T_19 = tail(_io_data_out_T_18, 1) @[basic_macro.scala 37:60]
    node _io_data_out_T_20 = asFixedPoint(_io_data_out_T_19, 8) @[basic_macro.scala 37:60]
    reg io_data_out_REG_9 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_data_out_REG_9) @[basic_macro.scala 33:20]
    io_data_out_REG_9 <= _io_data_out_T_20 @[basic_macro.scala 33:20]
    node _io_data_out_T_21 = add(io_data_out_REG_4, io_data_out_REG_9) @[basic_macro.scala 37:60]
    node _io_data_out_T_22 = tail(_io_data_out_T_21, 1) @[basic_macro.scala 37:60]
    node _io_data_out_T_23 = asFixedPoint(_io_data_out_T_22, 8) @[basic_macro.scala 37:60]
    reg io_data_out_REG_10 : Fixed<<8>>, clock with :
      reset => (UInt<1>("h0"), io_data_out_REG_10) @[basic_macro.scala 33:20]
    io_data_out_REG_10 <= _io_data_out_T_23 @[basic_macro.scala 33:20]
    io.data_out <= io_data_out_REG_10 @[sliding_window.scala 43:17]
    reg counter_a : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[Counter.scala 62:40]
    wire counter_b : UInt<1>
    counter_b <= UInt<1>("h0")
    when io.data_valid : @[Counter.scala 120:16]
      node wrap_wrap = eq(counter_a, UInt<10>("h314")) @[Counter.scala 74:24]
      node _wrap_value_T = add(counter_a, UInt<1>("h1")) @[Counter.scala 78:24]
      node _wrap_value_T_1 = tail(_wrap_value_T, 1) @[Counter.scala 78:24]
      counter_a <= _wrap_value_T_1 @[Counter.scala 78:15]
      when wrap_wrap : @[Counter.scala 88:20]
        counter_a <= UInt<1>("h0") @[Counter.scala 88:28]
      counter_b <= wrap_wrap @[Counter.scala 120:23]
    io.sliding_end <= counter_b @[sliding_window.scala 45:20]
    reg io_data_out_valid_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r <= io.data_valid @[Reg.scala 17:22]
    reg io_data_out_valid_r_1 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_1) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_1 <= io_data_out_valid_r @[Reg.scala 17:22]
    reg io_data_out_valid_r_2 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_2) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_2 <= io_data_out_valid_r_1 @[Reg.scala 17:22]
    reg io_data_out_valid_r_3 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_3) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_3 <= io_data_out_valid_r_2 @[Reg.scala 17:22]
    reg io_data_out_valid_r_4 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_4) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_4 <= io_data_out_valid_r_3 @[Reg.scala 17:22]
    reg io_data_out_valid_r_5 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_5) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_5 <= io_data_out_valid_r_4 @[Reg.scala 17:22]
    reg io_data_out_valid_r_6 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_6) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_6 <= io_data_out_valid_r_5 @[Reg.scala 17:22]
    reg io_data_out_valid_r_7 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_7) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_7 <= io_data_out_valid_r_6 @[Reg.scala 17:22]
    reg io_data_out_valid_r_8 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_8) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_8 <= io_data_out_valid_r_7 @[Reg.scala 17:22]
    reg io_data_out_valid_r_9 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_9) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_9 <= io_data_out_valid_r_8 @[Reg.scala 17:22]
    reg io_data_out_valid_r_10 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_10) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_10 <= io_data_out_valid_r_9 @[Reg.scala 17:22]
    reg io_data_out_valid_r_11 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_11) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_11 <= io_data_out_valid_r_10 @[Reg.scala 17:22]
    reg io_data_out_valid_r_12 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_12) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_12 <= io_data_out_valid_r_11 @[Reg.scala 17:22]
    reg io_data_out_valid_r_13 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_13) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_13 <= io_data_out_valid_r_12 @[Reg.scala 17:22]
    reg io_data_out_valid_r_14 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_14) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_14 <= io_data_out_valid_r_13 @[Reg.scala 17:22]
    reg io_data_out_valid_r_15 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_15) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_15 <= io_data_out_valid_r_14 @[Reg.scala 17:22]
    reg io_data_out_valid_r_16 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_16) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_16 <= io_data_out_valid_r_15 @[Reg.scala 17:22]
    reg io_data_out_valid_r_17 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_17) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_17 <= io_data_out_valid_r_16 @[Reg.scala 17:22]
    reg io_data_out_valid_r_18 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_18) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_18 <= io_data_out_valid_r_17 @[Reg.scala 17:22]
    reg io_data_out_valid_r_19 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_19) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_19 <= io_data_out_valid_r_18 @[Reg.scala 17:22]
    reg io_data_out_valid_r_20 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_20) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_20 <= io_data_out_valid_r_19 @[Reg.scala 17:22]
    reg io_data_out_valid_r_21 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_21) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_21 <= io_data_out_valid_r_20 @[Reg.scala 17:22]
    reg io_data_out_valid_r_22 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_22) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_22 <= io_data_out_valid_r_21 @[Reg.scala 17:22]
    reg io_data_out_valid_r_23 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_23) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_23 <= io_data_out_valid_r_22 @[Reg.scala 17:22]
    reg io_data_out_valid_r_24 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_24) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_24 <= io_data_out_valid_r_23 @[Reg.scala 17:22]
    reg io_data_out_valid_r_25 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_25) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_25 <= io_data_out_valid_r_24 @[Reg.scala 17:22]
    reg io_data_out_valid_r_26 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_26) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_26 <= io_data_out_valid_r_25 @[Reg.scala 17:22]
    reg io_data_out_valid_r_27 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_27) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_27 <= io_data_out_valid_r_26 @[Reg.scala 17:22]
    reg io_data_out_valid_r_28 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_28) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_28 <= io_data_out_valid_r_27 @[Reg.scala 17:22]
    reg io_data_out_valid_r_29 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_29) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_29 <= io_data_out_valid_r_28 @[Reg.scala 17:22]
    reg io_data_out_valid_r_30 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_30) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_30 <= io_data_out_valid_r_29 @[Reg.scala 17:22]
    reg io_data_out_valid_r_31 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_31) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_31 <= io_data_out_valid_r_30 @[Reg.scala 17:22]
    reg io_data_out_valid_r_32 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_32) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_32 <= io_data_out_valid_r_31 @[Reg.scala 17:22]
    reg io_data_out_valid_r_33 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_33) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_33 <= io_data_out_valid_r_32 @[Reg.scala 17:22]
    reg io_data_out_valid_r_34 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_34) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_34 <= io_data_out_valid_r_33 @[Reg.scala 17:22]
    reg io_data_out_valid_r_35 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_35) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_35 <= io_data_out_valid_r_34 @[Reg.scala 17:22]
    reg io_data_out_valid_r_36 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_36) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_36 <= io_data_out_valid_r_35 @[Reg.scala 17:22]
    reg io_data_out_valid_r_37 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_37) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_37 <= io_data_out_valid_r_36 @[Reg.scala 17:22]
    reg io_data_out_valid_r_38 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_38) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_38 <= io_data_out_valid_r_37 @[Reg.scala 17:22]
    reg io_data_out_valid_r_39 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_39) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_39 <= io_data_out_valid_r_38 @[Reg.scala 17:22]
    reg io_data_out_valid_r_40 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_40) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_40 <= io_data_out_valid_r_39 @[Reg.scala 17:22]
    reg io_data_out_valid_r_41 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_41) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_41 <= io_data_out_valid_r_40 @[Reg.scala 17:22]
    reg io_data_out_valid_r_42 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_42) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_42 <= io_data_out_valid_r_41 @[Reg.scala 17:22]
    reg io_data_out_valid_r_43 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_43) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_43 <= io_data_out_valid_r_42 @[Reg.scala 17:22]
    reg io_data_out_valid_r_44 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_44) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_44 <= io_data_out_valid_r_43 @[Reg.scala 17:22]
    reg io_data_out_valid_r_45 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_45) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_45 <= io_data_out_valid_r_44 @[Reg.scala 17:22]
    reg io_data_out_valid_r_46 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_46) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_46 <= io_data_out_valid_r_45 @[Reg.scala 17:22]
    reg io_data_out_valid_r_47 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_47) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_47 <= io_data_out_valid_r_46 @[Reg.scala 17:22]
    reg io_data_out_valid_r_48 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_48) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_48 <= io_data_out_valid_r_47 @[Reg.scala 17:22]
    reg io_data_out_valid_r_49 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_49) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_49 <= io_data_out_valid_r_48 @[Reg.scala 17:22]
    reg io_data_out_valid_r_50 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_50) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_50 <= io_data_out_valid_r_49 @[Reg.scala 17:22]
    reg io_data_out_valid_r_51 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_51) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_51 <= io_data_out_valid_r_50 @[Reg.scala 17:22]
    reg io_data_out_valid_r_52 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_52) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_52 <= io_data_out_valid_r_51 @[Reg.scala 17:22]
    reg io_data_out_valid_r_53 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_53) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_53 <= io_data_out_valid_r_52 @[Reg.scala 17:22]
    reg io_data_out_valid_r_54 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_54) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_54 <= io_data_out_valid_r_53 @[Reg.scala 17:22]
    reg io_data_out_valid_r_55 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_55) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_55 <= io_data_out_valid_r_54 @[Reg.scala 17:22]
    reg io_data_out_valid_r_56 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_56) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_56 <= io_data_out_valid_r_55 @[Reg.scala 17:22]
    reg io_data_out_valid_r_57 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_57) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_57 <= io_data_out_valid_r_56 @[Reg.scala 17:22]
    reg io_data_out_valid_r_58 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_58) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_58 <= io_data_out_valid_r_57 @[Reg.scala 17:22]
    reg io_data_out_valid_r_59 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_59) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_59 <= io_data_out_valid_r_58 @[Reg.scala 17:22]
    reg io_data_out_valid_r_60 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_60) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_60 <= io_data_out_valid_r_59 @[Reg.scala 17:22]
    reg io_data_out_valid_r_61 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_61) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_61 <= io_data_out_valid_r_60 @[Reg.scala 17:22]
    reg io_data_out_valid_r_62 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_62) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_62 <= io_data_out_valid_r_61 @[Reg.scala 17:22]
    reg io_data_out_valid_r_63 : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_data_out_valid_r_63) @[Reg.scala 16:16]
    when UInt<1>("h1") : @[Reg.scala 17:18]
      io_data_out_valid_r_63 <= io_data_out_valid_r_62 @[Reg.scala 17:22]
    io.data_out_valid <= io_data_out_valid_r_63 @[sliding_window.scala 47:23]

