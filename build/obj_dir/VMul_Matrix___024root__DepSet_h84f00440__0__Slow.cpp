// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VMul_Matrix.h for the primary calling header

#include "verilated.h"

#include "VMul_Matrix___024root.h"

VL_ATTR_COLD void VMul_Matrix___024root___eval_initial(VMul_Matrix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vclklast__TOP__clock = vlSelf->clock;
}

void VMul_Matrix___024root___combo__TOP__0(VMul_Matrix___024root* vlSelf);

VL_ATTR_COLD void VMul_Matrix___024root___eval_settle(VMul_Matrix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root___eval_settle\n"); );
    // Body
    VMul_Matrix___024root___combo__TOP__0(vlSelf);
}

VL_ATTR_COLD void VMul_Matrix___024root___final(VMul_Matrix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root___final\n"); );
}

VL_ATTR_COLD void VMul_Matrix___024root___ctor_var_reset(VMul_Matrix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clock = 0;
    vlSelf->reset = 0;
    vlSelf->io_in_matrix_port_0 = 0;
    vlSelf->io_in_matrix_port_1 = 0;
    vlSelf->io_in_matrix_port_2 = 0;
    vlSelf->io_in_matrix_port_3 = 0;
    vlSelf->io_in_matrix_port_4 = 0;
    vlSelf->io_in_matrix_port_5 = 0;
    vlSelf->io_in_matrix_port_6 = 0;
    vlSelf->io_in_matrix_port_7 = 0;
    vlSelf->io_in_matrix_port_8 = 0;
    vlSelf->io_valid = 0;
    vlSelf->io_out = 0;
    vlSelf->io_consts_matrix_port_0 = 0;
    vlSelf->io_consts_matrix_port_1 = 0;
    vlSelf->io_consts_matrix_port_2 = 0;
    vlSelf->io_consts_matrix_port_3 = 0;
    vlSelf->io_consts_matrix_port_4 = 0;
    vlSelf->io_consts_matrix_port_5 = 0;
    vlSelf->io_consts_matrix_port_6 = 0;
    vlSelf->io_consts_matrix_port_7 = 0;
    vlSelf->io_consts_matrix_port_8 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_0 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_1 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_2 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_3 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_4 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_5 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_6 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_7 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_8 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_REG = 0;
    vlSelf->Mul_Matrix__DOT__io_out_REG_1 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_REG_2 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_REG_3 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_REG_4 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_REG_5 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_REG_6 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_REG_7 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_REG_8 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_REG_9 = 0;
    vlSelf->Mul_Matrix__DOT__io_out_REG_10 = 0;
    for (int __Vi0=0; __Vi0<2; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
