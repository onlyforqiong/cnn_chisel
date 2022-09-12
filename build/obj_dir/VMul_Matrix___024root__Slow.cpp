// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VMul_Matrix.h for the primary calling header

#include "verilated.h"

#include "VMul_Matrix__Syms.h"
#include "VMul_Matrix___024root.h"

void VMul_Matrix___024root___ctor_var_reset(VMul_Matrix___024root* vlSelf);

VMul_Matrix___024root::VMul_Matrix___024root(VMul_Matrix__Syms* symsp, const char* name)
    : VerilatedModule{name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    VMul_Matrix___024root___ctor_var_reset(this);
}

void VMul_Matrix___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

VMul_Matrix___024root::~VMul_Matrix___024root() {
}
