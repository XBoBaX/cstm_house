#ifndef NETWORKCONNECTION_H
#define NETWORKCONNECTION_H

#include <QObject>
#include <QDebug>
#include <QTcpSocket>
#include <QDataStream>
#include <QTime>
#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>
class NetworkConnection : public QObject {
    Q_OBJECT
public:
    explicit NetworkConnection(QObject *parent = nullptr);
    Q_INVOKABLE void sendingSignUp(const QString &userName, const QString &password);
    Q_INVOKABLE void setRecordReport(const QString &username, const QString &oplata, const QString &result, const QString &comment, const QString &count, const QString &hhmm);
    Q_INVOKABLE void sendingTakeShedule(const QString &strDateFirst, const QString &username);
    Q_INVOKABLE void sendingSetRecord(const QString &numberAuto, const QString &numberPhone, const QString &strDate);
    Q_INVOKABLE void getRecord(const QString &number);
    Q_INVOKABLE void getStatUser(const QString &username);
    Q_INVOKABLE void getAllStat();
    Q_INVOKABLE void getCstmStat(const QString &cstm);
signals:
    void successSignUp(bool success, const QString& messageNumber, const QString& admin, const QString& count1, const QString& count2, const QString& users1, const QString& list2, const QString& list3, const QString& list4, const QString& list5, const QString& list6, const QString& list7, const QString& list8);
    void sucGetAllStat(const QString &count, const QString &mounth, const QString &week);
    void recordsWeek(const QString& message);
    void recordsDecl(const QString& message);
    void setDecl1(const QString& message);
    void setStatUser(const QString& message);
    void getCstmStat1(const QString& m1,const QString& m2,const QString& m3,const QString& m4,const QString& m5,const QString& m6,const QString& m7,const QString& m8);
private slots:
    void slotReadRead();
    void slotError(QAbstractSocket::SocketError);
    void slotConnected();
private:
    QTcpSocket *mTcpSocket;
    QString m_Message;
    void fabricMethod(const QJsonDocument &json);
    void SetDecl();
    QString adress = "";
    QString namefile = "0";
    QByteArray buff;
    QString numberDecl = "0";
};

#endif // NETWORKCONNECTION_H
