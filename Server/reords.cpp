#include "records.h"

records::records(MyTcpServer* parent) : QObject()
{
    getBd = new database();
    getBd->connectDB();
    server = parent;
    connect(parent, SIGNAL(recordsGetRecordW(int, const QJsonDocument&)), this, SLOT(getRecordsW(int, const QJsonDocument&)));
    connect(parent, SIGNAL(getRecodDay(int, const QJsonDocument&)), this, SLOT(getRecodDay(int, const QJsonDocument&)));
    connect(parent, SIGNAL(recordsGetRecord(int, const QJsonDocument&)), this, SLOT(getRecords(int, const QJsonDocument&)));
    connect(parent, SIGNAL(recordsSetRecord(int, const QJsonDocument&)), this, SLOT(setRecords(int, const QJsonDocument&)));
    connect(parent, SIGNAL(recordsTakeChps(int, const QJsonDocument&)), this, SLOT(takeChps(int, const QJsonDocument&)));
    connect(parent, SIGNAL(recordsTakePrewRec(int, const QJsonDocument&)), this, SLOT(takePrewRec(int, const QJsonDocument&)));
}

records::~records(){
    delete getBd;
}

void records::getRecodDay(int idusersocs, const QJsonDocument &json){
    qDebug()<<json["date"];
    QString date = json["date"].toString();
    QString username = json["username"].toString();
    QString dateF = date + " 00:00"; QString dateS = date + " 23:59";
    QSqlQuery query;
    query.prepare("SELECT records.adress, country, arrivaltime, resultnow, commentfinish, poshlina from records INNER JOIN record_report on records.id = record_report.recordsid WHERE arrivaltime > :dataF AND arrivaltime < :dataS AND username = :username");
    query.bindValue(":dataF", dateF); query.bindValue(":dataS", dateS); query.bindValue(":username", username);
    if(!query.exec()) qDebug()<<"Unable to SELECT "<<query.lastError();
    QJsonObject obj;
    obj["method"] = "getRecodDay";
    QJsonArray records;
    int j=0;
    while(query.next()){ // Заполняем в JSON записи
        QJsonObject record;
        record["adress"] = query.value("adress").toString();
        record["country"] = query.value("country").toString();
        record["arrivaltime"] = query.value("arrivaltime").toString();
        record["resultnow"] = query.value("resultnow").toString();
        record["commentfinish"] = query.value("commentfinish").toString();
        record["poshlina"] = query.value("poshlina").toString();
        records.append(record); j++;
    }
    obj["records"] = records;
    obj["count"] = j;
    server->sendToClient(idusersocs, obj);
}

void records::SetRecordReport(int idusersocs, const QJsonDocument &json){

}

void records::takePrewRec(int idusersocs, const QJsonDocument &json){
    QString username = json["username"].toString();
    qDebug()<<username;
    QSqlQuery query;
    query.prepare("SELECT * FROM records WHERE username = :username");
    query.bindValue(":username", username);
    if(!query.exec()) qDebug()<<"Unable to SELECT";

    QJsonObject obj;
    obj["method"] = "takeRecords";
    QJsonArray chpnts;
    while(query.next()){ // Заполняем в JSON записи
        QJsonObject record;
        record["id"] = query.value(0).toInt(); //id
        record["autonumber"] = query.value(1).toString(); //nomer mashini
        record["phonenumber"] = query.value(2).toString(); //noomer telephona
        record["date"] = query.value(3).toString(); //data
        chpnts.append(record);
    }
    obj["chpnts"] = chpnts;
    server->sendToClient(idusersocs, obj);
}

