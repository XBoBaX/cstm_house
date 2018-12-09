#include "products.h"

products::products(){}

void products::setParam(const QString &js){
    QString json = js;
    json = json.replace("},{", "}__{");
    list = json.split("__");
    count = list.length();
    qDebug()<<"products count "<<count;
    if (js.length() < 3) count = 0;
    qDebug()<<"products list: "<<list;
}

QString products::getParam(int index){
    return list[index];
}
