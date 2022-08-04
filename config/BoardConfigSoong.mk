PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE

# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/LineageOS/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

SOONG_CONFIG_NAMESPACES += crystalVarsPlugin

SOONG_CONFIG_crystalVarsPlugin :=

define addVar
  SOONG_CONFIG_crystalVarsPlugin += $(1)
  SOONG_CONFIG_crystalVarsPlugin_$(1) := $($1)
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += crystalGlobalVars
SOONG_CONFIG_crystalGlobalVars += \
    aapt_version_code \
    additional_gralloc_10_usage_bits \
    bootloader_message_offset \
    camera_override_format_from_reserved \
    disable_postrender_cleanup \
    gralloc_handle_has_custom_content_md_reserved_size \
    gralloc_handle_has_reserved_size \
    has_legacy_camera_hal1 \
    has_memfd_backport \
    ignores_ftp_pptp_conntrack_failure \
    needs_netd_direct_connect_rule \
    target_alternative_futex_waiters \
    target_health_charging_control_charging_path \
    target_health_charging_control_charging_enabled \
    target_health_charging_control_charging_disabled \
    target_health_charging_control_deadline_path \
    target_health_charging_control_supports_bypass \
    target_health_charging_control_supports_deadline \
    target_health_charging_control_supports_toggle \
    target_init_vendor_lib \
    target_inputdispatcher_skip_event_key \
    target_ld_shim_libs \
    target_process_sdk_version_override \
    target_surfaceflinger_udfps_lib \
    target_trust_usb_control_path \
    target_trust_usb_control_enable \
    target_trust_usb_control_disable \
    uses_camera_parameter_lib \
    uses_egl_display_array

SOONG_CONFIG_NAMESPACES += crystalNvidiaVars
SOONG_CONFIG_crystalNvidiaVars += \
    uses_nv_enhancements

SOONG_CONFIG_NAMESPACES += crystalQcomVars
SOONG_CONFIG_crystalQcomVars += \
    should_wait_for_qsee \
    supports_extended_compress_format \
    supports_hw_fde \
    supports_hw_fde_perf \
    uses_pre_uplink_features_netmgrd \
    uses_qcom_bsp_legacy \
    uses_qti_camera_device \
    needs_camera_boottime_timestamp

# Only create display_headers_namespace var if dealing with UM platforms to avoid breaking build for all other platforms
ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_crystalQcomVars += \
    qcom_display_headers_namespace
endif

# Soong bool variables
SOONG_CONFIG_crystalGlobalVars_camera_override_format_from_reserved := $(TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED)
SOONG_CONFIG_crystalGlobalVars_disable_postrender_cleanup := $(TARGET_DISABLE_POSTRENDER_CLEANUP)
SOONG_CONFIG_crystalGlobalVars_gralloc_handle_has_custom_content_md_reserved_size := $(TARGET_GRALLOC_HANDLE_HAS_CUSTOM_CONTENT_MD_RESERVED_SIZE)
SOONG_CONFIG_crystalGlobalVars_gralloc_handle_has_reserved_size := $(TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE)
SOONG_CONFIG_crystalGlobalVars_gralloc_handle_has_ubwcp_format := $(TARGET_GRALLOC_HANDLE_HAS_UBWCP_FORMAT)
SOONG_CONFIG_crystalGlobalVars_has_legacy_camera_hal1 := $(TARGET_HAS_LEGACY_CAMERA_HAL1)
SOONG_CONFIG_crystalGlobalVars_has_memfd_backport := $(TARGET_HAS_MEMFD_BACKPORT)
SOONG_CONFIG_crystalGlobalVars_ignores_ftp_pptp_conntrack_failure := $(TARGET_IGNORES_FTP_PPTP_CONNTRACK_FAILURE)
SOONG_CONFIG_crystalGlobalVars_needs_netd_direct_connect_rule := $(TARGET_NEEDS_NETD_DIRECT_CONNECT_RULE)
SOONG_CONFIG_crystalGlobalVars_uses_egl_display_array := $(TARGET_USES_EGL_DISPLAY_ARRAY)
SOONG_CONFIG_crystalGlobalVars_target_alternative_futex_waiters := $(TARGET_ALTERNATIVE_FUTEX_WAITERS)
SOONG_CONFIG_crystalNvidiaVars_uses_nv_enhancements := $(NV_ANDROID_FRAMEWORK_ENHANCEMENTS)
SOONG_CONFIG_crystalQcomVars_should_wait_for_qsee := $(TARGET_KEYMASTER_WAIT_FOR_QSEE)
SOONG_CONFIG_crystalQcomVars_supports_extended_compress_format := $(AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT)
SOONG_CONFIG_crystalQcomVars_supports_hw_fde := $(TARGET_HW_DISK_ENCRYPTION)
SOONG_CONFIG_crystalQcomVars_supports_hw_fde_perf := $(TARGET_HW_DISK_ENCRYPTION_PERF)
SOONG_CONFIG_crystalQcomVars_uses_pre_uplink_features_netmgrd := $(TARGET_USES_PRE_UPLINK_FEATURES_NETMGRD)
SOONG_CONFIG_crystalQcomVars_uses_qcom_bsp_legacy := $(TARGET_USES_QCOM_BSP_LEGACY)
SOONG_CONFIG_crystalQcomVars_uses_qti_camera_device := $(TARGET_USES_QTI_CAMERA_DEVICE)
SOONG_CONFIG_crystalQcomVars_needs_camera_boottime_timestamp := $(TARGET_CAMERA_BOOTTIME_TIMESTAMP)

