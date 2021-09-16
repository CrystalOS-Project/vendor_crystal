# Inherit common mobile Crystal stuff
$(call inherit-product, vendor/crystal/config/common.mk)

# Default notification/alarm sounds
PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

# AOSP packages
PRODUCT_PACKAGES += \
    Email \
    Exchange2

# Accents
PRODUCT_PACKAGES += \
    CrystalBlackTheme \
    CrystalBlackAccent \
    CrystalBlueAccent \
    CrystalBrownAccent \
    CrystalCyanAccent \
    CrystalGreenAccent \
    CrystalOrangeAccent \
    CrystalPinkAccent \
    CrystalPurpleAccent \
    CrystalRedAccent \
    CrystalYellowAccent

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Customizations
PRODUCT_PACKAGES += \
    IconShapeSquareOverlay \
    CrystalNavigationBarNoHint \
    NavigationBarMode2ButtonOverlay

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet
