#include "profile.h"

Profile::Profile(MyTcpServer* parent) : QObject()
{
    getBd = new database();
    getBd->connectDB();
    server = parent;
    connect(parent, SIGNAL(profileSignUp(int, const QJsonDocument&)), this, SLOT(SignUp(int, const QJsonDocument&)));
    connect(parent, SIGNAL(profileRegister(int, const QJsonDocument&)), this, SLOT(Register(int, const QJsonDocument&)));
    connect(parent, SIGNAL(profileSetProfile(int, const QJsonDocument&)), this, SLOT(SetProfile(int, const QJsonDocument&)));
}

Profile::~Profile(){
    delete getBd;
}

void Profile::SetProfile(int idusersocs, const QJsonDocument &json){
    QString userFlag = json["userFlag"].toString();
    QString mail = json["mail"].toString();
    QString phone = json["phone"].toString();
    QString count = json["count"].toString();
    QString username = json["username"].toString();
    QSqlQuery query;
    query.prepare("UPDATE users_client SET userflag = :flag, mail = :mail, phone = :phone, count = :count WHERE name = :name");
    query.bindValue(":name", username);
    query.bindValue(":flag", userFlag);
    query.bindValue(":mail", mail);
    query.bindValue(":phone", phone);
    query.bindValue(":count", count);
    if(!query.exec()) qDebug()<<"Unable to SELECT. "<<query.lastError();
}

void Profile::Register(int idusersocs, const QJsonDocument &json){
    QString username = json["username"].toString();
    QString password = json["password"].toString();
    QString password2 = json["password"].toString();
    QSqlQuery query;
    query.prepare("SELECT * FROM users_client WHERE name = :name");
    query.bindValue(":name", username);
    query.bindValue(":password", password);
    QJsonObject obj{
        {"method", "Register"}
    };
    if(!query.exec()) qDebug()<<"Unable to SELECT";
    if (query.size() != 0) {
        qDebug()<<"Nick alreadt ex";
        obj["username"] = username;
        obj["answer"] = "UserAlreadyEx";
    }
    else{
        query.prepare("INSERT INTO users_client (name, password) VALUES(:name, :password)");
        query.bindValue(":name", username);
        query.bindValue(":password", password);
        if(!query.exec()) qDebug()<<"Unable to Input";
    }
    server->sendToClient(idusersocs, obj);
}

void Profile::SignUp(int idusersocs, const QJsonDocument& json)
{
    QString username = json["username"].toString();
    QString password = json["password"].toString();
    QString workOrClient = json["workOrClient"].toString();
    QSqlQuery query;

    if (workOrClient == "0") query.prepare("SELECT * FROM users_client WHERE name = :name AND password = :password");
    else query.prepare("SELECT * FROM users WHERE name = :name AND password = :password");
    query.bindValue(":name", username);
    query.bindValue(":password", password);
    if(!query.exec()) qDebug()<<"Unable to SELECT";

    QJsonObject obj{
        {"method", "SignUp"},
        {"user", username},
    };
    if (query.size() == 0) {
        qDebug()<<"Not correct username or password";
        obj["answer"] = "bad";
    }
    else {
        obj["answer"] = "good";
        if (workOrClient != "0") {
            qDebug()<<"WORKER!!!!!!!!!!!!!!!!!!!!!!";
            query.next();
            obj["branch"] = query.value("branchnumber").toString();
            obj["admin"] = query.value("admin").toString();
            query.prepare("SELECT branchnumber FROM users");
            if(!query.exec()) qDebug()<<"Unable to SELECT";
            QJsonArray chpnts;
            int ii = 0;
            while(query.next()){
                QJsonObject record;
                record["name"] = query.value(0).toString();
                chpnts.append(record); ii++;
            }
            obj["chpnts"] = chpnts;
            obj["count"] = QString::number(ii);
            query.prepare("SELECT cstm_house.adress, count(cstm_house.adress), MAX(poshlina), MIN(poshlina), AVG(poshlina), AVG(waiting_time), AVG(inspectiontime) FROM cstm_house INNER JOIN record_report on record_report.adress = cstm_house.adress group by cstm_house.adress;");
            if(!query.exec()) qDebug()<<"Unable to SELECT";
            QJsonArray chpnts2;
            int ii2 = 0;
            while(query.next()){
                QJsonObject record;
                record["adress"] = query.value(0).toString();
                record["count"] = query.value(1).toString();
                record["max"] = query.value(2).toString();
                record["min"] = query.value(3).toString();
                record["sr"] = query.value(4).toString();
                record["wait"] = query.value(5).toString();
                record["inspect"] = query.value(6).toString();
                chpnts2.append(record); ii2++;
            }
            obj["chpnts2"] = chpnts2;
            obj["count2"] = QString::number(ii2);

        }
        else {
            query.next();
            obj["userflag"] = query.value("userflag").toString();
            obj["mail"] = query.value("mail").toString();
            obj["phone"] = query.value("phone").toString();
            obj["count"] = query.value("count").toString();
            int count_wait = 0, count_success = 0, count_fatal = 0;
            query.prepare("SELECT resultnow FROM records INNER JOIN record_report on records.id = record_report.recordsid  WHERE username = :name");
            query.bindValue(":name", username);
            if(!query.exec()) qDebug()<<"Unable to SELECT";
            qDebug()<<username<<" "<<query.size();
            while(query.next()){
                if (query.value("resultnow").toString() == "wait") count_wait++;
                else if (query.value("resultnow").toString() == "success") count_success++;
                else count_fatal++;
            }
            obj["count_wait"] = QString::number(count_wait);
            obj["count_success"] = QString::number(count_success);
            obj["count_fatal"] = QString::number(count_fatal);
        }
    }
    server->sendToClient(idusersocs, obj);
}
