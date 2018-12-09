#include "pdf.h"

PDF::PDF(){}

void PDF::createPDFfile(const QString &json, products* prd, Declaration* dcl){
    qDebug()<<"pdf:"<<json<<endl;
    QFile file("decl.txt");
    file.open(QIODevice::WriteOnly);
    QString html = "<h1>Декларация</h1>"
                   "<table border=1 width=100%>";
    file.write("{");
    file.write("\"country\": \"" + dcl->getParam("country").toUtf8() + "\",");
    file.write("\"adress\": \"" + dcl->getParam("adress").toUtf8() + "\",");
    file.write("\"arrivaltime\": \"" + dcl->getParam("arrivaltime").toUtf8() + "\",");
    for (int i = 0; i < list.count(); i++){
        html.append("<tr><td width=50%>"+list[i]+":</td>"
"<td width=50%>" + dcl->getParam("gp" + list2[i]) + "</td></tr>");
        if (prd->count == 0 && list.count()-1 == i) file.write("\"" + list[i].toUtf8() + "\" : \"" + dcl->getParam("gp" + list2[i]).toUtf8() + "\"}");
        else file.write("\"" + list[i].toUtf8() + "\" : \"" + dcl->getParam("gp" + list2[i]).toUtf8() + "\",");
    }
    html.append("</table><br>");
    qDebug()<<"pdf "<<prd->count;
    if (prd->count != 0) file.write("\"count\": \"" + QString::number(prd->count).toUtf8() + "\",");
    for (int i = 0; i < prd->count; i++){
        QString temp = prd->getParam(i);
        QJsonDocument doc = QJsonDocument::fromJson(temp.toUtf8());
        file.write("\"tovar" + QString::number(i).toUtf8() + "\": {\n");
        file.write("\"Код товара\": \"" + doc["code_tovar"].toString().toUtf8() + "\",");
        file.write("\"Описание\": \"" + doc["graph31"].toString().toUtf8() + "\",");
        file.write("\"Код страны происх.\": \"" + doc["graph34"].toString().toUtf8() + "\",");
        file.write("\"Вес брутто\": \"" + doc["graph35"].toString().toUtf8() + "\",");
        file.write("\"преферанция\": \"" + doc["graph36"].toString().toUtf8() + "\",");
        file.write("\"нетто\": \"" + doc["graph37"].toString().toUtf8() + "\",");
        file.write("\"цена\": \"" + doc["graph38"].toString().toUtf8() + "\",");
        file.write("\"Пошлина\": \"" + doc["full"].toString().toUtf8() + "\"");
        html.append("<table border=1 width=100%><tr><td>" + QString::number(i+1) + "</td></tr>");
        html.append("<tr><td width=40%>Код товара</td><td width=59%>" + doc["code_tovar"].toString() + "</td></tr>");
        html.append("<tr><td width=40%>Описание</td><td width=59%>" + doc["graph31"].toString() + "</td></tr>");
        html.append("<tr><td width=40%>Код страны происх.</td><td width=59%>" + doc["graph34"].toString() + "</td></tr>");
        html.append("<tr><td width=40%>Вес брутто</td><td width=59%>" + doc["graph35"].toString() + "</td></tr>");
        html.append("<tr><td width=40%>преферанция</td><td width=59%>" + doc["graph36"].toString() + "</td></tr>");
        html.append("<tr><td width=40%>нетто</td><td width=59%>" + doc["graph37"].toString() + "</td></tr>");
        html.append("<tr><td width=40%></td>цена<td width=59%>" + doc["graph38"].toString() + "</td></tr>");
        html.append("<tr><td width=40%>Пошлина</td><td width=59%>" + doc["full"].toString() + "%</td></tr></table><br>");
        if (i == (prd->count)-1) file.write("}}");
        else file.write("},");
        qDebug()<<i;
    }
    file.close();

    QTextDocument document;
    document.setHtml(html);

    QPrinter printer(QPrinter::PrinterResolution);
    printer.setOutputFormat(QPrinter::PdfFormat);
    printer.setOutputFileName("decl.pdf");
    document.print(&printer);
    qDebug()<<"finish";
}

QString PDF::readPDFfile(const QString& path){
    QFile file(path);
    qDebug()<<path;
    file.open(QIODevice::ReadOnly);
    QString jsonStr = file.readAll();
    qDebug()<<jsonStr;
    QJsonDocument json = QJsonDocument::fromJson(jsonStr.toUtf8());
    file.close();
    return json.toJson(QJsonDocument::Compact);
}
