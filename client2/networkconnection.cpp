#include "networkconnection.h"
#include <QNetworkInterface>
NetworkConnection::NetworkConnection(QObject *parent) : QObject(parent)
{
    mTcpSocket = new QTcpSocket(this);
    QString ipAddress;
    QList<QHostAddress> ipAddressesList = QNetworkInterface::allAddresses();
    for (int i = 0; i < ipAddressesList.size(); ++i)
    {
        if (ipAddressesList.at(i) != QHostAddress::LocalHost && ipAddressesList.at(i).toIPv4Address())
        {
            ipAddress = ipAddressesList.at(i).toString();
            break;
        }
    }
    mTcpSocket->connectToHost(ipAddress, 6000);
    connect(mTcpSocket, SIGNAL(connected()), SLOT(slotConnected()));
    connect(mTcpSocket, SIGNAL(readyRead()), SLOT(slotReadRead()));
    connect(mTcpSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(slotError(QAbstractSocket::SocketError)));
}

void NetworkConnection::fabricMethod(const QJsonDocument &json){
    if (namefile != "0"){
        qDebug()<<"_____________1";
        QFile file(namefile); file.open(QIODevice::WriteOnly);
        file.write(buff); file.close();
        namefile = "0";
        qDebug()<<"_____________2";
        return;
    }
    if (json["method"] == "SignUp"){
        bool success = json["answer"] == "good" ? true : false;
        QString count = json["count"].toString();
        QString count2 = json["count2"].toString();
        QString list = "", listCount = "", list2 = "", list3 = "", list4 = "", list5 = "", list6 = "", list7 = "", list8 = "";
        for (int i=0;i<count.toInt();i++){
            list += json["chpnts"][i]["name"].toString();
            list += ",";
        }
        qDebug()<<list;
        for (int i=0;i<count2.toInt();i++){
            qDebug()<<json["chpnts2"][i];
            list2 += json["chpnts2"][i]["adress"].toString(); list2 += ",";
            list3 += json["chpnts2"][i]["count"].toString(); list3 += ",";
            list4 += json["chpnts2"][i]["max"].toString(); list4 += ",";
            list5 += json["chpnts2"][i]["min"].toString(); list5 += ",";
            list6 += json["chpnts2"][i]["sr"].toString(); list6 += ",";
//            list7 += json["chpnts2"][i]["wait"].toString(); list7 += ",";
            QString temp = json["chpnts2"][i]["wait"].toString();
            QStringList tp1 = temp.split(":");
            temp = QString::number((tp1[0].toInt() * 60) + tp1[1].toInt());
            list7 += temp; list7 += ",";
            temp = json["chpnts2"][i]["inspect"].toString();
            tp1 = temp.split(":");
            temp = QString::number((tp1[0].toInt() * 60) + tp1[1].toInt());
            list8 += temp; list8 += ",";

            listCount += json["chpnts2"][i]["inspect"].toString(); listCount += ",";
        }
        emit successSignUp(success, json["branch"].toString(), json["admin"].toString(), count, count2, list, list2, list3, list4, list5, list6, list7, list8);
    }
    else if (json["method"] == "TakeShedule"){
        adress = json["adress"].toString();
        emit recordsWeek(json.toJson(QJsonDocument::Compact));
    }
    else if (json["method"] == "getRecordsW"){
        namefile = json["fileName"].toString();
        qDebug()<<"_____________0"<<namefile;
    }
    else if (json["method"] == "getRecord"){
        QJsonObject obj1;
        obj1["files"] = json["files"];
        obj1["username"] = json["username"];
        SetDecl();
        emit recordsDecl(QJsonDocument(obj1).toJson());
    }
    else if (json["method"] == "setUserStart"){
        emit setStatUser(json.toJson(QJsonDocument::Compact));
    }
    else if (json["method"] == "setAllStat"){
        qDebug()<<"doshla stata: "<<json;
        QString count = json["countAll"].toString(), temp="", temp2="";
        for (int i=1; i<=12; i++){
            if (i!=12) temp += json["mounth" + QString::number(i)].toString() + ",";
            else temp += json["mounth" + QString::number(i)].toString();

            for (int j=1;j<=5;j++){
                if (i==12 && j==5) temp2 += json["" + QString::number(i) + QString::number(j)].toString();
                else temp2 += json["" + QString::number(i) + QString::number(j)].toString() + ",";
            }
        }
        emit sucGetAllStat(count, temp, temp2);
    }
    else if(json["method"] == "getCstmStat"){
        qDebug()<<"111111"<<json;
        emit getCstmStat1(json["dS"].toString(),json["dC"].toString(),json["wS"].toString(),json["wC"].toString(),json["mS"].toString(),json["mC"].toString(),json["yS"].toString(),json["yС"].toString());
    }
}

