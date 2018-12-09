#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>

#include "networkconnection.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<NetworkConnection>("io.qt.examples.NetworkConnection", 1, 0, "NetworkConnection");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    app.setWindowIcon(QIcon(":/Image/icon.png"));
    return app.exec();
}
