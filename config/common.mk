# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= kang

SUPERUSER_EMBEDDED := true

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

 # Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# Common dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/kang/overlay/dictionaries

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

#SELinux
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.selinux=1

# Enable Google Assistant on all devices.
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
   ro.opa.eligible_device=true

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/kang/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/kang/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/kang/prebuilt/common/bin/50-kang.sh:system/addon.d/50-kang.sh \

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/kang/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/kang/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/kang/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/kang/configs/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Lineage-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/kang/configs/permissions/lineage-sysconfig.xml:system/etc/sysconfig/lineage-sysconfig.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/kang/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/kang/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/kang/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Copy all Lineage-specific init rc files
$(foreach f,$(wildcard vendor/kang/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/kang/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is KANG!
PRODUCT_COPY_FILES += \
    vendor/kang/configs/permissions/org.lineageos.android.xml:system/etc/permissions/org.lineageos.android.xml \
    vendor/kang/configs/permissions/privapp-permissions-lineage.xml:system/etc/permissions/privapp-permissions-lineage.xml \
    vendor/kang/configs/permissions/privapp-permissions-cm-legacy.xml:system/etc/permissions/privapp-permissions-cm-legcay.xml \
    vendor/kang/configs/permissions/com.kang.android.xml:system/etc/permissions/com.kang.android.xml

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Hidden API whitelist
PRODUCT_COPY_FILES += \
    vendor/kang/configs/permissions/lineage-hiddenapi-package-whitelist.xml:system/etc/permissions/lineage-hiddenapi-package-whitelist.xml

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/kang/configs/permissions/lineage-power-whitelist.xml:system/etc/sysconfig/lineage-power-whitelist.xml

# Pre-granted permissions
PRODUCT_COPY_FILES += \
    vendor/lineage/config/permissions/lineage-default-permissions.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/default-permissions/lineage-default-permissions.xml

# Include AOSP audio files
include vendor/kang/configs/aosp_audio.mk

# Include kang audio files
include vendor/kang/configs/audio.mk

ifneq ($(TARGET_DISABLE_LINEAGE_SDK), true)
# Lineage SDK
include vendor/kang/configs/lineage_sdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/kang/configs/twrp.mk
endif

# Required KANG packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    mGerrit \
    ROMControl \
    Stk \
    SwagPapers

# Optional KANG packages
PRODUCT_PACKAGES += \
    Email \
    ExactCalculator \
    Exchange2 \
    Terminal

# OmniRom packages
PRODUCT_PACKAGES += \
    OmniSwitch \
    OmniJaws
#    OmniStyle

# Custom Lineage packages
PRODUCT_PACKAGES += \
    AudioFX \
    Backgrounds \
    Eleven \
    ExactCalculator \
    Jelly \
    LineageParts \
    LineageSettingsProvider \
    LineageSetupWizard \
    LockClock \
    Profiles \
    TrebuchetQuickStep \
    WeatherProvider

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Berry styles
PRODUCT_PACKAGES += \
    LineageBlackTheme \
    LineageDarkTheme \
    LineageBlackAccent \
    LineageBlueAccent \
    LineageBrownAccent \
    LineageCyanAccent \
    LineageGreenAccent \
    LineageOrangeAccent \
    LineagePinkAccent \
    LineagePurpleAccent \
    LineageRedAccent \
    LineageYellowAccent

# Extra tools in Lineage
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    powertop \
    setcap \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Custom off-mode charger
ifeq ($(WITH_LINEAGE_CHARGER),true)
PRODUCT_PACKAGES += \
    lineage_charger_res_images \
    font_log.png \
    libhealthd.lineage
endif

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    micro_bench \
    procmem \
    procrank \
    strace

# Conditionally build in su
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    TrebuchetQuickStep

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/kang/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/kang/overlay/common

PRODUCT_VERSION_MAJOR = 17
PRODUCT_VERSION_MINOR = 1
PRODUCT_VERSION_MAINTENANCE := 0

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.root_access=3

# OMS
#PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
#    ro.substratum.verified=true

# Common overlay
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/kang/overlay 
DEVICE_PACKAGE_OVERLAYS += vendor/kang/overlay/common

PRODUCT_VERSION_MAJOR = 16
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0

# Version information used on all builds
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_VERSION_TAGS=release-keys USER=android-build BUILD_UTC_DATE=$(shell date +"%s")

KANG_BUILD_DATE := $(shell LC_ALL=C date +%Y-%m-%d_%H%M)
KANG_BRANCH=ten

ifndef KANG_BUILDTYPE
    KANG_BUILDTYPE := UNRELEASED
endif

KANG_VERSION=$(TARGET_PRODUCT)_$(KANG_BRANCH)_$(KANG_BUILDTYPE)_$(KANG_BUILD_DATE)
KANG_DISPLAY_VERSION := $(KANG_VERSION)

PRODUCT_GENERIC_PROPERTIES += \
    ro.kang.version=$(KANG_VERSION) \
    ro.kang.branch=$(KANG_BRANCH) \
    ro.kang.device=$(KANG_DEVICE) \
    ro.kang.releasetype=$(KANG_BUILDTYPE) \
    ro.modversion=$(KANG_VERSION) \
    ro.kang.display.version=$(KANG_DISPLAY_VERSION)

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/kang/build/target/product/security/kang-releasekey

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/kang/configs/partner_gms.mk
