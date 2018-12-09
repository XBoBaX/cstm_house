#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QDebug>
#include <QtSql>

class database : public QObject
{
Q_OBJECT
public:
    database(){};
    ~database();
    QSqlDatabase* connectDB();
};

#endif // DATABASE_H
