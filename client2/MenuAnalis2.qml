import QtQuick 2.9
import QtQuick.Controls 2.2
import "QChart.js" as Charts
import QtQuick.Window 2.3
import QtQuick.Layouts 1.1
import "QChartGallery.js" as ChartsData
Rectangle{
    id: rot
    anchors.fill: parent
    property int add: 0
    property int max: 1
    property int min: 1
    property int sr: 1
    property int w1: 1
    property int w2: 1
    color: {
        for (var i=0;i<root.countAd;i++){
            console.log("adress = " + root.adress[i])
            model.append({text: root.adress[i]})
        }
        return "white"
    }
    ComboBox{
        id: cbmx
        anchors.top: parent.top;
        width: parent.width; height: 60;
        currentIndex: 0
        textRole: ""
        editable: false
        flat: false
        background: Rectangle{anchors.fill: parent}
        font.pixelSize: 42
        model: ListModel {
            id: model
            ListElement {text: "Выберите пропускной пункт";}
            ListElement {text: "По всем пропускным пунктам";}
        }
        onCurrentTextChanged: {
            if (currentText == "Выберите пропускной пункт") {
                recInFlc2.visible = false;
                return;
            }
            if (currentText == "По всем пропускным пунктам") {
                allStat.visible = true
            }
            else {
                allStat.visible = false;
                network.getCstmStat(currentText);
                recInFlc2.visible = true;
            }
            add = root.adress.indexOf(currentText)

            min = parseInt(root.min[add]);
            max = parseInt(root.max[add]);
            sr = parseInt(root.sr[add]);
            w1 = parseInt(root.wait[add]);
            w2 = parseInt(root.realwait[add]);
        }
    }


    Text{
        id: counttxt
        anchors.top: cbmx.bottom
        anchors.left: parent.left; anchors.right: parent.right; anchors.leftMargin: 20
        font.pixelSize: 48; color: "#d4d4d4"; text: "выполненных записей: " + (parseInt(root.countZap[add]) / 2)
    }
    Flickable{
        id: flck;
        clip: true
        anchors.top: counttxt.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        contentHeight: (parent.height * 2) - 300
        Rectangle{
            width: parent.width; height: (rot.height * 2) - 300
            color: "#f5f5f5"
        }

        Rectangle{
            id: recInFlc1
            color: "#f5f5f5"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height / 2
            Rectangle{
                id: chart
                anchors.left: parent.left; width: parent.width / 2; height: parent.height / 2
                color: "#f5f5f5"
                QChart {
                    id: chart_pie;
                    anchors.fill: parent
                    chartType: Charts.ChartType.PIE;
                    chartOptions: {"segmentStrokeColor": "#ECECEC"};
                    chartData: [
                        {value: max, color: "#6AA84F"},
                        {value:  sr, color: "#DC3912"},
                        {value:  min, color: "#FF9900"}];
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
                            text: "Максимальная пошлина: " + max
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
                            text: "Средняя пошлина:" + sr
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
                            text: "Минимальная пошлина: " + min
                        }
                    }
                }
            }
            Rectangle{
                id: chart2
                anchors.left: chart.right; width: parent.width / 2; height: parent.height / 2
                color: "#f5f5f5"
                QChart {
                    id: chart_Doughnut;
                    anchors.fill: parent
                    chartType: Charts.ChartType.DOUGHNUT;
                    chartOptions: {"segmentStrokeColor": "#ECECEC"};
                    chartData: [
                        {value: w1, color: "#6AA84F"},
                        {value:  w2, color: "#FF9900"}];
                }
                Column {
                    id: legend2
                    anchors.top: chart_Doughnut.bottom; height: 60;
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width / 2;
                    Row {
                        spacing: 5
                        Text {
                            text: "█"; font.pixelSize: 32
                            color:"#6AA84F"
                        }
                        Text {
                            font.pixelSize: 32
                            text: "В среднем ожидают: " + w1
                        }
                    }
                    Row {
                        spacing: 5
                        Text {
                            text: "█"; font.pixelSize: 32
                            color:"#DC3912"
                        }
                        Text {
                            font.pixelSize: 32
                            text: "В среднем осматривают:" + w2
                        }
                    }
                }

            }
        }
        Rectangle{
            id: recInFlc2
            visible: false
            width: parent.width
            anchors.top: recInFlc1.bottom
            anchors.topMargin: -300
            height: parent.height / 2
            color: "#f5f5f5"
            Rectangle{
                id: recTop
                anchors.top: parent.top;
                height: 60
                width: parent.width
                color: "#1c2227"
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    text: "На данном пропускном пункте"
                    color: "white";
                    font.pixelSize: 32
                }
            }
            Rectangle{
                id: recDopTop1
                anchors.top: recTop.bottom;
                height: 60
                width: parent.width
                color: "white"
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    text: "За день"
                    font.pixelSize: 32
                }
            }
            Column{
                id: cl01
                anchors.top: recDopTop1.bottom
                anchors.topMargin: 15
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 20
                Rectangle{
                    width: parent.width
                    color: "#f5f5f5"
                    height: 60
                    Text{
                        id: txt01
                        width: parent.width / 4
                        text: "Прошедших"
                        color: "#1c2227"
                        font.pixelSize: 32
                    }
                    Text{
                        anchors.left: txt01.right
                        id: txt001
                        text: "20"
                        color: "#1c2227"
                        font.pixelSize: 32
                    }

                }
                Rectangle{
                    width: parent.width
                    color: "#f5f5f5"
                    height: 60
                    Text{
                        id: txt02
                        width: parent.width / 4
                        text: "Отказов"
                        font.pixelSize: 32
                    }
                    Text{
                        anchors.left: txt02.right
                        id: txt002
                        text: "10"
                        font.pixelSize: 32
                    }
                }

            }
            Rectangle{
                id: recDopTop2
                anchors.top: cl01.bottom;
                height: 60
                width: parent.width
                color: "white"
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    text: "За неделю"
                    font.pixelSize: 32
                }
            }
            Column{
                id: cl02
                anchors.top: recDopTop2.bottom
                anchors.topMargin: 15
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 20
                Rectangle{
                    width: parent.width
                    color: "#f5f5f5"
                    height: 60
                    Text{
                        id: txt03
                        width: parent.width / 4
                        text: "Прошедших"
                        color: "#1c2227"
                        font.pixelSize: 32
                    }
                    Text{
                        anchors.left: txt03.right
                        id: txt003
                        text: "14"
                        color: "#1c2227"
                        font.pixelSize: 32
                    }

                }
                Rectangle{
                    width: parent.width
                    color: "#f5f5f5"
                    height: 60
                    Text{
                        id: txt04
                        width: parent.width / 4
                        text: "Отказов"
                        font.pixelSize: 32
                    }
                    Text{
                        anchors.left: txt04.right
                        id: txt004
                        text: "240"
                        font.pixelSize: 32
                    }
                }

            }
            Rectangle{
                id: recDopTop3
                anchors.top: cl02.bottom;
                height: 60
                width: parent.width
                color: "white"
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    text: "За месяц"
                    font.pixelSize: 32
                }
            }
            Column{
                id: cl03
                anchors.top: recDopTop3.bottom
                anchors.topMargin: 15
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 20
                Rectangle{
                    width: parent.width
                    color: "#f5f5f5"
                    height: 60
                    Text{
                        id: txt05
                        width: parent.width / 4
                        text: "Прошедших"
                        color: "#1c2227"
                        font.pixelSize: 32
                    }
                    Text{
                        anchors.left: txt05.right
                        id: txt005
                        text: "1432"
                        color: "#1c2227"
                        font.pixelSize: 32
                    }

                }
                Rectangle{
                    width: parent.width
                    color: "#f5f5f5"
                    height: 60
                    Text{
                        id: txt06
                        width: parent.width / 4
                        text: "Отказов"
                        font.pixelSize: 32
                    }
                    Text{
                        anchors.left: txt06.right
                        id: txt006
                        text: "2420"
                        font.pixelSize: 32
                    }
                }

            }
            Rectangle{
                id: recDopTop4
                anchors.top: cl03.bottom;
                height: 60
                width: parent.width
                color: "white"
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    text: "За год"
                    font.pixelSize: 32
                }
            }
            Column{
                id: cl04
                anchors.top: recDopTop4.bottom
                anchors.topMargin: 15
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 20
                Rectangle{
                    width: parent.width
                    color: "#f5f5f5"
                    height: 60
                    Text{
                        id: txt07
                        width: parent.width / 4
                        text: "Прошедших"
                        color: "#1c2227"
                        font.pixelSize: 32
                    }
                    Text{
                        anchors.left: txt07.right
                        id: txt007
                        text: "6543"
                        color: "#1c2227"
                        font.pixelSize: 32
                    }

                }
                Rectangle{
                    width: parent.width
                    color: "#f5f5f5"
                    height: 60
                    Text{
                        id: txt08
                        width: parent.width / 4
                        text: "Отказов"
                        font.pixelSize: 32
                    }
                    Text{
                        anchors.left: txt08.right
                        id: txt008
                        text: "1356"
                        font.pixelSize: 32
                    }
                }

            }
        }


    }
    Rectangle{
        id: allStat
        visible: false;
        anchors.top: counttxt.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left; anchors.right: parent.right
        AllStat{id: als; anchors.fill: parent}
        onVisibleChanged: {
            als.setText();
        }
    }
    function setParam(dS, dC, wS, wC, mS, mC, yS, yC){
        console.log("22222");
        txt001.text = dS;
        txt002.text = dC;
        txt003.text = wS;
        txt004.text = wC;
        txt005.text = mS;
        txt006.text = mC;
        txt007.text = yS;
        txt008.text = yC;
        console.log("333333");
    }

    Connections{
        target: network;
        onGetCstmStat1:{
            setParam(m1,m2,m3,m4,m5,m6,m7,m8);
        }
    }
}
