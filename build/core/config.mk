# Copyright (C) 2015 The CyanogenMod Project
#           (C) 2017-2018 The CrystalOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

CRYSTAL_SRC_API_DIR := $(TOPDIR)prebuilts/crystal-sdk/api
INTERNAL_CRYSTAL_PLATFORM_API_FILE := $(TARGET_OUT_COMMON_INTERMEDIATES)/PACKAGING/crystal_public_api.txt
INTERNAL_CRYSTAL_PLATFORM_REMOVED_API_FILE := $(TARGET_OUT_COMMON_INTERMEDIATES)/PACKAGING/crystal_removed.txt
FRAMEWORK_CRYSTAL_PLATFORM_API_FILE := $(TOPDIR)crystal-sdk/api/crystal_current.txt
FRAMEWORK_CRYSTAL_PLATFORM_REMOVED_API_FILE := $(TOPDIR)crystal-sdk/api/crystal_removed.txt
FRAMEWORK_CRYSTAL_API_NEEDS_UPDATE_TEXT := $(TOPDIR)vendor/crystal/build/core/apicheck_msg_current.txt

# Rules for QCOM targets
include $(TOPDIR)vendor/crystal/build/core/qcom_target.mk
