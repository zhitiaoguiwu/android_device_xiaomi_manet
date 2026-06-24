#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from manet device
$(call inherit-product, device/xiaomi/manet/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_DEVICE := manet
PRODUCT_NAME := lineage_manet
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := 23177RK66C
PRODUCT_MANUFACTURER := xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
#
# 跳过 init 脚本验证（vendor blobs 引用了构建系统不认识的 HIDL 接口）
PRODUCT_SKIP_INIT_VERIFICATION := true

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="missi-user 16 BP2A.250605.031.A3 OS3.0.9.0.WNMCNXM release-keys" \
    BuildFingerprint=Xiaomi/missi/missi:16/BP2A.250605.031.A3/OS3.0.9.0.WNMCNXM:user/release-keys
