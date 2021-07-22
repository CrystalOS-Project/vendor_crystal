# Set Crystal specific identifier for Android Go enabled products
PRODUCT_TYPE := go

# Inherit mini common Crystal stuff
$(call inherit-product, vendor/crystal/config/common_mini_phone.mk)
