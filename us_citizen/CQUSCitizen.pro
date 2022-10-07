APPNAME = CQUSCitizen

include($$(MAKE_DIR)/qt_app.mk)

QMAKE_CXXFLAGS += \

SOURCES += \
CQUSCitizen.cpp

HEADERS += \
CQUSCitizen.h

INCLUDEPATH += \
$(INC_DIR)/CQApp \
$(INC_DIR)/CQUtil \
$(INC_DIR)/CXML \
$(INC_DIR)/CImageLib \
$(INC_DIR)/CFont \
$(INC_DIR)/CPen \
$(INC_DIR)/CBrush \
$(INC_DIR)/CSymbol2D \
$(INC_DIR)/CPixelClip \
$(INC_DIR)/CClipSide \
$(INC_DIR)/CMath \
$(INC_DIR)/CEvent \
$(INC_DIR)/CKeyType \
$(INC_DIR)/CFile \
$(INC_DIR)/CFileType \
$(INC_DIR)/CAlignType \
$(INC_DIR)/CStrUtil \
$(INC_DIR)/CUtil \
$(INC_DIR)/COS \

PRE_TARGETDEPS = \

unix:LIBS += \
-lCQImageButton -lCQMainWindow $$QT_APP_LIBS -lCQPixmapCache \
-lCXML -lCConfig -lCFont \
-lCImageLib -lCMath -lCFileParse -lCFile -lCOS -lCTempFile \
-lCRGBUtil -lCUtil -lCStrUtil -lCGlob -lCRegExp -lCEnv \
-lCAssert -lCStrParse -lCFileUtil -lCPrintF \
$$IMAGE_LIBS -ltre
