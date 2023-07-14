QT += quick webengine webenginewidgets
CONFIG += c++11
QT += multimedia
QT += network

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
INCLUDEPATH += ../../src-gen-cluster/
SOURCES += main.cpp \
    ../../src-gen-cluster/v1/commonapi/ClusterSomeIPDeployment.cpp \
    ../../src-gen-cluster/v1/commonapi/ClusterSomeIPProxy.cpp \
    ../../src-gen-cluster/v1/commonapi/ClusterSomeIPStubAdapter.cpp \
    WeatherAPI.cpp \
    ClusterStubImpl.cpp \
    ButtonsReceiver.cpp \
    SpeedReceiver.cpp \
    RPMReceiver.cpp \
    youtubeapi.cpp \
    mywidget.cpp \
    stt.cpp


RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

win32:CONFIG(release, debug|release): LIBS += -L/usr/local/lib/release/ -lCommonAPI
else:win32:CONFIG(debug, debug|release): LIBS += -L/usr/local/lib/debug/ -lCommonAPI
else:unix: LIBS += -L/usr/local/lib/ -lCommonAPI

INCLUDEPATH += /usr/local/include/CommonAPI-3.2
DEPENDPATH += /usr/local/include/CommonAPI-3.2

win32:CONFIG(release, debug|release): LIBS += -L/usr/local/lib/release/ -lCommonAPI-SomeIP
else:win32:CONFIG(debug, debug|release): LIBS += -L/usr/local/lib/debug/ -lCommonAPI-SomeIP
else:unix: LIBS += -L/usr/local/lib/ -lCommonAPI-SomeIP

INCLUDEPATH += /usr/local/include/CommonAPI-3.2
DEPENDPATH += /usr/local/include/CommonAPI-3.2

win32:CONFIG(release, debug|release): LIBS += -L/usr/local/lib/release/ -lvsomeip3
else:win32:CONFIG(debug, debug|release): LIBS += -L/usr/local/lib/debug/ -lvsomeip3
else:unix: LIBS += -L/usr/local/lib/ -lvsomeip3

INCLUDEPATH += /usr/local/include
DEPENDPATH += /usr/local/include

INCLUDEPATH += /usr/include/python3.6
DEPENDPATH += /usr/include/python3.6
LIBS += -LC:/usr/lib/python3.6/config-3.6-aarch64-linux-gnu/ -lpython3.6m

HEADERS += \
    ../../src-gen-cluster/v1/commonapi/Cluster.hpp \
    ../../src-gen-cluster/v1/commonapi/ClusterProxy.hpp \
    ../../src-gen-cluster/v1/commonapi/ClusterProxyBase.hpp \
    ../../src-gen-cluster/v1/commonapi/ClusterSomeIPDeployment.hpp \
    ../../src-gen-cluster/v1/commonapi/ClusterSomeIPProxy.hpp \
    ../../src-gen-cluster/v1/commonapi/ClusterSomeIPStubAdapter.hpp \
    ../../src-gen-cluster/v1/commonapi/ClusterStub.hpp \
    ../../src-gen-cluster/v1/commonapi/ClusterStubDefault.hpp \
    WeatherAPI.h \
    ClusterStubImpl.hpp \
    ButtonsReceiver.h \
    RPMReceiver.h \
    SpeedReceiver.h \
    youtubeapi.h \
    mywidget.h \
    stt.h \
    ../../src-gen-cluster/v1/commonapi/wrapper_python.h

DISTFILES += \
    SpeechToText.py \
    commands

#win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../../../../usr/lib/python3.6/config-3.6m-aarch64-linux-gnu/release/ -lpython3.6
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../../../../usr/lib/python3.6/config-3.6m-aarch64-linux-gnu/debug/ -lpython3.6
#else:unix: LIBS += -L$$PWD/../../../../../usr/lib/python3.6/config-3.6m-aarch64-linux-gnu/ -lpython3.6

#INCLUDEPATH += $$PWD/../../../../../usr/include/python3.8
#DEPENDPATH += $$PWD/../../../../../usr/include/python3.8
