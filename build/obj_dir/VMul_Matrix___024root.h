// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VMul_Matrix.h for the primary calling header

#ifndef VERILATED_VMUL_MATRIX___024ROOT_H_
#define VERILATED_VMUL_MATRIX___024ROOT_H_  // guard

#include "verilated.h"

class VMul_Matrix__Syms;

class VMul_Matrix___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clock,0,0);
    VL_IN8(reset,0,0);
    VL_IN8(io_valid,0,0);
    CData/*0:0*/ __Vclklast__TOP__clock;
    VL_IN16(io_in_matrix_port_0,15,0);
    VL_IN16(io_in_matrix_port_1,15,0);
    VL_IN16(io_in_matrix_port_2,15,0);
    VL_IN16(io_in_matrix_port_3,15,0);
    VL_IN16(io_in_matrix_port_4,15,0);
    VL_IN16(io_in_matrix_port_5,15,0);
    VL_IN16(io_in_matrix_port_6,15,0);
    VL_IN16(io_in_matrix_port_7,15,0);
    VL_IN16(io_in_matrix_port_8,15,0);
    VL_OUT16(io_out,15,0);
    VL_IN16(io_consts_matrix_port_0,15,0);
    VL_IN16(io_consts_matrix_port_1,15,0);
    VL_IN16(io_consts_matrix_port_2,15,0);
    VL_IN16(io_consts_matrix_port_3,15,0);
    VL_IN16(io_consts_matrix_port_4,15,0);
    VL_IN16(io_consts_matrix_port_5,15,0);
    VL_IN16(io_consts_matrix_port_6,15,0);
    VL_IN16(io_consts_matrix_port_7,15,0);
    VL_IN16(io_consts_matrix_port_8,15,0);
    SData/*15:0*/ Mul_Matrix__DOT__io_out_mul_data_reg_0;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_mul_data_reg_1;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_mul_data_reg_2;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_mul_data_reg_3;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_mul_data_reg_4;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_mul_data_reg_5;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_mul_data_reg_6;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_mul_data_reg_7;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_mul_data_reg_8;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_REG;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_REG_1;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_REG_2;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_REG_3;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_REG_4;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_REG_5;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_REG_6;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_REG_7;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_REG_8;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_REG_9;
    SData/*15:0*/ Mul_Matrix__DOT__io_out_REG_10;
    VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;

    // INTERNAL VARIABLES
    VMul_Matrix__Syms* const vlSymsp;

    // CONSTRUCTORS
    VMul_Matrix___024root(VMul_Matrix__Syms* symsp, const char* name);
    ~VMul_Matrix___024root();
    VL_UNCOPYABLE(VMul_Matrix___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
