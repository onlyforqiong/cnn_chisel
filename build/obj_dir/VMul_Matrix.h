// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary model header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef VERILATED_VMUL_MATRIX_H_
#define VERILATED_VMUL_MATRIX_H_  // guard

#include "verilated.h"

class VMul_Matrix__Syms;
class VMul_Matrix___024root;
class VerilatedVcdC;

// This class is the main interface to the Verilated model
class VMul_Matrix VL_NOT_FINAL : public VerilatedModel {
  private:
    // Symbol table holding complete model state (owned by this class)
    VMul_Matrix__Syms* const vlSymsp;

  public:

    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(&clock,0,0);
    VL_IN8(&reset,0,0);
    VL_IN8(&io_valid,0,0);
    VL_IN16(&io_in_matrix_port_0,15,0);
    VL_IN16(&io_in_matrix_port_1,15,0);
    VL_IN16(&io_in_matrix_port_2,15,0);
    VL_IN16(&io_in_matrix_port_3,15,0);
    VL_IN16(&io_in_matrix_port_4,15,0);
    VL_IN16(&io_in_matrix_port_5,15,0);
    VL_IN16(&io_in_matrix_port_6,15,0);
    VL_IN16(&io_in_matrix_port_7,15,0);
    VL_IN16(&io_in_matrix_port_8,15,0);
    VL_OUT16(&io_out,15,0);
    VL_IN16(&io_consts_matrix_port_0,15,0);
    VL_IN16(&io_consts_matrix_port_1,15,0);
    VL_IN16(&io_consts_matrix_port_2,15,0);
    VL_IN16(&io_consts_matrix_port_3,15,0);
    VL_IN16(&io_consts_matrix_port_4,15,0);
    VL_IN16(&io_consts_matrix_port_5,15,0);
    VL_IN16(&io_consts_matrix_port_6,15,0);
    VL_IN16(&io_consts_matrix_port_7,15,0);
    VL_IN16(&io_consts_matrix_port_8,15,0);

    // CELLS
    // Public to allow access to /* verilator public */ items.
    // Otherwise the application code can consider these internals.

    // Root instance pointer to allow access to model internals,
    // including inlined /* verilator public_flat_* */ items.
    VMul_Matrix___024root* const rootp;

    // CONSTRUCTORS
    /// Construct the model; called by application code
    /// If contextp is null, then the model will use the default global context
    /// If name is "", then makes a wrapper with a
    /// single model invisible with respect to DPI scope names.
    explicit VMul_Matrix(VerilatedContext* contextp, const char* name = "TOP");
    explicit VMul_Matrix(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    virtual ~VMul_Matrix();
  private:
    VL_UNCOPYABLE(VMul_Matrix);  ///< Copying not allowed

  public:
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval() { eval_step(); }
    /// Evaluate when calling multiple units/models per time step.
    void eval_step();
    /// Evaluate at end of a timestep for tracing, when using eval_step().
    /// Application must call after all eval() and before time changes.
    void eval_end_step() {}
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    /// Trace signals in the model; called by application code
    void trace(VerilatedVcdC* tfp, int levels, int options = 0);
    /// Retrieve name of this model instance (as passed to constructor).
    const char* name() const;

    // Abstract methods from VerilatedModel
    const char* hierName() const override final;
    const char* modelName() const override final;
    unsigned threads() const override final;
    std::unique_ptr<VerilatedTraceConfig> traceConfig() const override final;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
