// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VMul_Matrix__Syms.h"


VL_ATTR_COLD void VMul_Matrix___024root__trace_init_sub__TOP__0(VMul_Matrix___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+21,"clock", false,-1);
    tracep->declBit(c+22,"reset", false,-1);
    tracep->declBus(c+23,"io_in_matrix_port_0", false,-1, 15,0);
    tracep->declBus(c+24,"io_in_matrix_port_1", false,-1, 15,0);
    tracep->declBus(c+25,"io_in_matrix_port_2", false,-1, 15,0);
    tracep->declBus(c+26,"io_in_matrix_port_3", false,-1, 15,0);
    tracep->declBus(c+27,"io_in_matrix_port_4", false,-1, 15,0);
    tracep->declBus(c+28,"io_in_matrix_port_5", false,-1, 15,0);
    tracep->declBus(c+29,"io_in_matrix_port_6", false,-1, 15,0);
    tracep->declBus(c+30,"io_in_matrix_port_7", false,-1, 15,0);
    tracep->declBus(c+31,"io_in_matrix_port_8", false,-1, 15,0);
    tracep->declBit(c+32,"io_valid", false,-1);
    tracep->declBus(c+33,"io_out", false,-1, 15,0);
    tracep->declBus(c+34,"io_consts_matrix_port_0", false,-1, 15,0);
    tracep->declBus(c+35,"io_consts_matrix_port_1", false,-1, 15,0);
    tracep->declBus(c+36,"io_consts_matrix_port_2", false,-1, 15,0);
    tracep->declBus(c+37,"io_consts_matrix_port_3", false,-1, 15,0);
    tracep->declBus(c+38,"io_consts_matrix_port_4", false,-1, 15,0);
    tracep->declBus(c+39,"io_consts_matrix_port_5", false,-1, 15,0);
    tracep->declBus(c+40,"io_consts_matrix_port_6", false,-1, 15,0);
    tracep->declBus(c+41,"io_consts_matrix_port_7", false,-1, 15,0);
    tracep->declBus(c+42,"io_consts_matrix_port_8", false,-1, 15,0);
    tracep->pushNamePrefix("Mul_Matrix ");
    tracep->declBit(c+21,"clock", false,-1);
    tracep->declBit(c+22,"reset", false,-1);
    tracep->declBus(c+23,"io_in_matrix_port_0", false,-1, 15,0);
    tracep->declBus(c+24,"io_in_matrix_port_1", false,-1, 15,0);
    tracep->declBus(c+25,"io_in_matrix_port_2", false,-1, 15,0);
    tracep->declBus(c+26,"io_in_matrix_port_3", false,-1, 15,0);
    tracep->declBus(c+27,"io_in_matrix_port_4", false,-1, 15,0);
    tracep->declBus(c+28,"io_in_matrix_port_5", false,-1, 15,0);
    tracep->declBus(c+29,"io_in_matrix_port_6", false,-1, 15,0);
    tracep->declBus(c+30,"io_in_matrix_port_7", false,-1, 15,0);
    tracep->declBus(c+31,"io_in_matrix_port_8", false,-1, 15,0);
    tracep->declBit(c+32,"io_valid", false,-1);
    tracep->declBus(c+33,"io_out", false,-1, 15,0);
    tracep->declBus(c+34,"io_consts_matrix_port_0", false,-1, 15,0);
    tracep->declBus(c+35,"io_consts_matrix_port_1", false,-1, 15,0);
    tracep->declBus(c+36,"io_consts_matrix_port_2", false,-1, 15,0);
    tracep->declBus(c+37,"io_consts_matrix_port_3", false,-1, 15,0);
    tracep->declBus(c+38,"io_consts_matrix_port_4", false,-1, 15,0);
    tracep->declBus(c+39,"io_consts_matrix_port_5", false,-1, 15,0);
    tracep->declBus(c+40,"io_consts_matrix_port_6", false,-1, 15,0);
    tracep->declBus(c+41,"io_consts_matrix_port_7", false,-1, 15,0);
    tracep->declBus(c+42,"io_consts_matrix_port_8", false,-1, 15,0);
    tracep->declBus(c+1,"io_out_mul_data_reg_0", false,-1, 15,0);
    tracep->declBus(c+2,"io_out_mul_data_reg_1", false,-1, 15,0);
    tracep->declBus(c+3,"io_out_mul_data_reg_2", false,-1, 15,0);
    tracep->declBus(c+4,"io_out_mul_data_reg_3", false,-1, 15,0);
    tracep->declBus(c+5,"io_out_mul_data_reg_4", false,-1, 15,0);
    tracep->declBus(c+6,"io_out_mul_data_reg_5", false,-1, 15,0);
    tracep->declBus(c+7,"io_out_mul_data_reg_6", false,-1, 15,0);
    tracep->declBus(c+8,"io_out_mul_data_reg_7", false,-1, 15,0);
    tracep->declBus(c+9,"io_out_mul_data_reg_8", false,-1, 15,0);
    tracep->declBus(c+10,"io_out_REG", false,-1, 15,0);
    tracep->declBus(c+11,"io_out_REG_1", false,-1, 15,0);
    tracep->declBus(c+12,"io_out_REG_2", false,-1, 15,0);
    tracep->declBus(c+13,"io_out_REG_3", false,-1, 15,0);
    tracep->declBus(c+14,"io_out_REG_4", false,-1, 15,0);
    tracep->declBus(c+15,"io_out_REG_5", false,-1, 15,0);
    tracep->declBus(c+16,"io_out_REG_6", false,-1, 15,0);
    tracep->declBus(c+17,"io_out_REG_7", false,-1, 15,0);
    tracep->declBus(c+18,"io_out_REG_8", false,-1, 15,0);
    tracep->declBus(c+19,"io_out_REG_9", false,-1, 15,0);
    tracep->declBus(c+20,"io_out_REG_10", false,-1, 15,0);
    tracep->popNamePrefix(1);
}

