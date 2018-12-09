#include "networkconnection.h"

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
    decl = new Declaration(); prod = new products();
    connect(mTcpSocket, SIGNAL(connected()), SLOT(slotConnected()));
    connect(mTcpSocket, SIGNAL(readyRead()), SLOT(slotReadRead()));
    connect(mTcpSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(slotError(QAbstractSocket::SocketError)));
}

void NetworkConnection::getCount(){
    qDebug()<<count_wait<<" "<<count_success<<" "<<count_fatal;
    emit setCount(count_wait, count_success, count_fatal);
}

void NetworkConnection::fabricMethod(const QJsonDocument &json){
    qDebug()<<json["method"];
    if (flag){
        flag = false;
        QString path = numberPrew + ".txt";
        QFile file(path); file.open(QIODevice::WriteOnly);
        file.write(buff);
        file.close();
        PDF* pd = new PDF();
        emit declSet(pd->readPDFfile(path));
        delete pd;
    }
    if (json["method"] == "SignUp"){
        bool success = json["answer"] == "good" ? true : false;
        username = json["user"].toString();
        if (success){
            QString temp = json["count_wait"].toString();
            count_wait = temp.toInt();
            qDebug()<<temp.toInt();
            temp = json["count_fatal"].toString(); count_fatal = temp.toInt();
            temp = json["count_success"].toString(); count_success = temp.toInt();
        }
        qDebug()<<"1) "<<json["userflag"].toString()<<" "<<json["mail"].toString()<<" "<<json["phone"].toString()<<" "<<json["count"].toString();
        emit successSignUp(success, json["user"].toString(), json["userflag"].toString(), json["mail"].toString(), json["phone"].toString(), json["count"].toString());
    }
    else if (json["method"] == "TakeShedule"){
        emit recordsWeek(json.toJson(QJsonDocument::Compact));
    }
    else if (json["method"] == "Register"){
        qDebug()<<json["answer"];
        if (json["answer"] != "good") emit registerAnswer(json["answer"].toString(), json["username"].toString());
    }
    else if (json["method"] == "TakeChpnts"){
        emit takeChpnts(json.toJson(QJsonDocument::Compact));
    }
    else if (json["method"] == "takeRecords"){
        emit takeRecords(json.toJson(QJsonDocument::Compact));
    }
    else if (json["method"] == "getGroup"){
        emit takeGroup(json.toJson(QJsonDocument::Compact));
    }
    else if (json["method"] == "SetRecord"){
        emit setRecord(json.toJson(QJsonDocument::Compact));
    }
    else if (json["method"] == "getRecodDay"){
        QString list1 = "", list2 = "", list3 = "", list4 = "", list5 = "", list6 = "";
        int count = json["count"].toInt();
        for (int i=0;i<count;i++){
            list1 += json["records"][i]["adress"].toString(); list1 += ",";
            list2 += json["records"][i]["country"].toString(); list2 += ",";
            list3 += json["records"][i]["arrivaltime"].toString(); list3 += ",";
            list4 += json["records"][i]["resultnow"].toString(); list4 += ",";
            list5 += json["records"][i]["commentfinish"].toString(); list5 += ",";
            list6 += json["records"][i]["poshlina"].toString(); list6 += ",";
        }
        emit setRecordDay(QString::number(count), list1, list2, list3, list4, list5, list6);
    }
}
void NetworkConnection::sendGetRecodDay(const QString &date){
    qDebug()<<date;
    QString jsonStr = "{\"method\": \"GetRecodDay\", \"username\": \"" + username + "\", \"date\": \"" + date + "\"}";
    mTcpSocket->write(jsonStr.toUtf8());
}

void NetworkConnection::setProfile(const QString &userFlag, const QString &mail, const QString &phone, const QString &count){
    QString jsonStr = "{\"method\": \"setProfile\", \"username\": \"" + username + "\", \"userFlag\": \"" + userFlag + "\", \"mail\": \"" + mail+ "\", \"phone\": \"" + phone+ "\", \"count\": \"" + count+ "\"}";
    mTcpSocket->write(jsonStr.toUtf8());
}
void NetworkConnection::setDeclr(const QString &json){
    decl->setParam(json);
}

void NetworkConnection::getDeclr(const QString &gp){
    qDebug()<<decl->getParam(gp);
}

void NetworkConnection::setFiles(const QString &json){
    decl->setFile(json);
}

void NetworkConnection::setProd(const QString &json){
    prod->setParam(json);
    createPDF(json);
}

void NetworkConnection::createPDF(const QString &json){
    PDF* pd = new PDF();
    pd->createPDFfile(json, prod, decl);
    delete pd;
}

void NetworkConnection::readDeclTemplate(const QString &path){
    PDF* pd = new PDF();
    emit fileRead(pd->readPDFfile(path));
    delete pd;
}

