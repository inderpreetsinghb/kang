# KANG System Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.kang.version=$(KANG_VERSION) \
    ro.kang.releasetype=$(KANG_BUILDTYPE) \
    ro.kang.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.modversion=$(KANG_VERSION) \

# KANG Platform Display Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.kang.display.version=$(KANG_DISPLAY_VERSION)

# LineageOS Platform SDK Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.sdk=$(LINEAGE_PLATFORM_SDK_VERSION)

# LineageOS Platform Internal Version
ADDITIONAL_BUILD_PROPERTIES += \
    ro.lineage.build.version.plat.rev=$(LINEAGE_PLATFORM_REV)
