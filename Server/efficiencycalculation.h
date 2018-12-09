#ifndef EFFICIENCYCALCULATION_H
#define EFFICIENCYCALCULATION_H

#include <QObject>
#include "mytcpserver.h"
#include "database.h"

class efficiencyCalculation : public QObject
{
    Q_OBJECT
public:
    efficiencyCalculation(MyTcpServer* parent);
public slots:
    void getStatUser(int idusersocs, const QJsonDocument& json){
        QString username = json["username"].toString();
        QSqlQuery query;
        if (username == "Выберите сотрудника") query.prepare("SELECT inspectiontime, poshlina FROM record_report WHERE resultnow='success'");
        else query.prepare("SELECT inspectiontime, poshlina FROM record_report WHERE servedby=:username");
        query.bindValue(":username", json["username"].toString());
        if(!query.exec()) {qDebug()<<"Unable to SELECT "<<query.lastError(); return;}
        long resultWait=0;
        int i = 0, max=0, min=0;
        QStack<QString> stack;
        QString time;
        QStringList list;
        qDebug()<<"query next "<<query.size();
        while(query.next()){
            time = query.value("inspectiontime").toString();
            qDebug()<<"11";
            stack.push(query.value("poshlina").toString());
            if (min == 0 && i == 0) min = query.value("poshlina").toInt();
            qDebug()<<"12";
            list = time.split(":");
            qDebug()<<list[0].toInt()<<" "<<list[1].toInt();
            resultWait += list[0].toInt() * 60;
            resultWait += list[1].toInt();
            i++;
        }
        if (query.size() == 0){
            QJsonObject obj;
            obj["method"] = "setUserStart";
            obj["count"] = QString::number(0);
            obj["time"] = "00:40";
            obj["max"] = QString::number(0);
            obj["min"] = QString::number(0);
            obj["sr"] = QString::number(0);
            server->sendToClient(idusersocs, obj);
            return;
        }
        qDebug()<<"2";
        if (resultWait/i > 60) {
            qDebug()<<"6"<<(resultWait/i)/60;
            int h = (resultWait/i)/60;
            time = QString::number(h) + ":" + QString::number((resultWait/i) - (h*60));
        }
        else time = "00:" + QString::number(resultWait/i);
        qDebug()<<"sr vremya oshidaniya: "<<time;
        long sr = 0, j=0;
        qDebug()<<"stack next";
        while (!stack.isEmpty()) {
            qDebug()<<j;
            int st = stack.pop().toInt();
            if (max < st) max=st;
            if (min > st) min = st;
            j++; sr += st;
        }
        sr = sr / j;
        QJsonObject obj;
        obj["method"] = "setUserStart";
        obj["count"] = QString::number(i);
        obj["time"] = time;
        obj["max"] = QString::number(max);
        obj["min"] = QString::number(min);
        obj["sr"] = QString::number(sr);
        server->sendToClient(idusersocs, obj);
    }

