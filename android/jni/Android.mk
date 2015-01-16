# Android.mk

LOCAL_PATH := $(call my-dir) 

# Shared variables
include $(CLEAR_VARS)

ROOT_DIR := $(LOCAL_PATH)/../..

include $(CLEAR_VARS)

LOCAL_MODULE := gladmanaes

# the includes needed to build the module
LOCAL_C_INCLUDES := $(ROOT_DIR)/aes.h \
					$(ROOT_DIR)/aescpp.h \
					$(ROOT_DIR)/aesopt.h \
					$(ROOT_DIR)/aestab.h \
					$(ROOT_DIR)/brg_endian.h \
					$(ROOT_DIR)/aes.h

# 'public' headers for others when importing as a module (in our case the same as the local includes)
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)

FILE_LIST := $(ROOT_DIR)/aes_modes.c \
			 $(ROOT_DIR)/aescrypt.c \
			 $(ROOT_DIR)/aeskey.c \
			 $(ROOT_DIR)/aestab.c

# remove the local path prepended to the list of files
FILE_LIST := $(FILE_LIST:$(LOCAL_PATH)/%=%)

LOCAL_SRC_FILES := $(FILE_LIST)

# uncomment for debugging
# $(info including files: $(LOCAL_SRC_FILES))

include $(BUILD_STATIC_LIBRARY)
