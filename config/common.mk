# Copyright (C) 2018-2020 ArrowOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include vendor/crystal/config/version.mk

PRODUCT_PACKAGE_OVERLAYS += \
    vendor/crystal/overlay/common

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    vendor/crystal/overlay/common

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    Settings \
    Launcher3QuickStep

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/crystal/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.sip.voip.xml

# init file
PRODUCT_COPY_FILES += \
    vendor/crystal/prebuilt/common/etc/init/init.crystal-system_ext.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.crystal-system_ext.rc \
    vendor/crystal/prebuilt/common/etc/init/init.crystal-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.crystal-updater.rc \
    vendor/crystal/prebuilt/common/etc/init/init.openssh.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/init.openssh.rc

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/crystal/build/tools/backuptool.sh:install/bin/backuptool.sh \
    vendor/crystal/build/tools/backuptool.functions:install/bin/backuptool.functions \
    vendor/crystal/build/tools/50-crystal.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-crystal.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/addon.d/50-crystal.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
PRODUCT_COPY_FILES += \
    vendor/crystal/build/tools/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/crystal/build/tools/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/crystal/build/tools/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/backuptool_ab.sh \
    system/bin/backuptool_ab.functions \
    system/bin/backuptool_postinstall.sh

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif
endif

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# Disable remote keyguard animation
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.wm.enable_remote_keyguard_animation=0

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=log

# Sensitive Phone Numbers list
PRODUCT_COPY_FILES += \
    vendor/crystal/prebuilt/common/etc/sensitive_pn.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sensitive_pn.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/crystal/config/permissions/crystal-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/crystal-power-whitelist.xml

# Priv-app permission whitelist
PRODUCT_COPY_FILES += \
	vendor/crystal/config/permissions/privapp-permissions-crystal-system_ext.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-crystal-system_ext.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Enable whole-program R8 Java optimizations for SystemUI and system_server,
# but also allow explicit overriding for testing and development.
SYSTEM_OPTIMIZE_JAVA ?= true
SYSTEMUI_OPTIMIZE_JAVA ?= true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

ifeq ($(CRYSTAL_PURITY),FGAPPS)
    $(call inherit-product, vendor/gapps/gapps_full.mk)
else ifeq ($(CRYSTAL_PURITY),MGAPPS)
    $(call inherit-product, vendor/gapps/gapps_mini.mk)
endif

# Enable whole-program R8 Java optimizations for SystemUI and system_server,
# but also allow explicit overriding for testing and development.
SYSTEM_OPTIMIZE_JAVA ?= true
SYSTEMUI_OPTIMIZE_JAVA ?= true

PRODUCT_PROPERTY_OVERRIDES += \
    pm.dexopt.boot?=verify \
    pm.dexopt.first-boot?=quicken \
    pm.dexopt.install?=speed-profile \
    pm.dexopt.bg-dexopt?=everything

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_PROPERTY_OVERRIDES += \
    pm.dexopt.ab-ota?=quicken
endif

TARGET_ENABLE_OOS_GBOARD_PADDINGS ?=false
ifeq ($(TARGET_ENABLE_OOS_GBOARD_PADDINGS), true)
# Gboard
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.kb_pad_port_b=1

# Gboard side padding (OOS)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.kb_pad_port_l=7 \
    ro.com.google.ime.kb_pad_port_r=7 \
    ro.com.google.ime.kb_pad_land_l=14 \
    ro.com.google.ime.kb_pad_land_r=14
endif

ifeq ($(TARGET_DISABLE_GRALLOC2_P010_SUPPORT), true)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.gralloc.disablep010?=true
endif

# Hide nav Overlays
PRODUCT_PACKAGES += \
    NavigationBarModeGesturalOverlayFS 

# Bootanimation
include vendor/crystal/config/bootanimation.mk

# Fonts
include vendor/crystal/config/fonts.mk

# Packages
include vendor/crystal/config/packages.mk

# Props
include vendor/crystal/config/props.mk

# Sounds
include vendor/crystal/config/sounds.mk

# Enable ThinLTO Source wide Conditionally.
ifeq ($(TARGET_BUILD_WITH_LTO),true)
GLOBAL_THINLTO := true
USE_THINLTO_CACHE := true
SKIP_ABI_CHECKS := true
endif
