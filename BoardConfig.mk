#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/manet

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    vendor_boot \
    boot \
    vendor_dlkm \
    init_boot \
    system \
    recovery \
    product \
    system_ext \
    system_dlkm \
    dtbo \
    vendor \
    odm
#BOARD_USES_RECOVERY_AS_BOOT := true
#init_boot
BOARD_BUILD_INIT_BOOT_IMAGE := true
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_INIT_BOOT_MKBOOTIMG_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_BOOT_HEADER_VERSION := 4

BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := manet
TARGET_NO_BOOTLOADER := true

# Kernel
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_RAMDISK_USE_LZ4 := true
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := \
    video=vfb:640x400,bpp=32,memsize=3072000 \
    disable_dma32=on \
    swinfo.fingerprint=$(LINEAGE_VERSION) \
    mtdoops.fingerprint=$(LINEAGE_VERSION)

OARD_BOOTCONFIG := \
    androidboot.hardware=qcom \
    androidboot.hypervisor.protected_vm.supported=0 \
    androidboot.load_modules_parallel=true \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    androidboot.vendor.qspa=true \
    androidboot.console=0

BOARD_KERNEL_PAGESIZE := 4096

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_INIT_BOOT_MKBOOTIMG_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)
BOARD_VENDOR_BOOT_MKBOOTIMG_ARGS += --header_version $(BOARD_VENDOR_BOOT_HEADER_VERSION)

BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_KERNEL_CONFIG := manet_defconfig
TARGET_KERNEL_SOURCE := kernel/xiaomi/manet

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img 
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img
BOARD_KERNEL_SEPARATED_DTBO := true
# Kernel modules
KERNEL_MODULES_DIR := $(DEVICE_PATH)/prebuilts
 
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_MODULES_DIR)/vendor_ramdisk/modules.load 2>/dev/null))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_MODULES_DIR)/vendor_ramdisk/modules.load.recovery 2>/dev/null))
 
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_MODULES_DIR)/vendor_dlkm/modules.load 2>/dev/null))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(KERNEL_MODULES_DIR)/vendor_ramdisk/*.ko)
BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(KERNEL_MODULES_DIR)/vendor_dlkm/*.ko)
BOARD_SYSTEM_KERNEL_MODULES := $(wildcard $(KERNEL_MODULES_DIR)/system_dlkm/*.ko)
endif
#
TARGET_FSTAB := device/xiaomi/manet/rootdir/etc/fstab.qcom 
# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 20971520
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
BOARD_SUPER_PARTITION_GROUPS := xiaomi_dynamic_partitions
BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    vendor_dlkm \
    system \
    product \
    system_ext \
    system_dlkm \
    vendor \
    odm
BOARD_XIAOMI_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value

# Platform
TARGET_BOARD_PLATFORM := pineapple

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_SYSTEM_DLKM_PROP += $(DEVICE_PATH)/system_dlkm.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_ODM_DLKM_PROP += $(DEVICE_PATH)/odm_dlkm.prop
TARGET_VENDOR_DLKM_PROP += $(DEVICE_PATH)/vendor_dlkm.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2025-12-01

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := 2
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 2

# VINTF
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    $(DEVICE_PATH)/vintf/compatibility_matrix.device.xml \
    $(DEVICE_PATH)/vintf/compatibility_matrix.xiaomi.xml \
    $(DEVICE_PATH)/vintf/compatibility_matrix.manet.xml \
    hardware/qcom-caf/common/vendor_framework_compatibility_matrix.xml

DEVICE_FRAMEWORK_MANIFEST_FILE += \
    $(DEVICE_PATH)/vintf/framework_manifest.xml

DEVICE_MATRIX_FILE := \
    $(DEVICE_PATH)/vintf/compatibility_matrix.xml \
    hardware/qcom-caf/common/compatibility_matrix.xml

DEVICE_MANIFEST_SKUS := pineapple
DEVICE_MANIFEST_PINEAPPLE_FILES := \
    $(DEVICE_PATH)/vintf/manifest_xiaomi.xml \
    $(DEVICE_PATH)/vintf/manifest_pineapple.xml \
    hardware/qcom-caf/sm8650/audio/primary-hal/configs/common/manifest_non_qmaa.xml \
    hardware/qcom-caf/sm8650/audio/primary-hal/configs/common/manifest_non_qmaa_extn.xml

#
TARGET_FS_CONFIG_GEN += $(DEVICE_PATH)/config.fs
#
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm
#
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
#
SKIP_APEX_SEPOLICY_TESTS := true
#
BUILD_BROKEN_VINTF_COMPATIBILITY_CHECK := true
#
BUILD_BROKEN_MISSING_HIDL_INTERFACES := true
# Sepolicy
include device/qcom/sepolicy_vndr/SEPolicy.mk
BOARD_VENDOR_SEPOLICY_DIRS += device/xiaomi/manet/sepolicy/vendor
BOARD_PRIVATE_SEPOLICY_DIRS += device/xiaomi/manet/sepolicy/private
#BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
# Inherit the proprietary files
include vendor/xiaomi/manet/BoardConfigVendor.mk
