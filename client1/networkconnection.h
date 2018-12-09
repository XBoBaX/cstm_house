#ifndef NETWORKCONNECTION_H
#define NETWORKCONNECTION_H

#include <QObject>
#include <QDebug>
#include <QTcpSocket>
#include <QDataStream>
#include <QTime>
#include <QJsonDocument>
#include <QNetworkInterface>
#include "pdf.h"
#include <windows.h>
#include "declaration.h"
#include "products.h"
class NetworkConnection : public QObject {
    Q_OBJECT
public:
    QString numberPrew;
    explicit NetworkConnection(QObject *parent = nullptr);
    Q_INVOKABLE void sendingSignUp(const QString &userName, const QString &password);
    Q_INVOKABLE void sendingRegister(const QString &userName, const QString &password);
    Q_INVOKABLE void sendingTakeShedule(const QString &strDateFirst, const QString &userName);
    Q_INVOKABLE void sendingTakeChpnts(const QString &strCountry);
    Q_INVOKABLE void sendingTakePrewRec(const QString &username);
    Q_INVOKABLE void sendingSetRecord(const QString &numberAuto, const QString &numberPhone, const QString &strDate);
    Q_INVOKABLE void sendingTakeGroup(int index);
    Q_INVOKABLE void sendingRegisterRecord(const QString &json);
    Q_INVOKABLE void createPDF(const QString &json);
    Q_INVOKABLE void setDeclr(const QString &json);
    Q_INVOKABLE void setFiles(const QString &json);
    Q_INVOKABLE void setProd(const QString &json);
    Q_INVOKABLE void getDeclr(const QString &gp);
    Q_INVOKABLE void readDeclTemplate(const QString &path);
    Q_INVOKABLE void getPrewDecl(const QString &number);
    Q_INVOKABLE void getCount();
    Q_INVOKABLE void sendGetRecodDay(const QString& date);
    Q_INVOKABLE void setProfile(const QString &userFlag, const QString &mail, const QString &phone, const QString &count);
signals:
    void fillItem(const QString& message);
    void successSignUp(bool success, const QString& username, const QString& userflag, const QString& mail, const QString& phone, const QString& count);
    void recordsWeek(const QString& message);
    void takeChpnts(const QString& message);
    void takeRecords(const QString& message);
    void takeGroup(const QString& message);
    void setRecord(const QString& message);
    void registerAnswer(const QString& message, const QString& username);
    void fileRead(const QString& message);
    void declSet(const QString& message);
    void setRecordDay(const QString& count, const QString& adress, const QString& country, const QString& arrivaltime, const QString& resultnow, const QString& commentfinish, const QString& poshlina);
    void setCount(int count_wait, int count_success, int count_fatal);
private slots:
    void slotReadRead();
    void slotError(QAbstractSocket::SocketError);
    void slotConnected();
private:
    int count_wait = 0, count_success = 0, count_fatal = 0;
    QTcpSocket *mTcpSocket;
    QString m_Message;
    Declaration *decl;
    products *prod;
    void fabricMethod(const QJsonDocument &json);
    QString username;
    QByteArray buff;
    bool flag = false;

};

#endif // NETWORKCONNECTION_H
