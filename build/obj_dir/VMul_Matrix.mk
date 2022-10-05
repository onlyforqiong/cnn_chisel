# Verilated -*- Makefile -*-
# DESCRIPTION: Verilator output: Makefile for building Verilated archive or executable
#
# Execute this makefile from the object directory:
#    make -f VMul_Matrix.mk

default: /media/ddddddd/ddddddd/learning/cnn_chisel/build/Mul_Matrix

### Constants...
# Perl executable (from $PERL)
PERL = perl
# Path to Verilator kit (from $VERILATOR_ROOT)
VERILATOR_ROOT = /usr/local/share/verilator
# SystemC include directory with systemc.h (from $SYSTEMC_INCLUDE)
SYSTEMC_INCLUDE ?= 
# SystemC library directory with libsystemc.a (from $SYSTEMC_LIBDIR)
SYSTEMC_LIBDIR ?= 

### Switches...
# C++ code coverage  0/1 (from --prof-c)
VM_PROFC = 0
# SystemC output mode?  0/1 (from --sc)
VM_SC = 0
# Legacy or SystemC output mode?  0/1 (from --sc)
VM_SP_OR_SC = $(VM_SC)
# Deprecated
VM_PCLI = 1
# Deprecated: SystemC architecture to find link library path (from $SYSTEMC_ARCH)
VM_SC_TARGET_ARCH = linux

### Vars...
# Design prefix (from --prefix)
VM_PREFIX = VMul_Matrix
# Module prefix (from --prefix)
VM_MODPREFIX = VMul_Matrix
# User CFLAGS (from -CFLAGS on Verilator command line)
VM_USER_CFLAGS = \
	-I/media/ddddddd/ddddddd/learning/cnn_chisel/csrc/include/ \
	-DTOP_NAME="VMul_Matrix" \

# User LDLIBS (from -LDFLAGS on Verilator command line)
VM_USER_LDLIBS = \
	-lSDL2 \
	-lSDL2_image \
	-ltensorflow \

# User .cpp files (from .cpp's on Verilator command line)
VM_USER_CLASSES = \
	Mul_Matrix \
	fixed_point \

# User .cpp directories (from .cpp's on Verilator command line)
VM_USER_DIR = \
	/media/ddddddd/ddddddd/learning/cnn_chisel/csrc \
	/media/ddddddd/ddddddd/learning/cnn_chisel/csrc/lib \


### Default rules...
# Include list of all generated classes
include VMul_Matrix_classes.mk
# Include global rules
include $(VERILATOR_ROOT)/include/verilated.mk

### Executable rules... (from --exe)
VPATH += $(VM_USER_DIR)

Mul_Matrix.o: /media/ddddddd/ddddddd/learning/cnn_chisel/csrc/Mul_Matrix.cpp
	$(OBJCACHE) $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(OPT_FAST) -c -o $@ $<
fixed_point.o: /media/ddddddd/ddddddd/learning/cnn_chisel/csrc/lib/fixed_point.cpp
	$(OBJCACHE) $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(OPT_FAST) -c -o $@ $<

### Link rules... (from --exe)
/media/ddddddd/ddddddd/learning/cnn_chisel/build/Mul_Matrix: $(VK_USER_OBJS) $(VK_GLOBAL_OBJS) $(VM_PREFIX)__ALL.a $(VM_HIER_LIBS)
	$(LINK) $(LDFLAGS) $^ $(LOADLIBES) $(LDLIBS) $(LIBS) $(SC_LIBS) -o $@


# Verilated -*- Makefile -*-