void records::takeChps(int idusersocs, const QJsonDocument &json){
    QString country = json["country"].toString();
    QSqlQuery query;
    query.prepare("SELECT * FROM cstm_house WHERE country = :country");
    query.bindValue(":country", country);
    if(!query.exec()) qDebug()<<"Unable to SELECT";

    QJsonObject obj;
    obj["method"] = "TakeChpnts";
    QJsonArray chpnts;

    while(query.next()){ // Заполняем в JSON записи
        QJsonObject record;
        record["id"] = query.value(0).toInt();
        record["name"] = query.value(1).toString();
        record["adress"] = query.value(2).toString();
        record["entry_or_departure"] = query.value(3).toInt();
        record["waiting_time"] = query.value(4).toString();
        chpnts.append(record);
    }
    obj["chpnts"] = chpnts;
    server->sendToClient(idusersocs, obj);
}

int records::waitTimeCalc(QDateTime &time_need, QSqlQuery &query, int timeInRoad){
    bool first = true;
    QDateTime d1;
    QDateTime resWait;
    int result_wait = 0;
    while(query.next()){
        QString date = query.value(0).toString();
        QDateTime d2 = QDateTime::fromString(date, "yyyy-MM-ddThh:mm:ss.000");
        QString wait_sr = query.value(1).toString(); QStringList ww = wait_sr.split(":");
        int min = (ww[0].toInt() * 60) + ww[1].toInt(); //ср время ожидания
        resWait = d2.addSecs(min * 60);
        if (first){
            d1 = d2;
            QDateTime temp = time_need.addSecs((min * 60) + timeInRoad);
            if (temp < d1){ //Если сейчас меньше чем надо
                resWait = temp;
                break;
            }
            first = false;
        }
        else {
            QDateTime temp = d1.addSecs(((min * 60) * 2) + timeInRoad); //время прохождение, если сразу после прошлой машины зайдет на проверку наша.
            if (temp < d2){
                resWait = d1.addSecs((min * 60) + timeInRoad); //Время прибытия на таможню
                break;
            }
            d1 = d2;
        }
    }
    result_wait = time_need.secsTo(resWait);
    QTime time_wait = QTime(0,0).addSecs(result_wait);
    qDebug()<<result_wait;
    qDebug()<<time_wait.toString("hh:mm:ss");

    return result_wait;
}

void records::SetRc(int idusersocs, QString country, QString adress, QDateTime time_need){
    QStringList fileTemp = server->fileList[idusersocs];
    QString file = "{";
    if (fileTemp.length() == 0) file += "}";
    for (int i=0; i<fileTemp.length();i++){
        if (i == fileTemp.length()-1) file += "\"" + fileTemp[i] + "\"}";
        else file += "\"" + fileTemp[i] + "\",";
    }
    qDebug()<<"SET: "<<time_need;
    QString arrivaltime = time_need.toString("yyyy-MM-dd hh:mm:ss");
    qDebug()<<arrivaltime;

    QSqlQuery query;
    query.prepare("INSERT INTO records (autonumber, arrivaltime, username, country, adress, file_names) "
                  "VALUES((SELECT max(id) from records)+1, :arrivaltime, :username, :country, :adress, :file_names)");
    query.bindValue(":arrivaltime", arrivaltime);
    query.bindValue(":username", server->username[idusersocs]);
    query.bindValue(":arrivaltime", arrivaltime);
    query.bindValue(":country", country);
    query.bindValue(":adress", adress);
    query.bindValue(":file_names", file);
    if(!query.exec()) {qDebug()<<"Unable to Input "<<query.lastError(); return;}
    query.prepare("SELECT autonumber FROM records WHERE adress = :adress and arrivaltime = :arrivaltime");
    query.bindValue(":arrivaltime", arrivaltime);
    query.bindValue(":adress", adress);
    if(!query.exec()) qDebug()<<"Unable to SELECT";
    query.next();
    int number = query.value(0).toInt();
    QString name = "" + server->username[idusersocs] + "_decl.txt";
    QFile fileDecl(name); fileDecl.open(QIODevice::ReadOnly);
    QFile fileDeclSet(QString::number(number) + ".txt"); fileDeclSet.open(QIODevice::WriteOnly);
    fileDeclSet.write(fileDecl.readAll()); fileDecl.close(); fileDeclSet.close();
    query.prepare("INSERT INTO record_report (recordsid, resultnow) VALUES ((SELECT max(id) from records), :wait)");
    query.bindValue(":wait", "wait");
    if(!query.exec()) qDebug()<<"Unable to Input "<<query.lastError();

    QJsonObject obj;
    obj["method"] = "SetRecord";
    obj["adress"] = adress;
    obj["arrivaltime"] = arrivaltime;
    server->sendToClient(idusersocs, obj);
}

