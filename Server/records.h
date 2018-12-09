#ifndef RECORDS_H
#define RECORDS_H

#include "mytcpserver.h"
#include "database.h"
#include <QDate>

class records : public QObject
{
    Q_OBJECT
public:
    records(MyTcpServer* parent);
    ~records();
public slots:
    void getRecodDay(int idusersocs, const QJsonDocument& json);
    void getRecords(int idusersocs, const QJsonDocument& json);
    void getRecordsW(int idusersocs, const QJsonDocument& json);
    void setRecords(int idusersocs, const QJsonDocument& json);
    void takeChps(int idusersocs, const QJsonDocument& json);
    void takePrewRec(int idusersocs, const QJsonDocument& json);
    void SetRecordReport(int idusersocs, const QJsonDocument& json);
    void SetRc(int idusersocs, QString country, QString adress, QDateTime time_need);

private:
    MyTcpServer* server;
    database* getBd;
    int waitTimeCalc(QDateTime& time_need, QSqlQuery& query, int timeInRoad);
};

#endif // RECORDS_H
