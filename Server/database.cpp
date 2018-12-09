#include "database.h"


database::~database(){
    QSqlDatabase::removeDatabase("qt_sql_default_connection");
}

QSqlDatabase* database::connectDB(){
    QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL");

    db.setDatabaseName("customs_house");
    db.setUserName("postgres");
    db.setHostName("localhost");
    db.setPassword("1");

    if (!db.open()) qDebug()<<"Unable to open database: " << db.lastError();

    return &db;
}