VL_ATTR_COLD void VMul_Matrix___024root__trace_init_top(VMul_Matrix___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root__trace_init_top\n"); );
    // Body
    VMul_Matrix___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void VMul_Matrix___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VMul_Matrix___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VMul_Matrix___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void VMul_Matrix___024root__trace_register(VMul_Matrix___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&VMul_Matrix___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&VMul_Matrix___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&VMul_Matrix___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void VMul_Matrix___024root__trace_full_sub_0(VMul_Matrix___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void VMul_Matrix___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root__trace_full_top_0\n"); );
    // Init
    VMul_Matrix___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VMul_Matrix___024root*>(voidSelf);
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    VMul_Matrix___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void VMul_Matrix___024root__trace_full_sub_0(VMul_Matrix___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VMul_Matrix___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullSData(oldp+1,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_0),16);
    bufp->fullSData(oldp+2,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_1),16);
    bufp->fullSData(oldp+3,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_2),16);
    bufp->fullSData(oldp+4,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_3),16);
    bufp->fullSData(oldp+5,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_4),16);
    bufp->fullSData(oldp+6,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_5),16);
    bufp->fullSData(oldp+7,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_6),16);
    bufp->fullSData(oldp+8,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_7),16);
    bufp->fullSData(oldp+9,(vlSelf->Mul_Matrix__DOT__io_out_mul_data_reg_8),16);
    bufp->fullSData(oldp+10,(vlSelf->Mul_Matrix__DOT__io_out_REG),16);
    bufp->fullSData(oldp+11,(vlSelf->Mul_Matrix__DOT__io_out_REG_1),16);
    bufp->fullSData(oldp+12,(vlSelf->Mul_Matrix__DOT__io_out_REG_2),16);
    bufp->fullSData(oldp+13,(vlSelf->Mul_Matrix__DOT__io_out_REG_3),16);
    bufp->fullSData(oldp+14,(vlSelf->Mul_Matrix__DOT__io_out_REG_4),16);
    bufp->fullSData(oldp+15,(vlSelf->Mul_Matrix__DOT__io_out_REG_5),16);
    bufp->fullSData(oldp+16,(vlSelf->Mul_Matrix__DOT__io_out_REG_6),16);
    bufp->fullSData(oldp+17,(vlSelf->Mul_Matrix__DOT__io_out_REG_7),16);
    bufp->fullSData(oldp+18,(vlSelf->Mul_Matrix__DOT__io_out_REG_8),16);
    bufp->fullSData(oldp+19,(vlSelf->Mul_Matrix__DOT__io_out_REG_9),16);
    bufp->fullSData(oldp+20,(vlSelf->Mul_Matrix__DOT__io_out_REG_10),16);
    bufp->fullBit(oldp+21,(vlSelf->clock));
    bufp->fullBit(oldp+22,(vlSelf->reset));
    bufp->fullSData(oldp+23,(vlSelf->io_in_matrix_port_0),16);
    bufp->fullSData(oldp+24,(vlSelf->io_in_matrix_port_1),16);
    bufp->fullSData(oldp+25,(vlSelf->io_in_matrix_port_2),16);
    bufp->fullSData(oldp+26,(vlSelf->io_in_matrix_port_3),16);
    bufp->fullSData(oldp+27,(vlSelf->io_in_matrix_port_4),16);
    bufp->fullSData(oldp+28,(vlSelf->io_in_matrix_port_5),16);
    bufp->fullSData(oldp+29,(vlSelf->io_in_matrix_port_6),16);
    bufp->fullSData(oldp+30,(vlSelf->io_in_matrix_port_7),16);
    bufp->fullSData(oldp+31,(vlSelf->io_in_matrix_port_8),16);
    bufp->fullBit(oldp+32,(vlSelf->io_valid));
    bufp->fullSData(oldp+33,(vlSelf->io_out),16);
    bufp->fullSData(oldp+34,(vlSelf->io_consts_matrix_port_0),16);
    bufp->fullSData(oldp+35,(vlSelf->io_consts_matrix_port_1),16);
    bufp->fullSData(oldp+36,(vlSelf->io_consts_matrix_port_2),16);
    bufp->fullSData(oldp+37,(vlSelf->io_consts_matrix_port_3),16);
    bufp->fullSData(oldp+38,(vlSelf->io_consts_matrix_port_4),16);
    bufp->fullSData(oldp+39,(vlSelf->io_consts_matrix_port_5),16);
    bufp->fullSData(oldp+40,(vlSelf->io_consts_matrix_port_6),16);
    bufp->fullSData(oldp+41,(vlSelf->io_consts_matrix_port_7),16);
    bufp->fullSData(oldp+42,(vlSelf->io_consts_matrix_port_8),16);
}
