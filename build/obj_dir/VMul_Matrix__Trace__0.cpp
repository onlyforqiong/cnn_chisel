// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VMul_Matrix__Syms.h"


void VMul_Matrix___024root__trace_chg_sub_0(VMul_Matrix___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void VMul_Matrix___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root__trace_chg_top_0\n"); );
    // Init
    VMul_Matrix___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VMul_Matrix___024root*>(voidSelf);
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    VMul_Matrix___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

void VMul_Matrix___024root__trace_chg_sub_0(VMul_Matrix___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[1U])) {
        bufp->chgSData(oldp+0,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_0),16);
        bufp->chgSData(oldp+1,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_1),16);
        bufp->chgSData(oldp+2,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_2),16);
        bufp->chgSData(oldp+3,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_3),16);
        bufp->chgSData(oldp+4,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_4),16);
        bufp->chgSData(oldp+5,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_5),16);
        bufp->chgSData(oldp+6,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_6),16);
        bufp->chgSData(oldp+7,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_7),16);
        bufp->chgSData(oldp+8,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_8),16);
        bufp->chgSData(oldp+9,(vlSelf->Mul_Matrix__DOT__io_out_REG),16);
        bufp->chgSData(oldp+10,(vlSelf->Mul_Matrix__DOT__io_out_REG_1),16);
        bufp->chgSData(oldp+11,(vlSelf->Mul_Matrix__DOT__io_out_REG_2),16);
        bufp->chgSData(oldp+12,(vlSelf->Mul_Matrix__DOT__io_out_REG_3),16);
        bufp->chgSData(oldp+13,(vlSelf->Mul_Matrix__DOT__io_out_REG_4),16);
        bufp->chgSData(oldp+14,(vlSelf->Mul_Matrix__DOT__io_out_REG_5),16);
        bufp->chgSData(oldp+15,(vlSelf->Mul_Matrix__DOT__io_out_REG_6),16);
        bufp->chgSData(oldp+16,(vlSelf->Mul_Matrix__DOT__io_out_REG_7),16);
        bufp->chgSData(oldp+17,(vlSelf->Mul_Matrix__DOT__io_out_REG_8),16);
        bufp->chgSData(oldp+18,(vlSelf->Mul_Matrix__DOT__io_out_REG_9),16);
        bufp->chgSData(oldp+19,(vlSelf->Mul_Matrix__DOT__io_out_REG_10),16);
    }
    bufp->chgBit(oldp+20,(vlSelf->clock));
    bufp->chgBit(oldp+21,(vlSelf->reset));
    bufp->chgSData(oldp+22,(vlSelf->io_in_matrix_port_0),16);
    bufp->chgSData(oldp+23,(vlSelf->io_in_matrix_port_1),16);
    bufp->chgSData(oldp+24,(vlSelf->io_in_matrix_port_2),16);
    bufp->chgSData(oldp+25,(vlSelf->io_in_matrix_port_3),16);
    bufp->chgSData(oldp+26,(vlSelf->io_in_matrix_port_4),16);
    bufp->chgSData(oldp+27,(vlSelf->io_in_matrix_port_5),16);
    bufp->chgSData(oldp+28,(vlSelf->io_in_matrix_port_6),16);
    bufp->chgSData(oldp+29,(vlSelf->io_in_matrix_port_7),16);
    bufp->chgSData(oldp+30,(vlSelf->io_in_matrix_port_8),16);
    bufp->chgBit(oldp+31,(vlSelf->io_valid));
    bufp->chgSData(oldp+32,(vlSelf->io_out),16);
    bufp->chgSData(oldp+33,(vlSelf->io_consts_matrix_port_0),16);
    bufp->chgSData(oldp+34,(vlSelf->io_consts_matrix_port_1),16);
    bufp->chgSData(oldp+35,(vlSelf->io_consts_matrix_port_2),16);
    bufp->chgSData(oldp+36,(vlSelf->io_consts_matrix_port_3),16);
    bufp->chgSData(oldp+37,(vlSelf->io_consts_matrix_port_4),16);
    bufp->chgSData(oldp+38,(vlSelf->io_consts_matrix_port_5),16);
    bufp->chgSData(oldp+39,(vlSelf->io_consts_matrix_port_6),16);
    bufp->chgSData(oldp+40,(vlSelf->io_consts_matrix_port_7),16);
    bufp->chgSData(oldp+41,(vlSelf->io_consts_matrix_port_8),16);
}

void VMul_Matrix___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root__trace_cleanup\n"); );
    // Init
    VMul_Matrix___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VMul_Matrix___024root*>(voidSelf);
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}
