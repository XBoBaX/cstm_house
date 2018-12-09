import QtQuick 2.9
import QtQuick.Controls 2.2
import io.qt.examples.NetworkConnection 1.0

Rectangle{
    id: rootRec
    anchors.fill: parent; color: "white"
    Flickable{
        id: flck
        anchors.fill: parent
        contentHeight: dclView.height
        Item{
            id: dclView
            width: rootRec.width; height: childrenRect.height
            Rectangle{
                id: rec1; color: "white"; border.width: 1
                anchors.top: parent.top; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec1Txt1.height < 60) return 60
                    else rec1Txt1.height + 20
                }
                Text {
                    id: rec1Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Декларация"
                }
                Text {
                    id: rec1Txt1
                    anchors.leftMargin: 15; anchors.left: rec1Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap1
                }
            }
            Rectangle{
                id: rec2; color: "white"; border.width: 1
                anchors.top: rec1.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec2Txt1.height < 60) return 60
                    else rec2Txt1.height + 20
                }
                Text {
                    id: rec2Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Отправитель / Экспортер"
                }
                Text {
                    id: rec2Txt1
                    anchors.leftMargin: 15; anchors.left: rec2Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap2
                }
            }
            Rectangle{
                id: rec3; color: "white"; border.width: 1
                anchors.top: rec2.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec3Txt1.height < 60) return 60
                    else rec3Txt1.height + 20
                }
                Text {
                    id: rec3Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Всего мест"
                }
                Text {
                    id: rec3Txt1
                    anchors.leftMargin: 15; anchors.left: rec3Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap6
                }
            }
            Rectangle{
                id: rec4; color: "white"; border.width: 1
                anchors.top: rec3.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec4Txt1.height < 60) return 60
                    else rec4Txt1.height + 20
                }
                Text {
                    id: rec4Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Получатель"
                }
                Text {
                    id: rec4Txt1
                    anchors.leftMargin: 15; anchors.left: rec4Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap8
                }
            }
            Rectangle{
                id: rec5; color: "white"; border.width: 1
                anchors.top: rec4.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec5Txt1.height < 60) return 60
                    else rec5Txt1.height + 20
                }
                Text {
                    id: rec5Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Лицо, ответственное за финансовое урегулирование"
                }
                Text {
                    id: rec5Txt1
                    anchors.leftMargin: 15; anchors.left: rec5Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap9
                }
            }
            Rectangle{
                id: rec6; color: "white"; border.width: 1
                anchors.top: rec5.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec6Txt1.height < 60) return 60
                    else rec6Txt1.height + 20
                }
                Text {
                    id: rec6Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Страна перв. назн./послед. отправил"
                }
                Text {
                    id: rec6Txt1
                    anchors.leftMargin: 15; anchors.left: rec6Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap10
                }
            }
            Rectangle{
                id: rec7; color: "white"; border.width: 1
                anchors.top: rec6.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec7Txt1.height < 60) return 60
                    else rec7Txt1.height + 20
                }
                Text {
                    id: rec7Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Торговая страна / страна производства"
                }
                Text {
                    id: rec7Txt1
                    anchors.leftMargin: 15; anchors.left: rec7Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap11
                }
            }
            Rectangle{
                id: rec8; color: "white"; border.width: 1
                anchors.top: rec7.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec8Txt1.height < 60) return 60
                    else rec8Txt1.height + 20
                }
                Text {
                    id: rec8Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "ЕСП"
                }
                Text {
                    id: rec8Txt1
                    anchors.leftMargin: 15; anchors.left: rec8Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap13
                }
            }
            Rectangle{
                id: rec9; color: "white"; border.width: 1
                anchors.top: rec8.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec9Txt1.height < 60) return 60
                    else rec9Txt1.height + 20
                }
                Text {
                    id: rec9Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Декларант/Представитель"
                }
                Text {
                    id: rec9Txt1
                    anchors.leftMargin: 15; anchors.left: rec9Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap14
                }
            }
            Rectangle{
                id: rec10; color: "white"; border.width: 1
                anchors.top: rec9.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec10Txt1.height < 60) return 60
                    else rec10Txt1.height + 20
                }
                Text {
                    id: rec10Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Страна отправления/экспорта"
                }
                Text {
                    id: rec10Txt1
                    anchors.leftMargin: 15; anchors.left: rec10Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap15
                }
            }
            Rectangle{
                id: rec11; color: "white"; border.width: 1
                anchors.top: rec10.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec11Txt1.height < 60) return 60
                    else rec11Txt1.height + 20
                }
                Text {
                    id: rec11Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Код страны отправления/экспорта"
                }
                Text {
                    id: rec11Txt1
                    anchors.leftMargin: 15; anchors.left: rec11Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap15_1
                }
            }
            Rectangle{
                id: rec12; color: "white"; border.width: 1
                anchors.top: rec11.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec12Txt1.height < 60) return 60
                    else rec12Txt1.height + 20
                }
                Text {
                    id: rec12Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Страна происхождения"
                }
                Text {
                    id: rec12Txt1
                    anchors.leftMargin: 15; anchors.left: rec12Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap16
                }
            }
            Rectangle{
                id: rec13; color: "white"; border.width: 1
                anchors.top: rec12.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec13Txt1.height < 60) return 60
                    else rec13Txt1.height + 20
                }
                Text {
                    id: rec13Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Cтрана назначения"
                }
                Text {
                    id: rec13Txt1
                    anchors.leftMargin: 15; anchors.left: rec13Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap17
                }
            }
            Rectangle{
                id: rec14; color: "white"; border.width: 1
                anchors.top: rec13.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec14Txt1.height < 60) return 60
                    else rec14Txt1.height + 20
                }
                Text {
                    id: rec14Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Код страны назначения"
                }
                Text {
                    id: rec14Txt1
                    anchors.leftMargin: 15; anchors.left: rec14Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap17_1
                }
            }
            Rectangle{
                id: rec15; color: "white"; border.width: 1
                anchors.top: rec14.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec15Txt1.height < 60) return 60
                    else rec15Txt1.height + 20
                }
                Text {
                    id: rec15Txt; clip: true
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Идентификация и страна регистрации транспортного средства при отправлении/прибытии"
                }
                Text {
                    id: rec15Txt1
                    anchors.leftMargin: 15; anchors.left: rec15Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap18
                }
            }
            Rectangle{
                id: rec16; color: "white"; border.width: 1
                anchors.top: rec15.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec16Txt1.height < 60) return 60
                    else rec16Txt1.height + 20
                }
                Text {
                    id: rec16Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Контейнер"
                }
                Text {
                    id: rec16Txt1
                    anchors.leftMargin: 15; anchors.left: rec16Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap19
                }
            }
            Rectangle{
                id: rec17; color: "white"; border.width: 1
                anchors.top: rec16.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec17Txt1.height < 60) return 60
                    else rec17Txt1.height + 20
                }
                Text {
                    id: rec17Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Условия поставки"
                }
                Text {
                    id: rec17Txt1
                    anchors.leftMargin: 15; anchors.left: rec17Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap20
                }
            }
            Rectangle{
                id: rec18; color: "white"; border.width: 1
                anchors.top: rec17.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec18Txt1.height < 60) return 60
                    else rec18Txt1.height + 20
                }
                Text {
                    id: rec18Txt; clip: true
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Идентификация и страна регистрации активного транспортного средства на границе"
                }
                Text {
                    id: rec18Txt1
                    anchors.leftMargin: 15; anchors.left: rec18Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap21
                }
            }
            Rectangle{
                id: rec19; color: "white"; border.width: 1
                anchors.top: rec18.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec19Txt1.height < 60) return 60
                    else rec19Txt1.height + 20
                }
                Text {
                    id: rec19Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Курс валюты"
                }
                Text {
                    id: rec19Txt1
                    anchors.leftMargin: 15; anchors.left: rec19Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap23
                }
            }
            Rectangle{
                id: rec20; color: "white"; border.width: 1
                anchors.top: rec19.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec20Txt1.height < 60) return 60
                    else rec20Txt1.height + 20
                }
                Text {
                    id: rec20Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Характер сделки"
                }
                Text {
                    id: rec20Txt1
                    anchors.leftMargin: 15; anchors.left: rec20Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap24
                }
            }
            Rectangle{
                id: rec21; color: "white"; border.width: 1
                anchors.top: rec20.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec21Txt1.height < 60) return 60
                    else rec21Txt1.height + 20
                }
                Text {
                    id: rec21Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Вид транспорта на границе"
                }
                Text {
                    id: rec21Txt1
                    anchors.leftMargin: 15; anchors.left: rec21Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap25
                }
            }
            Rectangle{
                id: rec22; color: "white"; border.width: 1
                anchors.top: rec21.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec22Txt1.height < 60) return 60
                    else rec22Txt1.height + 20
                }
                Text {
                    id: rec22Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Вид транспорта внутри страны"
                }
                Text {
                    id: rec22Txt1
                    anchors.leftMargin: 15; anchors.left: rec22Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap26
                }
            }
            Rectangle{
                id: rec23; color: "white"; border.width: 1
                anchors.top: rec22.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec23Txt1.height < 60) return 60
                    else rec23Txt1.height + 20
                }
                Text {
                    id: rec23Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Место погрузки/разгрузки"
                }
                Text {
                    id: rec23Txt1
                    anchors.leftMargin: 15; anchors.left: rec23Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap27
                }
            }
            Rectangle{
                id: rec24; color: "white"; border.width: 1
                anchors.top: rec23.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec24Txt1.height < 60) return 60
                    else rec24Txt1.height + 20
                }
                Text {
                    id: rec24Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Финансовые и банковские сведения"
                }
                Text {
                    id: rec24Txt1
                    anchors.leftMargin: 15; anchors.left: rec24Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap28
                }
            }
            Rectangle{
                id: rec25; color: "white"; border.width: 1
                anchors.top: rec24.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec25Txt1.height < 60) return 60
                    else rec25Txt1.height + 20
                }
                Text {
                    id: rec25Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Таможенный орган выезда/въезда"
                }
                Text {
                    id: rec25Txt1
                    anchors.leftMargin: 15; anchors.left: rec25Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap29
                }
            }
            Rectangle{
                id: rec26; color: "white"; border.width: 1
                anchors.top: rec25.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec26Txt1.height < 60) return 60
                    else rec26Txt1.height + 20
                }
                Text {
                    id: rec26Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Местонахождение товара"
                }
                Text {
                    id: rec26Txt1
                    anchors.leftMargin: 15; anchors.left: rec26Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap30
                }
            }
            Rectangle{
                id: rec27; color: "white"; border.width: 1
                anchors.top: rec26.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec27Txt1.height < 60) return 60
                    else rec27Txt1.height + 20
                }
                Text {
                    id: rec27Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Реквизиты склада"
                }
                Text {
                    id: rec27Txt1
                    anchors.leftMargin: 15; anchors.left: rec27Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap49
                }
            }
            Rectangle{
                id: rec28; color: "white"; border.width: 1
                anchors.top: rec27.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec28Txt1.height < 60) return 60
                    else rec28Txt1.height + 20
                }
                Text {
                    id: rec28Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Принципал"
                }
                Text {
                    id: rec28Txt1
                    anchors.leftMargin: 15; anchors.left: rec28Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap50
                }
            }
            Rectangle{
                id: rec29; color: "white"; border.width: 1
                anchors.top: rec28.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec29Txt1.height < 60) return 60
                    else rec29Txt1.height + 20
                }
                Text {
                    id: rec29Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Гарантия не действительна для"
                }
                Text {
                    id: rec29Txt1
                    anchors.leftMargin: 15; anchors.left: rec29Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap52
                }
            }
            Rectangle{
                id: rec30; color: "white"; border.width: 1
                anchors.top: rec29.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec30Txt1.height < 60) return 60
                    else rec30Txt1.height + 20
                }
                Text {
                    id: rec30Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Таможенный орган (и страна) назначения"
                }
                Text {
                    id: rec30Txt1
                    anchors.leftMargin: 15; anchors.left: rec30Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap53
                }
            }
            Rectangle{
                id: rec31; color: "white"; border.width: 1
                anchors.top: rec30.bottom; anchors.left: parent.left
                width: rootRec.width; height: {
                    if (rec31Txt1.height < 60) return 60
                    else rec31Txt1.height + 20
                }
                Text {
                    id: rec31Txt
                    anchors.leftMargin: 15; anchors.left: parent.left
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: "Дата"
                }
                Text {
                    id: rec31Txt1
                    anchors.leftMargin: 15; anchors.left: rec31Txt.right
                    width: parent.width / 2; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: root.grap54
                }
            }
        }
    }
}
