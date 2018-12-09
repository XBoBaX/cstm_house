#ifndef DECLARATION_H
#define DECLARATION_H

#include <QObject>
#include <QDebug>
#include <QJsonDocument>

class Declaration : public QObject
{
    Q_OBJECT
public:
    Declaration();
    void setParam(const QString &json);
    void setParamGp(const QString &gp, const QString &setArg);
    void setFile(const QString &json);
    QString getParam(const QString &gp);
    QStringList getFile();

private:
    QStringList list;
    QJsonDocument graph;
};

#endif // DECLARATION_H
