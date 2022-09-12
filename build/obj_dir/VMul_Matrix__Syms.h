// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VMUL_MATRIX__SYMS_H_
#define VERILATED_VMUL_MATRIX__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "VMul_Matrix.h"

// INCLUDE MODULE CLASSES
#include "VMul_Matrix___024root.h"

// SYMS CLASS (contains all model state)
class VMul_Matrix__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    VMul_Matrix* const __Vm_modelp;
    bool __Vm_activity = false;  ///< Used by trace routines to determine change occurred
    uint32_t __Vm_baseCode = 0;  ///< Used by trace routines when tracing multiple models
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    VMul_Matrix___024root          TOP;

    // CONSTRUCTORS
    VMul_Matrix__Syms(VerilatedContext* contextp, const char* namep, VMul_Matrix* modelp);
    ~VMul_Matrix__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
