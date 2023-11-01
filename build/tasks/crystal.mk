# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017 The LineageOS Project
# Copyright (C) 2021-2022 CrystalOS Project
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

# -----------------------------------------------------------------
# Crystal OTA update package
ifeq ($(TARGET_BUILD_VARIANT),eng)
CRYSTAL_TARGET_PACKAGE := $(PRODUCT_OUT)/ENG-CrystalOS-$(CRYSTAL_VERSION)-$(CRYSTAL_VERSION_NAME)-$(CRYSTAL_BUILD_TYPE)-$(CRYSTAL_DEVICE)-$(CRYSTAL_BUILD_DATE).zip
else
CRYSTAL_TARGET_PACKAGE := $(PRODUCT_OUT)/CrystalOS-$(CRYSTAL_VERSION)-$(CRYSTAL_VERSION_NAME)-$(CRYSTAL_BUILD_TYPE)-$(CRYSTAL_DEVICE)-$(CRYSTAL_BUILD_DATE).zip
endif

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: crystal
crystal: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(CRYSTAL_TARGET_PACKAGE)
	$(hide) $(SHA256) $(CRYSTAL_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(CRYSTAL_TARGET_PACKAGE).sha256sum
	@echo "Package Complete: $(CRYSTAL_TARGET_PACKAGE)" >&2
	echo "";
	cat vendor/crystal/build/ASCII;
	echo "";
