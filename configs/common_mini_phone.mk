$(call inherit-product, vendor/kang/configs/common_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

$(call inherit-product, vendor/kang/configs/telephony.mk)
