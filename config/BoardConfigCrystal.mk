include vendor/crystal/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/crystal/config/BoardConfigQcom.mk
endif

include vendor/crystal/config/BoardConfigSoong.mk
