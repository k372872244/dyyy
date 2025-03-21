# 编译目标和架构
TARGET = iphone:clang:latest:15.0
ARCHS = arm64 arm64e

# 根据参数选择 rootless/roothide 方案
SCHEME ?= rootless
ifeq ($(SCHEME),roothide)
    export THEOS_PACKAGE_SCHEME = roothide
else ifeq ($(SCHEME),rootless)
    export THEOS_PACKAGE_SCHEME = rootless
endif

# 调试模式关闭
DEBUG = 0
INSTALL_TARGET_PROCESSES = Aweme

# 自动检测 Theos 路径（适配 GitHub Actions）
THEOS ?= $(shell echo $${THEOS:-$(HOME)/theos})

# 包含 Theos 的通用配置
include $(THEOS)/makefiles/common.mk

# 插件配置
TWEAK_NAME = DYYY

# 源文件列表
DYYY_FILES = DYYY.xm DYYYSettingViewController.m CityManager.m

# 编译参数
DYYY_CFLAGS = -fobjc-arc -w
CXXFLAGS += -std=c++11
CCFLAGS += -std=c++11

# Logos 相关配置
DYYY_LOGOS_DEFAULT_GENERATOR = internal
export THEOS_STRICT_LOGOS = 0
export ERROR_ON_WARNINGS = 0
export LOGOS_DEFAULT_GENERATOR = internal

# 包含 tweak 编译规则
include $(THEOS_MAKE_PATH)/tweak.mk

# 清理规则
clean::
	@rm -rf .theos packages

# 移除本地设备安装步骤
