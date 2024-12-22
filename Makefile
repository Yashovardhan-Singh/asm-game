rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

RM_RF := rm -rf
MKDIR_P := mkdir -p
TARGET := elf64
ifeq ($(OS), Windows_NT)
	RM_RF := rmdir /s /q
	MKDIR_P := mkdir
	TARGET := win64
endif

BINNAME := main

DBG_OPTIONS ?= -g -F dwarf
GNU ?=

NASM := nasm
LD := $(GNU)ld

INCDIRS := include
SRCDIR := src
DIROUT := bin
DIROBJ := obj

SRCS = $(call rwildcard, $(SRCDIR) $(INCDIRS), *.s)
BASEFILES = $(basename $(notdir $(SRCS)))
OBJS = $(call rwildcard, $(DIROBJ), *.o)

.DEFAULT_GOAL := all

all: clean pre-config build link
.PHONY: all

build:
	@for file in $(BASEFILES); do \
		$(NASM) $(SRCDIR)/$$file.s -o $(DIROBJ)/$$file.o -f $(TARGET) $(DBG_OPTIONS); \
	done
.PHONY: build

link:
	@$(LD) $(OBJS) -o $(DIROUT)/$(BINNAME) -dynamic-linker /lib64/ld-linux-x86-64.so.2 -Llibs/ -lraylib -lGL -lm -lpthread -ldl -lrt -lX11 -lc
.PHONY: link

pre-config:
	@if [ ! -d "$(DIROBJ)" ]; then \
		$(MKDIR_P) $(DIROBJ); \
	fi

	@if [ ! -d "$(DIROUT)" ]; then \
		$(MKDIR_P) $(DIROUT); \
	fi
.PHONY: pre-config

clean:
	@$(RM_RF) $(DIROUT) $(DIROBJ)
.PHONY: clean