void NetworkConnection::SetDecl(){
    qDebug()<< + ".txt";
    QFile file(numberDecl + ".txt"); file.open(QIODevice::ReadOnly);
    QString jsonStr = file.readAll();
    QJsonDocument json = QJsonDocument::fromJson(jsonStr.toUtf8());
    file.close();
    emit setDecl1(json.toJson(QJsonDocument::Compact));
}

void NetworkConnection::setRecordReport(const QString &username, const QString &oplata, const QString &result, const QString &comment, const QString &count, const QString &hhmm){
    QJsonObject obj;
    QString temp_cm = comment;
    obj["method"] = "SetReport";
    obj["recordsid"] = numberDecl;
    obj["resultnow"] = result;
    obj["commentfinish"] = temp_cm.replace("/n", " ");
    obj["inspectiontime"] = hhmm;
    obj["countproductions"] = count;
    obj["adress"] = adress;
    obj["ServedBy"] = username;
    obj["poshlina"] = oplata;

    mTcpSocket->write(QJsonDocument(obj).toJson());
}

void NetworkConnection::getCstmStat(const QString &cstm){
    qDebug()<<cstm;
    QJsonObject obj; obj["method"] = "getCstmStat";
    obj["cstm"] = cstm;
    mTcpSocket->write(QJsonDocument(obj).toJson()); mTcpSocket->flush();
}

void NetworkConnection::getAllStat(){
    qDebug()<<"i send";
    QJsonObject obj; obj["method"] = "getAllStat";
    mTcpSocket->write(QJsonDocument(obj).toJson()); mTcpSocket->flush();
}

void NetworkConnection::getStatUser(const QString &username){
    QJsonObject obj;
    obj["method"] = "getStatUser";
    obj["username"] = username;

    mTcpSocket->write(QJsonDocument(obj).toJson());
}

void NetworkConnection::slotReadRead(){
    // Конвертим данные от сервера в Json
    buff = mTcpSocket->readAll();
    QJsonDocument json = QJsonDocument::fromJson(buff);
    fabricMethod(json);
}

void NetworkConnection::slotError(QAbstractSocket::SocketError err){
    QString strError = "Error: " + (err == QAbstractSocket::HostNotFoundError ?
                "The host not found." : err == QAbstractSocket::RemoteHostClosedError ?
                "The remote host is closed." : err == QAbstractSocket::ConnectionRefusedError ?
                "The connection was refused." : QString(mTcpSocket->errorString()));
    qDebug() << strError;
}

void NetworkConnection::slotConnected(){
    qDebug()<<"Connected";
}

void NetworkConnection::sendingSignUp(const QString &userName, const QString &password){
    QString jsonStr = "{\"method\": \"SignUp\", \"username\": \"" + userName +
            "\",\"workOrClient\": \"1\", \"password\": \"" + password + "\"}";
    mTcpSocket->write(jsonStr.toUtf8());
}

void NetworkConnection::getRecord(const QString &number){
    numberDecl = number;
    QString jsonStr = "{\"method\": \"getRecordWorker\", \"number\": \"" + number + "\"}";
    mTcpSocket->write(jsonStr.toUtf8());
}

void NetworkConnection::sendingTakeShedule(const QString &strDateFirst, const QString &username){
    QString jsonStr = "{\"method\": \"TakeShedule\", \"DateFirst\": \""+ strDateFirst + "\", \"userName\": \""+ username + "\", \"workOrClient\": \"1\"}";
    qDebug()<<"sendingTakeShedule "<<strDateFirst;
    mTcpSocket->write(jsonStr.toUtf8());
}

void NetworkConnection::sendingSetRecord(const QString &numberAuto, const QString &numberPhone, const QString &strDate){
    QString jsonStr = "{\"method\": \"SetRecord\", \"DateFirst\": \"" + strDate +
            "\", \"NumberAuto\": \"" + numberAuto + "\", \"NumberPhone\": \"" + numberPhone + "\"}";
}
