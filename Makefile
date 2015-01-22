#
# Copyright 2014 myOS Group. All rights reserved.
#

LIB_NAME=myApps
CFLAGS=-DDEBUG -DML -fblocks
LDLIBS=-llog -landroid -lCoreFoundation -lFoundation -lNAUIKit -lNAIOKit -lNAOpenGLES

#-lGLESv1_CM -lGLESv1_enc -lEGL

OBJECTS = \
    rd_app_glue.o \
    rd_main.o \
    AppDelegate.o \
    FileManager.o \
    ApplicationsData.o \
    ApplicationsPage.o \
    LauncherVC.o \
    LauncherView.o \
    PageView.o \
    LoadingScreenVC.o \

include ${MYOS_PATH}/android/sdk/resources/makefile-shared
