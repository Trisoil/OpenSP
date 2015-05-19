#-------------------------------------------------
#
# Project created by QtCreator 2014-10-12T14:57:24
#
#-------------------------------------------------

QT       += core gui declarative
QT       += qml quick
QT += serialport
QT += core
QT += gui
QT += multimedia
QT += printsupport
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = OpenSP
TEMPLATE = app
#QTPLUGIN+=qwindows
CONFIG+=static
LIBS += E:\C\Qt\QT5.3.1_static_build\plugins\platforms\libqwindows.a
CONFIG += no_import_scan

SOURCES += main.cpp\
        widget.cpp \
    qqmltest.cpp \
    qmyconsole.cpp \
    qmyimage.cpp \
    lzss.cpp

HEADERS  += widget.h \
    qqmltest.h \
    qmyconsole.h \
    qmyimage.h \
    lzss.h

FORMS    +=

OTHER_FILES += \
    qml/ToolBtn.qml \
    qml/TabWidget.qml \
    qml/SysBtnGroup.qml \
    qml/SysBtn.qml \
    qml/qmlmain.qml \
    qml/MainWidget.qml \
    qml/LabelBtn.qml \
    qml/Content1.qml \
    qml/Warnning.qml \
    qml/Mycombo.qml \
    qml/Myprogress.qml \
    qml/SetBackColor.qml \
    qml/DropWhere.qml

RC_FILE += icon.rc
