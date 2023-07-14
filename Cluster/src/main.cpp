#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStyleFactory>
#include <QApplication>
#include "SpeedReceiver.h" // Include the new header
#include "ButtonsReceiver.h"
#include "RPMReceiver.h"
#include "stt.h"
#include <qqml.h>
#include <QMetaType>
#include <string>
#include <iostream>
#include <thread>
#include <CommonAPI/CommonAPI.hpp>
#include "ClusterStubImpl.hpp"
#include "WeatherAPI.h"
#include "youtubeapi.h"
#include "mywidget.h"

using namespace std;
Q_DECLARE_METATYPE(std::string)

int main(int argc, char *argv[])
{
    qRegisterMetaType<std::string>();
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    std::shared_ptr<CommonAPI::Runtime> runtime = CommonAPI::Runtime::get();
    std::shared_ptr<ClusterStubImpl> myService =
        std::make_shared<ClusterStubImpl>();
    runtime->registerService("local", "cluster_service", myService);
    std::cout << "Successfully Registered Service!" << std::endl;

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    SpeedReceiver speedStorage;
    ButtonsReceiver buttonStorage;
    RPMReceiver rpmStorage;
    WeatherAPI weatherAPIStorage;
    YoutubeAPI youtubeAPIStorage;
    STT stt;


    engine.rootContext()->setContextProperty("speedReceiver", &speedStorage);
    engine.rootContext()->setContextProperty("buttonsReceiver", &buttonStorage);
    engine.rootContext()->setContextProperty("rpmReceiver", &rpmStorage);
    engine.rootContext()->setContextProperty("weatherAPI", &weatherAPIStorage);
    engine.rootContext()->setContextProperty("youtubeAPI", &youtubeAPIStorage);
    engine.rootContext()->setContextProperty("stt", &stt);

    QObject::connect(&(*myService), &ClusterStubImpl::signalSpeed, &speedStorage, &SpeedReceiver::receiveSpeed); // Connect the instances
    QObject::connect(&(*myService), &ClusterStubImpl::signalButtons, &buttonStorage, &ButtonsReceiver::receiveButtons); // Connect the instances
    QObject::connect(&(*myService), &ClusterStubImpl::signalRPM, &rpmStorage, &RPMReceiver::receiveRPM); // Connect the instances
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

//    MyWidget widget;

//    QStringList styles = QStyleFactory::keys();
//    app.setStyle(styles[3]);

//    widget.show();

    return app.exec();
}
