#ifndef MYTCPSERVER_H
#define MYTCPSERVER_H

#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>
#include <QDateTime>
#include <QRegExp>
class MyTcpServer : public QObject
{
    Q_OBJECT
public:
    static MyTcpServer * getInstance();
    ~MyTcpServer();
    void sendToClient(int idusersocs, const QJsonObject& message);
    void sendToClientFile(int idusersocs, const QByteArray& message);
    QMap<int,QString> username;
    QMap<int,QStringList> fileList;
public slots:
    void slotNewConnection();
    void slotServerRead();
    void slotClientDisconnected();
signals:
    void getAllStat(int idusersocs, const QJsonDocument& json);
    void getRecodDay(int idusersocs, const QJsonDocument& json);
    void profileSignUp(int idusersocs, const QJsonDocument& json);
    void profileSetProfile(int idusersocs, const QJsonDocument& json);
    void profileRegister(int idusersocs, const QJsonDocument& json);
    void recordsGetRecord(int idusersocs, const QJsonDocument& json);
    void recordsGetRecordW(int idusersocs, const QJsonDocument& json);
    void recordsSetRecord(int idusersocs, const QJsonDocument& json);
    void recordsTakeChps(int idusersocs, const QJsonDocument& json);
    void recordsTakePrewRec(int idusersocs, const QJsonDocument& json);
    void dutyGetGroup(int idusersocs, const QJsonDocument& json);
    void setRecord(int idusersocs, const QJsonDocument& json);
    void setReport(int idusersocs, const QJsonDocument& json);
    void getStatUser(int idusersocs, const QJsonDocument& json);
    void getCstmStat(int idusersocs, const QJsonDocument& json);
private:
    static MyTcpServer * p_instance; //Кол-во объектов класса
    // Конструкторы и оператор присваивания недоступны клиентам
    explicit MyTcpServer(QObject *parent = 0);
    MyTcpServer(const MyTcpServer&);
    MyTcpServer& operator=(MyTcpServer&);

    QMap<int,QTcpSocket *> SClients; //Объекты созданных объектов
    QMap<int,QString> methodNow;
    QMap<int,QString> nameFile;
    QTcpServer * mTcpServer;
    QTcpSocket * mTcpSocket;
    QByteArray buff;
    QString nameprew;
    void fabricMethod(int idusersocs, const QJsonDocument& json, const QByteArray& str);
};

#endif // MYTCPSERVER_H
