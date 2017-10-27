include $(THEOS)/makefiles/common.mk
GO_EASY_ON_ME=1
TWEAK_NAME = VaporSniff
VaporSniff_FILES = Tweak.xm
#VaporSniff_FILES += ColorPicker/HRBrightnessCursor.m
#VaporSniff_FILES += ColorPicker/HRBrightnessSlider.m
#VaporSniff_FILES += ColorPicker/HRColorCursor.m
#VaporSniff_FILES += ColorPicker/HRColorInfoView.m
#VaporSniff_FILES += ColorPicker/HRColorMapView.m
#VaporSniff_FILES += ColorPicker/HRColorPickerView.m
#VaporSniff_FILES += ColorPicker/HRHSVColorUtil.m
#VaporSniff_FILES += ColorPicker/UIImage+CoreGraphics.m
VaporSniff_FILES += ColorPicker2/FCBrightDarkGradView.m
VaporSniff_FILES += ColorPicker2/FCColorPickerViewController.m
VaporSniff_FILES += ColorPicker2/FCColorSwatchView.m

VaporSniff_CFLAGS = -Wno-error -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 PAX"
