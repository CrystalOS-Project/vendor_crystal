# Inherit common Crystal stuff
$(call inherit-product, vendor/crystal/config/common_mobile.mk)

PRODUCT_SIZE := full

# Fonts
PRODUCT_PACKAGES += \
    fonts_customization.xml

# Recorder
PRODUCT_PACKAGES += \
    Recorder
