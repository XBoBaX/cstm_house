#ifndef CUSTOMSDUTY_H
#define CUSTOMSDUTY_H

#include "mytcpserver.h"
#include "database.h"

class customsduty : public QObject
{
    Q_OBJECT
public:
    customsduty(MyTcpServer* parent);
    ~customsduty();
public slots:
    void getGroup(int idusersocs, const QJsonDocument& json);
private:
    MyTcpServer* server;
    database* getBd;
};


#endif // CUSTOMSDUTY_H
