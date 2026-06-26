LOCAL_PATH := $(call my-dir)
 
include $(CLEAR_VARS)
LOCAL_MODULE        := dtb
LOCAL_MODULE_TAGS   := optional
LOCAL_MODULE_CLASS  := ETC
LOCAL_SRC_FILES     := dtb.img
LOCAL_MODULE_PATH   := $(PRODUCT_OUT)
LOCAL_MODULE_STEM   := dtb.img
include $(BUILD_PREBUILT)
