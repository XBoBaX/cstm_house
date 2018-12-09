#include "customsduty.h"

customsduty::customsduty(MyTcpServer* parent) : QObject()
{
    getBd = new database();
    getBd->connectDB();
    server = parent;
    connect(parent, SIGNAL(dutyGetGroup(int, const QJsonDocument&)), this, SLOT(getGroup(int, const QJsonDocument&)));
}

customsduty::~customsduty(){
    delete getBd;
}

void customsduty::getGroup(int idusersocs, const QJsonDocument &json){
    QString index = json["index"].toString();
    QSqlQuery query;
    query.prepare("SELECT * FROM code_tovar_import WHERE group_numver = :index LIMIT 100");
    query.bindValue(":index", index);
    QJsonObject obj;
    obj["method"] = "getGroup";
    QJsonArray chpnts;
    if(!query.exec()) qDebug()<<"Unable to SELECT";
    while(query.next()){ // Заполняем в JSON записи
        QJsonObject record;
        record["id"] = query.value(0).toInt();
        record["group"] = query.value(1).toString();
        record["code"] = query.value(2).toString();
        record["name"] = query.value(3).toString();
        record["full"] = query.value(4).toInt();
        record["pref"] = query.value(5).toInt();
        chpnts.append(record);
    }
    obj["chpnts"] = chpnts;
    server->sendToClient(idusersocs, obj);
}
