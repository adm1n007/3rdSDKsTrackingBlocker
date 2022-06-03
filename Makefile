TARGET := iphone:clang:latest:7.0
ARCHS = armv7 arm64
DEBUG = 0
GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = 3rdSDKTrackingBlocker

3rdSDKTrackingBlocker_FILES = Tweak.x
3rdSDKTrackingBlocker_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
