# Inherit common KANG stuff
$(call inherit-product, vendor/kang/configs/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/kang/overlay/dictionaries

$(call inherit-product, vendor/kang/configs/telephony.mk)
