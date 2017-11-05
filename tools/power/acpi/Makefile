# tools/power/acpi/Makefile - ACPI tool Makefile
#
# Copyright (c) 2013, Intel Corporation
#   Author: Lv Zheng <lv.zheng@intel.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; version 2
# of the License.

OUTPUT=./
ifeq ("$(origin O)", "command line")
	OUTPUT := $(O)/
endif

ifneq ($(OUTPUT),)
# check that the output directory actually exists
OUTDIR := $(shell cd $(OUTPUT) && pwd)
$(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
endif

SUBDIRS = tools/ec

# --- CONFIGURATION BEGIN ---

# Set the following to `true' to make a unstripped, unoptimized
# binary. Leave this set to `false' for production use.
DEBUG ?=	true

# make the build silent. Set this to something else to make it noisy again.
V ?=		false

# Prefix to the directories we're installing to
DESTDIR ?=

# --- CONFIGURATION END ---

# Directory definitions. These are default and most probably
# do not need to be changed. Please note that DESTDIR is
# added in front of any of them

bindir ?=	/usr/bin
sbindir ?=	/usr/sbin
mandir ?=	/usr/man

# Toolchain: what tools do we use, and what options do they need:

INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA  = ${INSTALL} -m 644
INSTALL_SCRIPT = ${INSTALL_PROGRAM}

# If you are running a cross compiler, you may want to set this
# to something more interesting, like "arm-linux-".  If you want
# to compile vs uClibc, that can be done here as well.
CROSS = #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
CC = $(CROSS)gcc
LD = $(CROSS)gcc
STRIP = $(CROSS)strip
HOSTCC = gcc

# check if compiler option is supported
cc-supports = ${shell if $(CC) ${1} -S -o /dev/null -x c /dev/null > /dev/null 2>&1; then echo "$(1)"; fi;}

# use '-Os' optimization if available, else use -O2
OPTIMIZATION := $(call cc-supports,-Os,-O2)

WARNINGS := -Wall
WARNINGS += $(call cc-supports,-Wstrict-prototypes)
WARNINGS += $(call cc-supports,-Wdeclaration-after-statement)

KERNEL_INCLUDE := ../../../include
CFLAGS += -Wall -Wstrict-prototypes -Wdeclaration-after-statement -Os -s -D_LINUX -DDEFINE_ALTERNATE_TYPES -I$(KERNEL_INCLUDE) 

all: acpidump
$(PROG) : $(SRCS)
	$(CC) $(CFLAGS) $(SRCS) -o $(PROG)

CLEANFILES= $(PROG)

clean : 
	rm -f $(CLEANFILES) $(patsubst %.c,%.o, $(SRCS)) *~

install :
	install acpidump /usr/sbin/acpidump
	install acpidump.8 /usr/share/man/man8

