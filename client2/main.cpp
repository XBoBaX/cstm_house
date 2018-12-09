//#include <QGuiApplication>
#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QIcon>

#include "networkconnection.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<NetworkConnection>("io.qt.examples.NetworkConnection", 1, 0, "NetworkConnection");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    app.setWindowIcon(QIcon(":/Images/icon.png"));
    return app.exec();
}
