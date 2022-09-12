// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VMul_Matrix.h"
#include "VMul_Matrix__Syms.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

VMul_Matrix::VMul_Matrix(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new VMul_Matrix__Syms(contextp(), _vcname__, this)}
    , clock{vlSymsp->TOP.clock}
    , reset{vlSymsp->TOP.reset}
    , io_valid{vlSymsp->TOP.io_valid}
    , io_in_matrix_port_0{vlSymsp->TOP.io_in_matrix_port_0}
    , io_in_matrix_port_1{vlSymsp->TOP.io_in_matrix_port_1}
    , io_in_matrix_port_2{vlSymsp->TOP.io_in_matrix_port_2}
    , io_in_matrix_port_3{vlSymsp->TOP.io_in_matrix_port_3}
    , io_in_matrix_port_4{vlSymsp->TOP.io_in_matrix_port_4}
    , io_in_matrix_port_5{vlSymsp->TOP.io_in_matrix_port_5}
    , io_in_matrix_port_6{vlSymsp->TOP.io_in_matrix_port_6}
    , io_in_matrix_port_7{vlSymsp->TOP.io_in_matrix_port_7}
    , io_in_matrix_port_8{vlSymsp->TOP.io_in_matrix_port_8}
    , io_out{vlSymsp->TOP.io_out}
    , io_consts_matrix_port_0{vlSymsp->TOP.io_consts_matrix_port_0}
    , io_consts_matrix_port_1{vlSymsp->TOP.io_consts_matrix_port_1}
    , io_consts_matrix_port_2{vlSymsp->TOP.io_consts_matrix_port_2}
    , io_consts_matrix_port_3{vlSymsp->TOP.io_consts_matrix_port_3}
    , io_consts_matrix_port_4{vlSymsp->TOP.io_consts_matrix_port_4}
    , io_consts_matrix_port_5{vlSymsp->TOP.io_consts_matrix_port_5}
    , io_consts_matrix_port_6{vlSymsp->TOP.io_consts_matrix_port_6}
    , io_consts_matrix_port_7{vlSymsp->TOP.io_consts_matrix_port_7}
    , io_consts_matrix_port_8{vlSymsp->TOP.io_consts_matrix_port_8}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

VMul_Matrix::VMul_Matrix(const char* _vcname__)
    : VMul_Matrix(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

VMul_Matrix::~VMul_Matrix() {
    delete vlSymsp;
}

//============================================================
// Evaluation loop

void VMul_Matrix___024root___eval_initial(VMul_Matrix___024root* vlSelf);
void VMul_Matrix___024root___eval_settle(VMul_Matrix___024root* vlSelf);
void VMul_Matrix___024root___eval(VMul_Matrix___024root* vlSelf);
#ifdef VL_DEBUG
void VMul_Matrix___024root___eval_debug_assertions(VMul_Matrix___024root* vlSelf);
#endif  // VL_DEBUG
void VMul_Matrix___024root___final(VMul_Matrix___024root* vlSelf);

static void _eval_initial_loop(VMul_Matrix__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    VMul_Matrix___024root___eval_initial(&(vlSymsp->TOP));
    // Evaluate till stable
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial loop\n"););
        VMul_Matrix___024root___eval_settle(&(vlSymsp->TOP));
        VMul_Matrix___024root___eval(&(vlSymsp->TOP));
    } while (0);
}

void VMul_Matrix::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VMul_Matrix::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VMul_Matrix___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        VMul_Matrix___024root___eval(&(vlSymsp->TOP));
    } while (0);
    // Evaluate cleanup
}

//============================================================
// Utilities

const char* VMul_Matrix::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

VL_ATTR_COLD void VMul_Matrix::final() {
    VMul_Matrix___024root___final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* VMul_Matrix::hierName() const { return vlSymsp->name(); }
const char* VMul_Matrix::modelName() const { return "VMul_Matrix"; }
unsigned VMul_Matrix::threads() const { return 1; }
std::unique_ptr<VerilatedTraceConfig> VMul_Matrix::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void VMul_Matrix___024root__trace_init_top(VMul_Matrix___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    VMul_Matrix___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VMul_Matrix___024root*>(voidSelf);
    VMul_Matrix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->scopeEscape(' ');
    tracep->pushNamePrefix(std::string{vlSymsp->name()} + ' ');
    VMul_Matrix___024root__trace_init_top(vlSelf, tracep);
    tracep->popNamePrefix();
    tracep->scopeEscape('.');
}

VL_ATTR_COLD void VMul_Matrix___024root__trace_register(VMul_Matrix___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void VMul_Matrix::trace(VerilatedVcdC* tfp, int levels, int options) {
    if (false && levels && options) {}  // Prevent unused
    tfp->spTrace()->addModel(this);
    tfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    VMul_Matrix___024root__trace_register(&(vlSymsp->TOP), tfp->spTrace());
}
