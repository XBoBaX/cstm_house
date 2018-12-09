import QtQuick 2.9
import QtQuick.Controls 2.2
import "QChart.js" as Charts

Rectangle{
    property int count_wait
    property int count_success
    property int count_fatal
    property bool btnVisible: false
    property bool flag1: root.usrFlag
    property string mail: root.mail
    property string phone: root.phone
    property string count: root.count
    anchors.fill: parent;
    id: rootPr
    Rectangle{
        id: rec1
        anchors.left: parent.left; width: parent.width / 2; height: (parent.height / 2) + (parent.height / 8) - 220
        anchors.verticalCenter: parent.verticalCenter;
        QChart {
            id: chart_pie;
            anchors.fill: parent
            chartAnimated: true;
            chartAnimationEasing: Easing.Linear;
            chartAnimationDuration: 1000;
            chartType: Charts.ChartType.PIE;
            chartOptions: {"segmentStrokeColor": "#ECECEC"};
            chartData: [
                {value: count_wait, color: "#6AA84F"},
                {value: count_success, color: "#DC3912"},
                {value: count_fatal, color: "#FF9900"}];
        }

        Column {
            id: legend
            anchors.top: chart_pie.bottom; height: 60;
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width / 2;
            Row {
                spacing: 5
                Text {
                    text: "█"; font.pixelSize: 32
                    color:"#6AA84F"
                }
                Text {
                    id: txt; font.pixelSize: 32
                    text: "Машины в ожидании: " + count_wait
                }
            }
            Row {
                spacing: 5
                Text {
                    text: "█"; font.pixelSize: 32
                    color:"#DC3912"
                }
                Text {
                    id: txt2; font.pixelSize: 32
                    text: "Прошедшие ПП: " + count_success
                }
            }
            Row {
                spacing: 5
                Text {
                    text: "█"; font.pixelSize: 32
                    color:"#FF9900"
                }
                Text {
                    id: txt3; font.pixelSize: 32
                    text: "Отмененные: " + count_fatal
                }
            }
        }
    }

    Rectangle{
        id: rec2
        anchors.left: rec1.right; width: (parent.width / 2) - 100; height: (parent.height / 2) + (parent.height / 4) - 220
        anchors.verticalCenter: parent.verticalCenter;
        Text{
            id: usblck
            anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter
            text: "пользователь: " + root.userName
            font.pixelSize: 48; height: 120;
        }
        Rectangle{
            anchors.top: usblck.bottom; anchors.left: parent.left; anchors.right: parent.right;
            height: 1; color: "#eae6e9"
        }
        Text{
            anchors.top: usblck.bottom; anchors.topMargin: 20; anchors.left: parent.left; width: parent.width / 3
            text: "Тип пользователя"; id: txt1; font.pixelSize: 32; clip: true; height: 60;
        }
        Text{
            MouseArea{
                anchors.fill: parent;
                onClicked: flag1 == false ? flag1 = true : flag1 = false;
            }
            anchors.top: usblck.bottom; anchors.topMargin: 20; anchors.left: txt1.right; width: parent.width / 3 + parent.width / 2
            height: 60;
            text: flag1 ? "частное лицо" : "юридическое лицо"; font.pixelSize: 32; clip: true; color: "#bcb6bd";
        }
        Text{
            anchors.top: txt1.bottom; anchors.topMargin: 20; anchors.left: parent.left; width: parent.width / 3
            text: "Почта"; id: txt2In; font.pixelSize: 32; clip: true; height: 60;
        }
        Text{
            MouseArea{
                anchors.fill: parent;
                onClicked: {btnVisible = true; editTxt.visible = true; mailtxt.color = "black"}
            }
            TextEdit{
                Rectangle{color: "#de6062"; anchors.bottom: parent.bottom; height: 1; width: parent.width}
                id: editTxt; visible: false;
                onTextChanged: mail = text
                anchors.fill: parent;
                font.pixelSize: 32; clip: true; color: "#bcb6bd";
            }
            id: mailtxt
            anchors.top: txt1.bottom; anchors.topMargin: 20; anchors.left: txt1.right; width: parent.width / 3 + parent.width / 2
            height: 60; text: mail; font.pixelSize: 32; clip: true; color: "#bcb6bd";
        }
        Text{
            anchors.top: txt2In.bottom; anchors.topMargin: 20; anchors.left: parent.left; width: parent.width / 3
            text: "Телефон"; id: txt3In; font.pixelSize: 32; clip: true; height: 60;
        }
        Text{
            MouseArea{
                anchors.fill: parent;
                onClicked: {btnVisible = true; editTxt2.visible = true; phonetxt.color = "black"}
            }
            TextEdit{
                Rectangle{color: "#de6062"; anchors.bottom: parent.bottom; height: 1; width: parent.width}
                id: editTxt2; visible: false;
                onTextChanged: phone = text
                anchors.fill: parent;
                font.pixelSize: 32; clip: true; color: "#bcb6bd";
            }
            id: phonetxt
            anchors.top: txt2In.bottom; anchors.topMargin: 20; anchors.left: txt1.right; width: parent.width / 3 + parent.width / 2
            text: phone; font.pixelSize: 32; clip: true; color: "#bcb6bd";height: 60;
        }
        Text{
            anchors.top: txt3In.bottom; anchors.topMargin: 20; anchors.left: parent.left; width: parent.width / 3
            text: "Кол-во транспорта"; id: txt4In; font.pixelSize: 32; clip: true; height: 60;
        }
        Text{
            MouseArea{
                anchors.fill: parent;
                onClicked: {btnVisible = true; editTxt3.visible = true; countTxt.color = "black"}
            }
            TextEdit{
                Rectangle{color: "#de6062"; anchors.bottom: parent.bottom; height: 1; width: parent.width}
                id: editTxt3; visible: false;
                onTextChanged: count = text
                anchors.fill: parent;
                font.pixelSize: 32; clip: true; color: "#bcb6bd";
            }
            id: countTxt
            anchors.top: txt3In.bottom; anchors.topMargin: 20; anchors.left: txt1.right; width: parent.width / 3 + parent.width / 2
            height: 60;
            text: count; font.pixelSize: 32; clip: true; color: "#bcb6bd";
        }
    }
    Button{
        id: cancel
        anchors.bottom: parent.bottom;
        anchors.left: parent.left; width: parent.width/2
        background: Rectangle{ anchors.fill: parent; color: cancel.hovered ? "#fbfbfb" : "#de6062";}
        onClicked: backC();
        height: rootPr.scale == 1 ? 60 : 0
        visible: btnVisible
        Text{
            anchors.centerIn: parent; text: "отменить изменения"; color: cancel.hovered ? "#87c5c1" : "white"
            font.pixelSize: 46; font.bold: true;
        }
    }
    Button{
        id: edit
        anchors.bottom: parent.bottom;
        anchors.left: cancel.right; width: parent.width/2
        background: Rectangle{ anchors.fill: parent; color: edit.hovered ? "#fbfbfb" : "#de6062";}
        onClicked: nextC();
        height: rootPr.scale == 1 ? 60 : 0
        visible: btnVisible
        Text{
            anchors.centerIn: parent; text: "внести изменения"; color: edit.hovered ? "#87c5c1" : "white"
            font.pixelSize: 46; font.bold: true;
        }
    }

    Button{
        id: btnback
        anchors.bottom: parent.bottom;
        anchors.left: parent.left; anchors.right: parent.right
        background: Rectangle{ anchors.fill: parent; color: btnback.hovered ? "#fbfbfb" : "#de6062";}
        onClicked: backC();
        height: rootPr.scale == 1 ? 60 : 0
        visible: !btnVisible
        Text{
            anchors.centerIn: parent; text: "Назад"; color: btnback.hovered ? "#87c5c1" : "white"
            font.pixelSize: 46; font.bold: true;
        }
    }
    function nextC(){
        root.usrFlag = flag1
        root.mail = mail
        root.phone = phone
        root.count = count
        network.setProfile(flag1, mail, phone, count);
        if (rootPr.scale == 1) closeProf.restart();
    }

    function backC(){
        if (rootPr.scale == 1) closeProf.restart();
    }
}
