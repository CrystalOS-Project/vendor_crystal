# Inherit common Crystal stuff
$(call inherit-product, vendor/crystal/config/common.mk)

# Inherit Crystal atv device tree
$(call inherit-product, device/crystal/atv/crystal_atv.mk)

# AOSP packages
PRODUCT_PACKAGES += \
    LeanbackIME

# Crystal packages
PRODUCT_PACKAGES += \
    CrystalCustomizer

DEVICE_PACKAGE_OVERLAYS += vendor/crystal/overlay/tv
