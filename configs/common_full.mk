# Inherit common KANG stuff
$(call inherit-product, vendor/kang/configs/common.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder

# SwagPapers
PRODUCT_PACKAGES += \
    SwagPapers
