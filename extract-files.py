#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixup_remove,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

# Remove obsolete AIDL version dependencies from proprietary camera blobs.
# HyperOS camera/ODM blobs link against graphics.allocator-V1-ndk, while
# AOSP/LineageOS builds V2 as the latest. Soong flags a build-time conflict
# when a module's dependency chain includes both V1-ndk-source and V2-ndk-source.
# Since V2 is backwards-compatible, removing the V1 NEEDED entry resolves the
# conflict without affecting runtime behavior.
lib_fixups: lib_fixups_user_type = {
    ('android.hardware.graphics.allocator-V1-ndk',): lib_fixup_remove,
    ('android.hardware.biometrics.face-V3-ndk',): lib_fixup_remove,
    ('android.hardware.biometrics.common-V3-ndk',): lib_fixup_remove,
    ('libclang_rt.ubsan_standalone-aarch64-android',): lib_fixup_remove,
}
blob_fixups: blob_fixups_user_type = {
    # 修复小米固件中损坏的 XML 声明
    (
        'odm/etc/camera/enhance_motiontuning.xml',
        'odm/etc/camera/night_motiontuning.xml',
        'odm/etc/camera/motiontuning.xml'
    ): blob_fixup()
        .regex_replace('xml=version', 'xml version'),
    
}
namespace_imports = [
    'device/xiaomi/manet',
]

module = ExtractUtilsModule(
    'manet',
    'xiaomi',
    check_elf=False, 
    lib_fixups=lib_fixups,
    blob_fixups=blob_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