    void setReport1(int idusersocs, const QJsonDocument& json){
        qDebug()<<json["recordsid"]; qDebug()<<json["inspectiontime"];
        QStringList list = json["inspectiontime"].toString().split(":");
        QString time = "";
        if (list[0] == "") time += "00";
        else time += list[0];
        time+=":";
        if (list[1] == "") time += "00";
        else time += list[1];
        time += ":00";
        QString price = json["poshlina"].toString();
        price = price.remove(price.indexOf("."), price.length());
        qDebug()<<price;
        if (price == "") price = "0";
        QSqlQuery query;
        query.prepare("UPDATE record_report SET adress=:adress, servedby=:servedby, countproductions=:countproductions, commentfinish=:commentfinish, resultnow=:resultnow WHERE recordsid=:recordsid");
        query.bindValue(":resultnow", json["resultnow"].toString());
        query.bindValue(":recordsid", json["recordsid"].toString());
        query.bindValue(":servedby", json["ServedBy"].toString());
        query.bindValue(":commentfinish", json["commentfinish"].toString());
        query.bindValue(":countproductions", json["countproductions"].toString());
        query.bindValue(":adress", json["adress"].toString());
        if(!query.exec()) {qDebug()<<"Unable to Input "<<query.lastError(); return;}
        query.prepare("UPDATE record_report SET inspectiontime=:inspectiontime WHERE recordsid=:recordsid");
        query.bindValue(":recordsid", json["recordsid"].toString());
        query.bindValue(":inspectiontime", time);
        if(!query.exec()) {qDebug()<<"Unable to Input2 "<<query.lastError(); return;}
        query.prepare("UPDATE record_report SET poshlina=:poshlina WHERE recordsid=:recordsid");
        query.bindValue(":recordsid", json["recordsid"].toString());
        query.bindValue(":poshlina", price);
        if(!query.exec()) {qDebug()<<"Unable to Input3 "<<query.lastError(); return;}
        query.prepare("SELECT inspectiontime FROM record_report WHERE resultnow NOT LIKE 'wait' and adress = :adress");
        query.bindValue(":adress", json["adress"].toString());
        if(!query.exec()) {qDebug()<<"Unable to SELECT "<<query.lastError(); return;}
        long resultWait=0;
        int i = 0;
        while(query.next()){
            time = query.value("inspectiontime").toString();
            list = time.split(":");
            qDebug()<<list[0].toInt()<<" "<<list[1].toInt();
            resultWait += list[0].toInt() * 60;
            resultWait += list[1].toInt();
            i++;
        }
        if (resultWait/i > 60) {
            int h = (resultWait/i)/60;
            time = QString::number(h) + ":" + QString::number((resultWait/i) - (h*60));
        }
        else time = "00:" + QString::number(resultWait/i);
        qDebug()<<"sr vremya oshidaniya: "<<time;
        query.prepare("UPDATE cstm_house SET waiting_time=:waiting_time WHERE adress=:adress");
        query.bindValue(":adress", json["adress"].toString());
        query.bindValue(":waiting_time", time);
        if(!query.exec()) {qDebug()<<"Unable to UPDATE cstm_house"<<query.lastError(); return;}



//Тестовый комментарий
    };
    void getAllStat(int idusersocs, const QJsonDocument& json){
        QSqlQuery query;
        QJsonObject obj;
        query.prepare("select count(*) from record_report");
        if(!query.exec()) {qDebug()<<"Unable to select"<<query.lastError(); return;}
        query.next();
        obj["method"] = "setAllStat";
        obj["countAll"] = QString::number(query.value(0).toInt());
        for (int i=1;i<=12;i++) {
            query.prepare("select round(avg(poshlina)) from record_report INNER JOIN records on record_report.recordsid = records.id WHERE record_report.resultnow = 'success' AND date_part('month', records.arrivaltime) = :m");
            query.bindValue(":m", QString::number(i));
            if(!query.exec()) {qDebug()<<"Unable to select"<<query.lastError(); return;}
            query.next();
            obj["mounth" + QString::number(i)] = QString::number(query.value(0).toInt());
            for (int j=1;j<=5;j++){
                query.prepare("select round(avg(poshlina)) from record_report INNER JOIN records on record_report.recordsid = records.id WHERE record_report.resultnow = 'success' AND date_part('month', records.arrivaltime) = :m AND to_char(arrivaltime, 'W')::integer = :n1");
                query.bindValue(":m", QString::number(i));
                query.bindValue(":n1", QString::number(j));
                if(!query.exec()) {qDebug()<<"Unable to select"<<query.lastError(); return;}
                query.next();
                obj["" + QString::number(i) + QString::number(j)] = QString::number(query.value(0).toInt());
            }
        }

        server->sendToClient(idusersocs, obj);
    }
    void getCstmStat(int idusersocs, const QJsonDocument& json){
        qDebug()<<json;
        QSqlQuery query;
        QJsonObject obj;
        obj["method"] = "getCstmStat";

        qDebug()<<"1";
        query.prepare("SELECT count(*) FROM record_report INNER JOIN records on records.id = record_report.recordsid WHERE records.adress = :ad AND record_report.resultnow = 'success' AND date_part('day', records.arrivaltime) = date_part('day', now())");
        query.bindValue(":ad", json["cstm"].toString());
        if(!query.exec()) {qDebug()<<"Unable to select"<<query.lastError(); return;}
        query.next();
        obj["dS"] = query.value(0).toString();
        query.prepare("SELECT count(*) FROM record_report INNER JOIN records on records.id = record_report.recordsid WHERE records.adress = :ad AND record_report.resultnow = 'canсell' AND date_part('day', records.arrivaltime) = date_part('day', now())");
        query.bindValue(":ad", json["cstm"].toString());
        if(!query.exec()) {qDebug()<<"Unable to select"<<query.lastError(); return;}
        query.next();
        obj["dC"] = query.value(0).toString();
        qDebug()<<"2";

        query.prepare("SELECT count(*) FROM record_report INNER JOIN records on records.id = record_report.recordsid WHERE records.adress = :ad AND record_report.resultnow = 'success' AND date_part('month', records.arrivaltime) = date_part('month', now())");
        query.bindValue(":ad", json["cstm"].toString());
        if(!query.exec()) {qDebug()<<"Unable to select"<<query.lastError(); return;}
        query.next();
        obj["mS"] = query.value(0).toString();
        query.prepare("SELECT count(*) FROM record_report INNER JOIN records on records.id = record_report.recordsid WHERE records.adress = :ad AND record_report.resultnow = 'canсell' AND date_part('month', records.arrivaltime) = date_part('month', now())");
        query.bindValue(":ad", json["cstm"].toString());
        if(!query.exec()) {qDebug()<<"Unable to select"<<query.lastError(); return;}
        query.next();
        obj["mC"] = query.value(0).toString();
        qDebug()<<"3";

        query.prepare("SELECT count(*) FROM record_report INNER JOIN records on records.id = record_report.recordsid WHERE records.adress = :ad AND record_report.resultnow = 'success' AND date_part('year', records.arrivaltime) = date_part('year', now())");
        query.bindValue(":ad", json["cstm"].toString());
        if(!query.exec()) {qDebug()<<"Unable to select"<<query.lastError(); return;}
        query.next();
        obj["yS"] = query.value(0).toString();
        query.prepare("SELECT count(*) FROM record_report INNER JOIN records on records.id = record_report.recordsid WHERE records.adress = :ad AND record_report.resultnow = 'canсell' AND date_part('year', records.arrivaltime) = date_part('year', now())");
        query.bindValue(":ad", json["cstm"].toString());
        if(!query.exec()) {qDebug()<<"Unable to select"<<query.lastError(); return;}
        query.next();
        obj["yС"] = query.value(0).toString();

        qDebug()<<"3";

        query.prepare("SELECT count(*) FROM record_report INNER JOIN records on records.id = record_report.recordsid WHERE records.adress = :ad AND record_report.resultnow = 'success' AND date_part('dow', records.arrivaltime) = date_part('dow', now())");
        query.bindValue(":ad", json["cstm"].toString());
        if(!query.exec()) {qDebug()<<"Unable to select"<<query.lastError(); return;}
        query.next();
        obj["wS"] = query.value(0).toString();
        query.prepare("SELECT count(*) FROM record_report INNER JOIN records on records.id = record_report.recordsid WHERE records.adress = :ad AND record_report.resultnow = 'canсell' AND date_part('dow', records.arrivaltime) = date_part('dow', now())");
        query.bindValue(":ad", json["cstm"].toString());
        if(!query.exec()) {qDebug()<<"Unable to select"<<query.lastError(); return;}
        query.next();
        obj["wC"] = query.value(0).toString();
        server->sendToClient(idusersocs, obj);
    }
private:
    MyTcpServer* server;
    database* getBd;
};

#endif // EFFICIENCYCALCULATION_H