void records::setRecords(int idusersocs, const QJsonDocument &json){
    QString name = "" + server->username[idusersocs] + "_decl.txt";
    QFile file(name); file.open(QIODevice::ReadOnly); QString fileStr = file.readAll();
    QJsonDocument json1 = QJsonDocument::fromJson(fileStr.toUtf8());
    QString country = json1["country"].toString();
    QString adress = json1["adress"].toString();
    QString arrivaltime = json1["arrivaltime"].toString();
    file.close();
    QDateTime time_need = QDateTime::fromString(arrivaltime, "yyyy-M-d hh:mm:ss");
    QSqlQuery query;
    qDebug()<<adress<<" "<<arrivaltime;
    query.prepare("SELECT distinct records.arrivaltime, cstm_house.waiting_time FROM records "
                  "inner join cstm_house on records.adress = cstm_house.adress  "
                  "WHERE records.adress = :adress and records.arrivaltime >= :time");
    query.bindValue(":adress", adress);
    query.bindValue(":time", arrivaltime);
    if(!query.exec()) qDebug()<<"Unable to SELECT";
    int result_wait = waitTimeCalc(time_need, query, 0);
    query.prepare("select adress_to, time_in_road from point_to_point where country = :country AND time_in_road <= :hour AND adress_of = :adress");
    query.bindValue(":country", country);
    query.bindValue(":hour", int(result_wait/3600));
    query.bindValue(":adress", adress);
    if(!query.exec()) qDebug()<<"Unable to SELECT";
    if(query.size() == 0) {
        qDebug()<<"Nado stavit na tot she pynkt " << time_need;
        QDateTime time_wait = time_need;
        if (result_wait != 0) time_wait = time_need.addSecs(result_wait);
        qDebug()<<time_wait;
        SetRc(idusersocs, country, adress, time_wait);
        return;
    }
    int mas_res[query.size()+1]; int i = 1, minInd = 0, min = result_wait;
    QString mas_add[query.size()+1];
    QString timeSet;
    mas_add[0] = adress; mas_res[0] = result_wait;
    while (query.next()){
        QString adress_to = query.value(0).toString();
        int time_in_road = query.value(1).toInt();
        QSqlQuery query2;
        query2.prepare("SELECT distinct records.arrivaltime, cstm_house.waiting_time FROM records "
                      "inner join cstm_house on records.adress = cstm_house.adress  "
                      "WHERE records.adress = :adress and records.arrivaltime >= :time");
        query2.bindValue(":adress", adress_to);
        query2.bindValue(":time", arrivaltime);
        if(!query2.exec()) qDebug()<<"Unable to SELECT";
        if(query2.size() == 0) result_wait = (time_in_road * 3600);
        else result_wait = waitTimeCalc(time_need, query2, (time_in_road * 3600));
        qDebug()<<"_________________-"<<adress_to<<" "<<result_wait;
        mas_res[i] = result_wait; mas_add[i++] = adress_to;
    }
    for(int j=0;j<i;j++)
    {
        if (mas_res[j] < min) {
            min = mas_res[j]; minInd = j;
        }
    }
    QDateTime time_wait = time_need.addSecs(mas_res[minInd]);
    qDebug()<<"menshe vremeni potratite v: "<<mas_res[minInd]<<" "<<mas_add[minInd]<<". Pribit v: "<<time_wait.toString("hh:mm:ss");
    SetRc(idusersocs, country, mas_add[minInd], time_wait);
}

