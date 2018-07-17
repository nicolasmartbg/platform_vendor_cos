PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.build.selinux=1 \
    ro.boot.vendor.overlay.theme=com.cosmic.overlay.base.stockfixed

# LatinIME gesture typing
ifneq ($(filter tenderloin,$(TARGET_PRODUCT)),)
ifneq ($(filter shamu,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/cos/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/cos/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so
endif
endif

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/media/bootanimation.zip:system/media/bootanimation.zip

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    CellBroadcastReceiver \
    Stk \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# Custom packages
PRODUCT_PACKAGES += \
    OmniJaws \
    Phonograph \
    Gcam \
    RuthlessLauncher \
    Galaxy


# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    librs_jni

# Offline charging animation
PRODUCT_PACKAGES += \
    charger_res_images

# Fonts
PRODUCT_PACKAGES += \
    DU-Fonts

# DU Utils Library
PRODUCT_BOOT_JARS += \
    org.dirtyunicorns.utils

PRODUCT_PACKAGES += \
    org.dirtyunicorns.utils

# Accent and Base packages
PRODUCT_PACKAGES += \
    AmberTheme \
    BlueTheme \
    CyanTheme \
    DeepOrangeTheme \
    DeepPurpleTheme \
    GreenTheme \
    IndigoTheme \
    LightBlueTheme \
    LightGreenTheme \
    LimeTheme \
    OrangeTheme \
    PinkTheme \
    PixelBaseTheme \
    PixelTheme \
    PurpleTheme \
    RedTheme \
    StockBaseTheme \
    StockFixedBaseTheme \
    StockTheme \
    YellowTheme

# Black/DarkUI Packages
PRODUCT_PACKAGES += \
    GBoardDarkTheme \
    SettingsBlackTheme \
    SettingsDarkTheme \
    SystemBlackTheme \
    SystemDarkTheme \
    SystemSettingsIconTint

# Mms depends on SoundRecorder for recorded audio messages
PRODUCT_PACKAGES += \
    Recorder

# Turbo
PRODUCT_PACKAGES += \
    Turbo

# Misc packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    Busybox \
    MusicFX \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Fix Google dialer
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/etc/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# World APN list
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/cos/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

PRODUCT_PACKAGE_OVERLAYS += \
	vendor/cos/overlay/common

# SIMPLIX Versioning
ANDROID_VERSION = 8.1.0
SIMPLIX_VERSION_CODENAME = REL

SIMPLIX_BUILD_TYPE := OFFICIAL
SIMPLIX_VERSION_CODENAME := OFFICIAL

ifeq ($(SIMPLIX_BETA),true)
    SIMPLIX_BUILD_TYPE := BETA
    SIMPLIX_VERSION_CODENAME := BETA
endif

ifneq ($(TARGET_UNOFFICIAL_BUILD_ID),)
    SIMPLIX_BUILD_TYPE := $(TARGET_UNOFFICIAL_BUILD_ID)
endif

SIMPLIX_VERSION_NUMBER := 1.7
SIMPLIX_CODENAME := Dot
SIMPLIX_VER := $(SIMPLIX_VERSION_NUMBER)-$(SIMPLIX_CODENAME)-$(SIMPLIX_BUILD_TYPE)

# Set all versions
SIMPLIX_VERSION := Simplix_$(SIMPLIX_CODENAME)_$(SIMPLIX_BUILD)_$(ANDROID_VERSION)_$(shell date +%Y%m%d)_$(SIMPLIX_VERSION_NUMBER)-$(SIMPLIX_BUILD_TYPE)
SIMPLIX_MOD_VERSION := Simplix_$(SIMPLIX_CODENAME)_$(SIMPLIX_BUILD)_$(ANDROID_VERSION)_$(shell date +%Y%m%d)_$(SIMPLIX_VERSION_NUMBER)-$(SIMPLIX_BUILD_TYPE)

PRODUCT_GENERIC_PROPERTIES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.simplix.version=$(SIMPLIX_VER) \
    ro.mod.version=$(SIMPLIX_VER) \
    ro.simplix.releasetype=$(SIMPLIX_BUILD_TYPE)

#ifeq ($(SIMPLIX_RELEASE),true)
#    CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
#    LIST = $(shell curl -s https://raw.githubusercontent.com/Cosmic-OS/platform_vendor_cos/pulsar-release/cos.devices)
#    FOUND_DEVICE =  $(filter $(CURRENT_DEVICE), $(LIST))
#    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
#      IS_OFFICIAL=true
#    endif
#    ifneq ($(IS_OFFICIAL), true)
#       SIMPLIX_RELEASE=false
#       $(error Device is not official "$(FOUND)")
#    endif
    PRODUCT_GENERIC_PROPERTIES += \
        persist.ota.romname=$(TARGET_PRODUCT) \
        persist.ota.version=$(shell date +%Y%m%d)
#endif
