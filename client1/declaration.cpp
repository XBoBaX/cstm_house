#include "declaration.h"
#include <QDebug>
Declaration::Declaration()
{
}

void Declaration::setParamGp(const QString &gp, const QString &setArg){
    QString json = "\"" + gp + "\": " + "\"" + setArg + "\"";
    QJsonDocument doc = QJsonDocument::fromJson(json.toUtf8());
    graph = doc;

}

void Declaration::setParam(const QString &json){
    qDebug()<<graph;
    graph = QJsonDocument::fromJson(json.toUtf8());
}

void Declaration::setFile(const QString &json){
    qDebug()<<"list: "<<json;
    list = json.split(",");
}

QString Declaration::getParam(const QString &gp){
    return graph[gp].toString();
}

QStringList Declaration::getFile(){
    return list;
}
