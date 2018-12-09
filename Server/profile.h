#ifndef PROFILE_H
#define PROFILE_H

#include "mytcpserver.h"
#include "database.h"

class Profile : public QObject
{
    Q_OBJECT
public:
    Profile(MyTcpServer* parent);
    ~Profile();
public slots:
    void SignUp(int idusersocs, const QJsonDocument& json);
    void SetProfile(int idusersocs, const QJsonDocument& json);
    void Register(int idusersocs, const QJsonDocument& json);
private:
    MyTcpServer* server;
    database* getBd;
};

#endif // PROFILE_H
