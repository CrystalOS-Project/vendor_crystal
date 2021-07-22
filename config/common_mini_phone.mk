# Inherit mini common Crystal stuff
$(call inherit-product, vendor/crystal/config/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/crystal/config/telephony.mk)
