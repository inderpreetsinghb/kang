# Inherit common AOKP stuff
$(call inherit-product, vendor/kang/configs/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME
