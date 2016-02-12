
LDLIBS=-lFoundation

LDLIBS+=-lOpenGLES_parent -lUIKit_parent -lCoreGraphics_parent -lQuartzCore_parent -lIOKit_parent

OBJECTS = \
    AppDelegate.o \
    LauncherVC.o \
    LauncherView.o \
    PageView.o \
    LoadingScreenVC.o \
    FileManager.o \

include ${MYOS_PATH}/sdk/app-makefile
