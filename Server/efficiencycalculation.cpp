#include "efficiencycalculation.h"

efficiencyCalculation::efficiencyCalculation(MyTcpServer* parent) : QObject()
{
    getBd = new database();
    getBd->connectDB();
    server = parent;

    connect(parent, SIGNAL(setReport(int, const QJsonDocument&)), this, SLOT(setReport1(int, const QJsonDocument&)));
    connect(parent, SIGNAL(getStatUser(int, const QJsonDocument&)), this, SLOT(getStatUser(int, const QJsonDocument&)));
    connect(parent, SIGNAL(getAllStat(int, const QJsonDocument&)), this, SLOT(getAllStat(int, const QJsonDocument&)));
    connect(parent, SIGNAL(getCstmStat(int, const QJsonDocument&)), this, SLOT(getCstmStat(int, const QJsonDocument&)));
}