void NetworkConnection::getPrewDecl(const QString &number){
    numberPrew = number;
    qDebug()<<number;
    flag = true;
    QString jsonStr = "{\"method\": \"GetDeclPrew\", \"number\": \"" + number + "\"}";
    mTcpSocket->write(jsonStr.toUtf8());
}

void NetworkConnection::slotReadRead(){ // Конвертим данные от сервера в Json
    QByteArray q = mTcpSocket->readAll();
    buff = q;
    qDebug()<<"get server: ";
    QJsonDocument json = QJsonDocument::fromJson(q);
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
            "\",\"workOrClient\": \"0\", \"password\": \"" + password + "\"}";
    mTcpSocket->write(jsonStr.toUtf8());
}

void NetworkConnection::sendingRegister(const QString &userName, const QString &password){
    QString jsonStr = "{\"method\": \"Register\", \"username\": \"" + userName +
            "\", \"password\": \"" + password + "\"}";
    mTcpSocket->write(jsonStr.toUtf8());
}

void NetworkConnection::sendingTakeShedule(const QString &strDateFirst, const QString &userName){
    QString jsonStr = "{\"method\": \"TakeShedule\", \"DateFirst\": \""+ strDateFirst + "\", \"userName\": \""+ userName + "\"}";
    mTcpSocket->write(jsonStr.toUtf8());
}

void NetworkConnection::sendingTakePrewRec(const QString &username){
    QString jsonStr = "{\"method\": \"TakePrewRec\", \"username\": \""+ username + "\"}";
    mTcpSocket->write(jsonStr.toUtf8());
}

void NetworkConnection::sendingTakeGroup(int index){
    QString jsonStr = "{\"method\": \"TakeGroup\", \"index\": \""+ QString::number(index) + "\"}";
    mTcpSocket->write(jsonStr.toUtf8());
}

void NetworkConnection::sendingSetRecord(const QString &numberAuto, const QString &numberPhone, const QString &strDate){
    QString jsonStr = "{\"method\": \"SetRecord\", \"DateFirst\": \"" + strDate +
            "\", \"NumberAuto\": \"" + numberAuto + "\", \"NumberPhone\": \"" + numberPhone + "\"}";
    mTcpSocket->write(jsonStr.toUtf8());
}

void NetworkConnection::sendingTakeChpnts(const QString &strCountry){
    QString jsonStr = "{\"method\": \"TakeChpnts\", \"country\": \""+ strCountry + "\"}";
    mTcpSocket->write(jsonStr.toUtf8());
}

void NetworkConnection::sendingRegisterRecord(const QString &json){
    QStringList listFile = decl->getFile();
    int n = listFile.count();
    qDebug()<<"colvo file: "<<n<<". files: "<<listFile;
    for (int i=0;i<n; i++){
        QString name = listFile[i];
        QString type = "";
        if (name[name.indexOf(".") + 1] == "p" && name[name.indexOf(".") + 2] == "d"){
            type = "pdf";
        }
        else if (name[name.indexOf(".") + 1] == "j"){
            type = "jpg";
        }
        else if (name[name.indexOf(".") + 1] == "p"){
            type = "png";
        }
        else if (name[name.indexOf(".") + 1] == "d"){
            type = name[name.indexOf(".") + 4] == "x" ? "docx" : "doc";
        }
        QString nameShort;
        for (int j=name.lastIndexOf("/") + 1; j<=name.indexOf(".")-1; j++){
            nameShort += name[j];
        }
        name = name.remove(0,8);
        QString jsonStr = "{\"method\": \"fileNext\", \"type\": \"" + type + "\", \"username\": \"" + username + "\", \"short\": \"" + nameShort + "\"}";
        mTcpSocket->write(jsonStr.toUtf8()); mTcpSocket->flush();
        QFile file(name);
        qDebug()<<"open file: "<<name;
        file.open(QIODevice::ReadOnly);
        qDebug()<<"file opened";
        QByteArray toJson = file.readAll();
        file.close();
        qDebug()<<"sending";
        mTcpSocket->write(toJson); mTcpSocket->flush();
        Sleep(1000);
    }
    QString jsonStr = "{\"method\": \"fileNext\", \"type\": \"txt\", \"username\": \"" + username + "\", \"short\": \"decl\"}";
    mTcpSocket->write(jsonStr.toUtf8()); mTcpSocket->flush();
    Sleep(300);
    QFile file("decl.txt"); file.open(QIODevice::ReadOnly);
    mTcpSocket->write(file.readAll()); mTcpSocket->flush();
    file.close();
    jsonStr = "{\"method\": \"SetRecord\"}";
    Sleep(500);
    mTcpSocket->write(jsonStr.toUtf8()); mTcpSocket->flush();
}
