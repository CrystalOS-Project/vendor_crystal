# Inherit full common Crystal stuff
$(call inherit-product, vendor/crystal/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Crystal LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/crystal/overlay/dictionaries

$(call inherit-product, vendor/crystal/config/telephony.mk)

ifneq ($(wildcard ./system/core/libunwindstack/tests/files/IsOreBuild.mk),)
    $(call inherit-product-if-exists, system/core/libunwindstack/tests/files/IsOreBuild.mk)
else
    CRYSTAL_BUILD_TYPE := ARGENT
endif