TARGET_LIB = libsimpleJSON.a
OBJS       = src/JSON.o src/JSONValue.o
INCLUDES   = src

PREFIX  ?= ${VITASDK}/arm-vita-eabi
CC      = arm-vita-eabi-gcc
CXX     = arm-vita-eabi-g++
AR      = arm-vita-eabi-ar
CFLAGS  = -Wl,-q -Wall -O3 -I$(INCLUDES) -ffat-lto-objects -flto
ASFLAGS = $(CFLAGS)

all: $(TARGET_LIB)

debug: CFLAGS += -DDEBUG_BUILD
debug: all

$(TARGET_LIB): $(OBJS)
	$(AR) -r $@ $^

clean:
	rm -rf $(TARGET_LIB) $(OBJS)

install: $(TARGET_LIB)
	@mkdir -p $(PREFIX)/lib/
	@mkdir -p $(PREFIX)/include/SimpleJSON/
	cp $(TARGET_LIB) $(PREFIX)/lib/
	cp src/JSON.h $(PREFIX)/include/SimpleJSON/
	cp src/JSONValue.h $(PREFIX)/include/SimpleJSON/
