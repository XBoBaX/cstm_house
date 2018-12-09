#include <QCoreApplication>
#include <QTextCodec>
#include "mytcpserver.h"

int main(int argc, char *argv[])
{
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("cp866"));
    QCoreApplication a(argc, argv);

    MyTcpServer* sg = MyTcpServer::getInstance();

    return a.exec();//sdsdffdds
}
