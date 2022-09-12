// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VMul_Matrix.h for the primary calling header

#include "verilated.h"

#include "VMul_Matrix___024root.h"

VL_INLINE_OPT void VMul_Matrix___024root___sequent__TOP__0(VMul_Matrix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root___sequent__TOP__0\n"); );
    // Body
    vlSelf->Mul_Matrix__DOT__io_out_REG_10 = (0xffffU 
                                              & ((IData)(vlSelf->Mul_Matrix__DOT__io_out_REG_4) 
                                                 + (IData)(vlSelf->Mul_Matrix__DOT__io_out_REG_9)));
    vlSelf->Mul_Matrix__DOT__io_out_REG_4 = (0xffffU 
                                             & ((IData)(vlSelf->Mul_Matrix__DOT__io_out_REG) 
                                                + (IData)(vlSelf->Mul_Matrix__DOT__io_out_REG_3)));
    vlSelf->Mul_Matrix__DOT__io_out_REG_9 = (0xffffU 
                                             & ((IData)(vlSelf->Mul_Matrix__DOT__io_out_REG_5) 
                                                + (IData)(vlSelf->Mul_Matrix__DOT__io_out_REG_8)));
    vlSelf->Mul_Matrix__DOT__io_out_REG = vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_0;
    vlSelf->Mul_Matrix__DOT__io_out_REG_3 = (0xffffU 
                                             & ((IData)(vlSelf->Mul_Matrix__DOT__io_out_REG_1) 
                                                + (IData)(vlSelf->Mul_Matrix__DOT__io_out_REG_2)));
    vlSelf->Mul_Matrix__DOT__io_out_REG_5 = (0xffffU 
                                             & ((IData)(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_4) 
                                                + (IData)(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_5)));
    vlSelf->Mul_Matrix__DOT__io_out_REG_8 = (0xffffU 
                                             & ((IData)(vlSelf->Mul_Matrix__DOT__io_out_REG_6) 
                                                + (IData)(vlSelf->Mul_Matrix__DOT__io_out_REG_7)));
    vlSelf->Mul_Matrix__DOT__io_out_REG_1 = vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_1;
    vlSelf->Mul_Matrix__DOT__io_out_REG_2 = (0xffffU 
                                             & ((IData)(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_2) 
                                                + (IData)(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_3)));
    vlSelf->Mul_Matrix__DOT__io_out_REG_6 = vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_6;
    vlSelf->Mul_Matrix__DOT__io_out_REG_7 = (0xffffU 
                                             & ((IData)(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_7) 
                                                + (IData)(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_8)));
    if (vlSelf->reset) {
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_0 = 0U;
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_4 = 0U;
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_5 = 0U;
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_1 = 0U;
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_2 = 0U;
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_3 = 0U;
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_6 = 0U;
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_7 = 0U;
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_8 = 0U;
    } else {
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_0 
            = (0xffffU & (VL_MULS_III(32, VL_EXTENDS_II(32,16, (IData)(vlSelf->io_in_matrix_port_0)), 
                                      VL_EXTENDS_II(32,16, (IData)(vlSelf->io_consts_matrix_port_0))) 
                          >> 8U));
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_4 
            = (0xffffU & (VL_MULS_III(32, VL_EXTENDS_II(32,16, (IData)(vlSelf->io_in_matrix_port_4)), 
                                      VL_EXTENDS_II(32,16, (IData)(vlSelf->io_consts_matrix_port_4))) 
                          >> 8U));
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_5 
            = (0xffffU & (VL_MULS_III(32, VL_EXTENDS_II(32,16, (IData)(vlSelf->io_in_matrix_port_5)), 
                                      VL_EXTENDS_II(32,16, (IData)(vlSelf->io_consts_matrix_port_5))) 
                          >> 8U));
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_1 
            = (0xffffU & (VL_MULS_III(32, VL_EXTENDS_II(32,16, (IData)(vlSelf->io_in_matrix_port_1)), 
                                      VL_EXTENDS_II(32,16, (IData)(vlSelf->io_consts_matrix_port_1))) 
                          >> 8U));
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_2 
            = (0xffffU & (VL_MULS_III(32, VL_EXTENDS_II(32,16, (IData)(vlSelf->io_in_matrix_port_2)), 
                                      VL_EXTENDS_II(32,16, (IData)(vlSelf->io_consts_matrix_port_2))) 
                          >> 8U));
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_3 
            = (0xffffU & (VL_MULS_III(32, VL_EXTENDS_II(32,16, (IData)(vlSelf->io_in_matrix_port_3)), 
                                      VL_EXTENDS_II(32,16, (IData)(vlSelf->io_consts_matrix_port_3))) 
                          >> 8U));
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_6 
            = (0xffffU & (VL_MULS_III(32, VL_EXTENDS_II(32,16, (IData)(vlSelf->io_in_matrix_port_6)), 
                                      VL_EXTENDS_II(32,16, (IData)(vlSelf->io_consts_matrix_port_6))) 
                          >> 8U));
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_7 
            = (0xffffU & (VL_MULS_III(32, VL_EXTENDS_II(32,16, (IData)(vlSelf->io_in_matrix_port_7)), 
                                      VL_EXTENDS_II(32,16, (IData)(vlSelf->io_consts_matrix_port_7))) 
                          >> 8U));
        vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_8 
            = (0xffffU & (VL_MULS_III(32, VL_EXTENDS_II(32,16, (IData)(vlSelf->io_in_matrix_port_8)), 
                                      VL_EXTENDS_II(32,16, (IData)(vlSelf->io_consts_matrix_port_8))) 
                          >> 8U));
    }
}

VL_INLINE_OPT void VMul_Matrix___024root___combo__TOP__0(VMul_Matrix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root___combo__TOP__0\n"); );
    // Body
    vlSelf->io_out = ((IData)(vlSelf->io_valid) ? (IData)(vlSelf->Mul_Matrix__DOT__io_out_REG_10)
                       : 0U);
}

void VMul_Matrix___024root___eval(VMul_Matrix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root___eval\n"); );
    // Body
    if (((IData)(vlSelf->clock) & (~ (IData)(vlSelf->__Vclklast__TOP__clock)))) {
        VMul_Matrix___024root___sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
    VMul_Matrix___024root___combo__TOP__0(vlSelf);
    // Final
    vlSelf->__Vclklast__TOP__clock = vlSelf->clock;
}

#ifdef VL_DEBUG
void VMul_Matrix___024root___eval_debug_assertions(VMul_Matrix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clock & 0xfeU))) {
        Verilated::overWidthError("clock");}
    if (VL_UNLIKELY((vlSelf->reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
    if (VL_UNLIKELY((vlSelf->io_valid & 0xfeU))) {
        Verilated::overWidthError("io_valid");}
}
#endif  // VL_DEBUG
