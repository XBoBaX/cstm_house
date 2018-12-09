#include "mytcpserver.h"
#include <QDebug>
#include <QCoreApplication>
#include <QNetworkInterface>
#include "profile.h"
#include "records.h"
#include "customsduty.h"
#include "efficiencycalculation.h"

MyTcpServer* MyTcpServer::p_instance = 0; //Колво объектов = 0. Выполняется в самом начале

MyTcpServer::MyTcpServer(QObject *parent) : QObject(parent)
{
    mTcpServer = new QTcpServer(this);
    connect(mTcpServer, &QTcpServer::newConnection, this, &MyTcpServer::slotNewConnection);
    if(!mTcpServer->listen(QHostAddress::Any, 6000)) qDebug() << "server is not started";
    else qDebug() << "server is started";
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
    qDebug()<<"Server ip: " << ipAddress;

}

MyTcpServer::~MyTcpServer(){
    foreach(int i,SClients.keys()){
        QTextStream os(SClients[i]);
        os.setAutoDetectUnicode(true);
        os << QDateTime::currentDateTime().toString() << "\n";
        SClients[i]->close();
        SClients.remove(i);
    }
    mTcpServer->close();
    qDebug() << QString::fromUtf8("Сервер остановлен!");
}

void MyTcpServer::slotNewConnection()
{
    qDebug()<<"\nNew Connection";
    mTcpSocket = mTcpServer->nextPendingConnection();
    int idusersocs=mTcpSocket->socketDescriptor();
    SClients[idusersocs]=mTcpSocket;
    connect(SClients[idusersocs], SIGNAL(readyRead()), this, SLOT(slotServerRead()));
    connect(SClients[idusersocs], SIGNAL(disconnected()), this, SLOT(slotClientDisconnected()));
}

void MyTcpServer::slotServerRead()
{
    int idusersocs=SClients.key((QTcpSocket*)sender());
    QByteArray q = SClients[idusersocs]->readAll();
    QJsonDocument json = QJsonDocument::fromJson(q); // Конвертим данные от клиента в Json
    fabricMethod(idusersocs, json, q);
}

void MyTcpServer::fabricMethod(int idusersocs, const QJsonDocument &json, const QByteArray& str){
    qDebug()<<endl<<json["method"];
    if (methodNow[idusersocs] == "txt") {
        methodNow[idusersocs] = "none";
        QString name = username[idusersocs] + "_decl.txt";
        QFile file(name);
        file.open(QIODevice::WriteOnly);
        file.write(str);
        file.close();
    }
    if (json.isNull()){
        QString name = "" + username[idusersocs] + "_" + nameFile[idusersocs];
        if (methodNow[idusersocs] == "pdf") name += ".pdf";
        else if (methodNow[idusersocs] == "doc") name += ".doc";
        else if (methodNow[idusersocs] == "docx") name += ".docx";
        else if (methodNow[idusersocs] == "png") name += ".png";
        else if (methodNow[idusersocs] == "jpg") name += ".jpg";
        if (name == nameprew) {buff.append(str);return;}
        else {buff = str; nameprew = name;}
        fileList[idusersocs].append(name);
        QFile file(name);
        file.open(QIODevice::WriteOnly);
        file.write(buff);
        file.close();

    }
    if (json["method"] == "fileNext"){
        methodNow[idusersocs] = json["type"].toString();
        username[idusersocs] = json["username"].toString();
        nameFile[idusersocs] = json["short"].toString();
    }
    if (json["method"] == "SignUp" || json["method"] == "SignUpWorker"){
        Profile* pr = new Profile(this);
        emit profileSignUp(idusersocs, json);
        delete pr;
    }
    else if (json["method"] == "setProfile"){
        Profile* pr = new Profile(this);
        emit profileSetProfile(idusersocs, json);
        delete pr;
    }
    else if (json["method"] == "TakeShedule"){
        records* rc = new records(this);
        emit recordsGetRecord(idusersocs, json);
        delete rc;
    }
    else if (json["method"] == "SetRecord"){
        records* rc = new records(this);
        emit recordsSetRecord(idusersocs, json);
        delete rc;
    }
    else if (json["method"] == "Register"){
        Profile* pr = new Profile(this);
        emit profileRegister(idusersocs, json);
        delete pr;
    }
    else if (json["method"] == "TakeChpnts"){
        records* rc = new records(this);
        emit recordsTakeChps(idusersocs, json);
        delete rc;
    }
    else if (json["method"] == "TakePrewRec"){
        records* rc = new records(this);
        emit recordsTakePrewRec(idusersocs, json);
        delete rc;
    }
    else if (json["method"] == "TakeGroup"){
        customsduty* grp = new customsduty(this);
        emit dutyGetGroup(idusersocs, json);
        delete grp;
    }
    else if (json["method"] == "GetDeclPrew"){
        QString path = json["number"].toString() + ".txt";
        QFile file(path); file.open(QIODevice::ReadOnly);
        qDebug()<<"Send to client file";
        QByteArray toJson = file.readAll();
        SClients[idusersocs]->write(toJson); file.close();
    }
    else if (json["method"] == "getRecordWorker"){
        records* rc = new records(this);
        emit recordsGetRecordW(idusersocs, json);
        delete rc;
    }
    else if (json["method"] == "SetReport"){
        efficiencyCalculation* rc = new efficiencyCalculation(this);
        emit setReport(idusersocs, json);
        delete rc;
    }
    else if (json["method"] == "getStatUser"){
        efficiencyCalculation* rc = new efficiencyCalculation(this);
        emit getStatUser(idusersocs, json);
        delete rc;
    }
    else if (json["method"] == "GetRecodDay") {
        records* rc = new records(this);
        emit getRecodDay(idusersocs, json);
        delete rc;
    }
    else if (json["method"] == "getAllStat") {
        efficiencyCalculation* rc = new efficiencyCalculation(this);
        emit getAllStat(idusersocs, json);
        delete rc;
    }
    else if (json["method"] == "getCstmStat"){
        efficiencyCalculation* rc = new efficiencyCalculation(this);
        emit getCstmStat(idusersocs, json);
        delete rc;
    }

}

void MyTcpServer::slotClientDisconnected()
{
    int idusersocs=SClients.key((QTcpSocket*)sender());
    SClients.remove(idusersocs);
    qDebug()<<"Connection disconnected";
}

MyTcpServer* MyTcpServer::getInstance(){
    if(!p_instance)
        p_instance = new MyTcpServer();
    return p_instance;
}

void MyTcpServer::sendToClientFile(int idusersocs, const QByteArray &message){
    SClients[idusersocs]->write(message); SClients[idusersocs]->flush();
}

void MyTcpServer::sendToClient(int idusersocs, const QJsonObject &message){
    qDebug()<<"Send to client: "<<message;
    SClients[idusersocs]->write(QJsonDocument(message).toJson()); SClients[idusersocs]->flush();
}
