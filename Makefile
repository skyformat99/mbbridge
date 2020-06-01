#
# Makefile
#
BIN = mbbridge
BINDIR = /usr/sbin/
DESTDIR = /usr
PREFIX = /local
INCDIR1 = $(DESTDIR)/include/modbuspp
INCDIR2 = $(DESTDIR)/include/modbus

# modbus header files could be located in different directories
INC += -I$(DESTDIR)/include/modbuspp -I$(DESTDIR)/include/modbus/include/modbus
INC += -I$(DESTDIR)$(PREFIX)/include/modbuspp -I$(DESTDIR)$(PREFIX)/include/modbus

CC=gcc
CXX=g++
CFLAGS = -Wall -Wshadow -Wundef -Wmaybe-uninitialized -Wno-unknown-pragmas
CFLAGS += -O3 -g3 $(INC)

# directory for local libs
LDFLAGS = -L$(DESTDIR)$(PREFIX)/lib
LIBS += -lstdc++ -lm -lmosquitto -lconfig++ -lmodbus

VPATH =

$(info LDFLAGS ="$(LDFLAGS)")

# folder for our object files
OBJDIR = ./obj

CSRCS += $(wildcard *.c)
CPPSRCS += $(wildcard *.cpp)

COBJS = $(patsubst %.c,$(OBJDIR)/%.o,$(CSRCS))
CPPOBJS = $(patsubst %.cpp,$(OBJDIR)/%.o,$(CPPSRCS))

SRCS = $(CSRCS) $(CPPSRCS)
OBJS = $(COBJS) $(CPPOBJS)

#.PHONY: clean

all: default

$(OBJDIR)/%.o: %.c
	@mkdir -p $(OBJDIR)
	@$(CC)  $(CFLAGS) -c $< -o $@
	@echo "CC $<"

$(OBJDIR)/%.o: %.cpp
	@mkdir -p $(OBJDIR)
	@$(CXX)  $(CFLAGS) -c $< -o $@
	@echo "CXX $<"

default: $(OBJS)
	$(CC) -o $(BIN) $(OBJS) $(LDFLAGS) $(LIBS)

#	nothing to do but will print info
nothing:
	$(info OBJS ="$(OBJS)")
	$(info DONE)


clean:
	rm -f $(OBJS)

install:
#	install -o root $(BIN) $(BINDIR)$(BIN)
#	@echo ++++++++++++++++++++++++++++++++++++++++++++
#	@echo ++ $(BIN) has been installed in $(BINDIR)
#	@echo ++ systemctl start $(BIN)
#	@echo ++ systemctl stop $(BIN)
#