void records::getRecordsW(int idusersocs, const QJsonDocument &json){
    QString number = json["number"].toString();
    QSqlQuery query;
    query.prepare("SELECT * FROM records WHERE autonumber=:autonumber");
    query.bindValue(":autonumber", number);
    if(!query.exec()) qDebug()<<"Unable to SELECT "<<query.lastError();
    query.next();
    QString username = query.value("username").toString();
    QString files = query.value("file_names").toString();
    files = files.remove(files.length()-1,files.length());
    files = files.remove(0,1);
    qDebug()<<"fffffffffffffffffffffffffffffffffffff:"<<files;
    if (files != ""){
        QStringList filesList = files.split(",");
        for (int i=0; i<filesList.length(); i++){
            qDebug()<<filesList[i];
            QJsonObject obj; obj["method"] = "getRecordsW"; obj["fileName"] = filesList[i];
            server->sendToClient(idusersocs, obj);
            QFile file(filesList[i]); file.open(QIODevice::ReadOnly);
            server->sendToClientFile(idusersocs, file.readAll());
        }
    }
    QJsonObject obj; obj["method"] = "getRecordsW"; obj["fileName"] = number+".txt";
    server->sendToClient(idusersocs, obj);
    QFile file(number+".txt"); file.open(QIODevice::ReadOnly);
    server->sendToClientFile(idusersocs, file.readAll());
    QJsonObject obj2;
    obj2["method"] = "getRecord";
    obj2["files"] = files;
    obj2["username"] = username;
    server->sendToClient(idusersocs, obj2);

}

void records::getRecords(int idusersocs, const QJsonDocument &json){
    QString date = json["DateFirst"].toString();
    QString username = json["userName"].toString();
    QString workOrClient = json["workOrClient"].toString();
    QString us1 = username.remove(username.indexOf('('), username.length()-1);
    qDebug()<<us1;
    QStringList dateList = date.split(' ');
    QDate dateFirst(dateList[2].toInt(), dateList[1].toInt(), dateList[0].toInt());
    QDate dateLast = dateFirst.addDays(7);

    QSqlQuery query;
    if (workOrClient == "1") {
        query.prepare("SELECT * FROM records WHERE adress=(SELECT adress FROM cstm_house WHERE id = :username) AND arrivaltime >= :dateFirst AND arrivaltime <= :dateLast ORDER BY arrivaltime");
        query.bindValue(":username", us1);
        query.bindValue(":dateFirst", dateFirst);
        query.bindValue(":dateLast", dateLast);
    }
    else {
        query.prepare("SELECT * FROM records WHERE username = :username AND arrivaltime >= :dateFirst AND arrivaltime <= :dateLast ORDER BY arrivaltime");
        query.bindValue(":username", json["userName"].toString());
        query.bindValue(":dateFirst", dateFirst);
        query.bindValue(":dateLast", dateLast);
    }

    if(!query.exec()) qDebug()<<"Unable to SELECT "<<query.lastError();

    QJsonObject obj;
    obj["method"] = "TakeShedule";
    QJsonArray records;

    while(query.next()){ // Заполняем в JSON записи
        QJsonObject record;
        record["id"] = query.value(0).toInt();
        record["nomer"] = query.value(1).toString();
        record["time"] = query.value(3).toString();
        records.append(record);
    }
    obj["records"] = records;
    if (workOrClient == "1"){
        query.prepare("SELECT adress FROM cstm_house WHERE id = :username");
        query.bindValue(":username", us1);
        if(!query.exec()) qDebug()<<"Unable to SELECT "<<query.lastError();
        query.next();
        obj["adress"] = query.value(0).toString();
    }
    server->sendToClient(idusersocs, obj);
}
