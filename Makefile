#
# Copyright © 2015 myOS Group.
#
# This application is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# Contributor(s):
# Amr Aboelela <amraboelela@gmail.com>
#

LDLIBS=-lFoundation

ifeq ($(APP_TYPE),NativeApp)
    LDLIBS+=-lNAOpenGLES -lNAUIKit -lNACoreGraphics -lNAQuartzCore -lNAIOKit
else
    LDLIBS+=-lOpenGLES -lUIKit -lCoreGraphics -lQuartzCore -IOKit
endif

OBJECTS = \
    AppDelegate.o \
    ApplicationsPage.o \
    LauncherVC.o \
    LauncherView.o \
    PageView.o \
    LoadingScreenVC.o \
    FileManager.o \
    ApplicationsData.o \

include ${MYOS_PATH}/sdk/app-makefile

