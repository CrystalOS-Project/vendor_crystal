# Inherit full common Crystal stuff
$(call inherit-product, vendor/crystal/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Crystal LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/crystal/overlay/dictionaries
