LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

SVNVERSION := $(shell $(LOCAL_PATH)/util/getrevision.sh -u)

RELEASE := 0.9.7
VERSION := $(RELEASE)-$(SVNVERSION)
RELEASENAME ?= $(VERSION)

LOCAL_MODULE := flashrom
LOCAL_MODULE_TAGS := optional
# FIXME Should add arm64 support in hwaccess.h instead of doing that
LOCAL_CFLAGS += -D'FLASHROM_VERSION="$(VERSION)"'
LOCAL_CFLAGS += -D'CONFIG_DEFAULT_PROGRAMMER=PROGRAMMER_INVALID'
LOCAL_CFLAGS += -D'CONFIG_DEFAULT_PROGRAMMER_ARGS=""'
# We only need linux_spi programmer
LOCAL_CFLAGS += -D'CONFIG_LINUX_SPI=1'

# Flashrom sources
LOCAL_SRC_FILES := cli_classic.c cli_output.c print.c flashrom.c cli_common.c \
                   helpers.c layout.c udelay.c
# Memory drivers
LOCAL_SRC_FILES += flashchips.c jedec.c spi25.c opaque.c w39.c spi.c at45db.c \
                   en29lv640b.c sfdp.c 82802ab.c sst_fwhub.c spi25_statusreg.c \
                   stm50.c sst49lfxxxc.c sst28sf040.c w29ee011.c
# Programmers
LOCAL_SRC_FILES += linux_spi.c programmer.c

LOCAL_LIBRARIES += libstdc++ libc libm

include $(BUILD_EXECUTABLE)

