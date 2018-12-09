#ifndef PRODUCTS_H
#define PRODUCTS_H

#include <QObject>
#include <QDebug>
#include <QJsonDocument>

class products : public QObject
{
    Q_OBJECT
public:
    products();
    void setParam(const QString &json);
    QString getParam(int index);
    int count = 0;
private:
    QStringList list;
};

#endif // PRODUCTS_H
