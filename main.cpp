#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTimer>
#include "speedometer.h"
#include "appcore.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    qmlRegisterType<Speedometer>("com.ulasdikme.speedometer", 1, 0, "Speedometer");
    //SettingsPort settingsPorts;
    AppCore appCore;

    QQmlApplicationEngine engine;
    //engine.rootContext()->setContextProperty("settingsPorts", &settingsPorts);
    engine.rootContext()->setContextProperty("appcore", &appCore);

    //const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QObject *object = engine.rootObjects()[0];
    QObject *speedometer = object->findChild<QObject*>("speedoMeter");
    Speedometer *ptrSpeedometer = qobject_cast<Speedometer*>(speedometer);

    qreal val = 0;
    ptrSpeedometer->setSpeed(val);
    QTimer timer1;

    bool direction;
    QObject::connect(&timer1, &QTimer::timeout, [&]()
    {
        if(val == ptrSpeedometer->getHighestRange())
            direction = false;
        else if(val <= 0.1)
            direction = true;

        if(direction)
            val += 10;
        else
            val -= 10;

        ptrSpeedometer->setSpeed(val);
    });
    timer1.start(100);

    if(engine.rootObjects().isEmpty())
        return -1;

//    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                     &app, [url](QObject *obj, const QUrl &objUrl) {
//        if (!obj && url == objUrl)
//            QCoreApplication::exit(-1);
//    }, Qt::QueuedConnection);
//    engine.load(url);

    return app.exec();
}