# Set default values
BOOTLOADER_MESSAGE_OFFSET ?= 0
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS ?= 0
TARGET_CAMERA_OVERRIDE_FORMAT_FROM_RESERVED ?= false
TARGET_GRALLOC_HANDLE_HAS_CUSTOM_CONTENT_MD_RESERVED_SIZE ?= false
TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE ?= false
TARGET_GRALLOC_HANDLE_HAS_UBWCP_FORMAT ?= false
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED ?= 1
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED ?= 0
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS ?= true
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE ?= false
TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE ?= true
TARGET_INIT_VENDOR_LIB ?= vendor_init
TARGET_INPUTDISPATCHER_SKIP_EVENT_KEY ?= 0
TARGET_SPECIFIC_CAMERA_PARAMETER_LIBRARY ?= libcamera_parameters
TARGET_SURFACEFLINGER_UDFPS_LIB ?= surfaceflinger_udfps_lib
TARGET_TRUST_USB_CONTROL_PATH ?= /proc/sys/kernel/deny_new_usb
TARGET_TRUST_USB_CONTROL_ENABLE ?= 1
TARGET_TRUST_USB_CONTROL_DISABLE ?= 0

# Soong value variables
SOONG_CONFIG_crystalGlobalVars_aapt_version_code := $(shell date -u +%Y%m%d)
SOONG_CONFIG_crystalGlobalVars_additional_gralloc_10_usage_bits := $(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS)
SOONG_CONFIG_crystalGlobalVars_bootloader_message_offset := $(BOOTLOADER_MESSAGE_OFFSET)
SOONG_CONFIG_crystalGlobalVars_target_health_charging_control_charging_path := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH)
SOONG_CONFIG_crystalGlobalVars_target_health_charging_control_charging_enabled := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED)
SOONG_CONFIG_crystalGlobalVars_target_health_charging_control_charging_disabled := $(TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED)
SOONG_CONFIG_crystalGlobalVars_target_health_charging_control_deadline_path := $(TARGET_HEALTH_CHARGING_CONTROL_DEADLINE_PATH)
SOONG_CONFIG_crystalGlobalVars_target_health_charging_control_supports_bypass := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_BYPASS)
SOONG_CONFIG_crystalGlobalVars_target_health_charging_control_supports_deadline := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_DEADLINE)
SOONG_CONFIG_crystalGlobalVars_target_health_charging_control_supports_toggle := $(TARGET_HEALTH_CHARGING_CONTROL_SUPPORTS_TOGGLE)
SOONG_CONFIG_crystalGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
SOONG_CONFIG_crystalGlobalVars_target_inputdispatcher_skip_event_key := $(TARGET_INPUTDISPATCHER_SKIP_EVENT_KEY)
SOONG_CONFIG_crystalGlobalVars_target_ld_shim_libs := $(subst $(space),:,$(TARGET_LD_SHIM_LIBS))
SOONG_CONFIG_crystalGlobalVars_target_process_sdk_version_override := $(TARGET_PROCESS_SDK_VERSION_OVERRIDE)
SOONG_CONFIG_crystalGlobalVars_target_surfaceflinger_udfps_lib := $(TARGET_SURFACEFLINGER_UDFPS_LIB)
SOONG_CONFIG_crystalGlobalVars_target_trust_usb_control_path := $(TARGET_TRUST_USB_CONTROL_PATH)
SOONG_CONFIG_crystalGlobalVars_target_trust_usb_control_enable := $(TARGET_TRUST_USB_CONTROL_ENABLE)
SOONG_CONFIG_crystalGlobalVars_target_trust_usb_control_disable := $(TARGET_TRUST_USB_CONTROL_DISABLE)
SOONG_CONFIG_crystalGlobalVars_uses_camera_parameter_lib := $(TARGET_SPECIFIC_CAMERA_PARAMETER_LIBRARY)

ifneq ($(filter $(QSSI_SUPPORTED_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_crystalQcomVars_qcom_display_headers_namespace := vendor/qcom/opensource/commonsys-intf/display
else
SOONG_CONFIG_crystalQcomVars_qcom_display_headers_namespace := $(QCOM_SOONG_NAMESPACE)/display
endif

ifneq ($(TARGET_USE_QTI_BT_STACK),true)
PRODUCT_SOONG_NAMESPACES += packages/apps/Bluetooth
endif #TARGET_USE_QTI_BT_STACK

ifneq ($(TARGET_USES_NQ_NFC),true)
PRODUCT_SOONG_NAMESPACES += hardware/nxp
endif #TARGET_USES_NQ_NFC
