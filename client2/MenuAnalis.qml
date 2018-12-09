import QtQuick 2.9
import QtQuick.Controls 2.2
import "QChart.js" as Charts
import QtQuick.Window 2.3
import QtQuick.Layouts 1.1
import "QChartGallery.js" as ChartsData
Rectangle {
    id: rootAdd
    anchors.fill: parent
    property int max: 10
    property int min: 5
    property int sr: 15
    property int now: 15
    color: {
        for (var i=0;i<root.countUs;i++){
            model.append({text: root.users[i]})
        }
        return "white"
    }
    property alias rootAdd: rootAdd
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
                ListElement {text: "Выберите сотрудника";}
        }
        onCurrentTextChanged: {
            network.getStatUser(currentText)
            console.log(currentText)
        }
    }
    Rectangle{anchors.left: cbmx.left; anchors.right: cbmx.left; height: 2; anchors.bottom: cbmx.bottom}

    Rectangle{
        anchors.top: cbmx.bottom; anchors.left: parent.left; anchors.right: parent.right; anchors.bottom: parent.bottom
        Rectangle{
            id: chart
            anchors.left: parent.left; width: parent.width / 2; height: (parent.height / 2) - 60
            anchors.verticalCenter: parent.verticalCenter;
            color: "white"
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
                        text: "0"
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
                        text: "0"
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
                        text: "0"
                    }
                }
            }

        }
        Rectangle{
            anchors.left: chart.right; width: parent.width / 2; height: (parent.height / 2) - 60
            anchors.verticalCenter: parent.verticalCenter;
            QChart{
                id: chart_BAR;
                anchors.fill: parent
                chartOptions: {"segmentStrokeColor": "#ECECEC"};

            }
            Text{
                anchors.top: chart_BAR.bottom; height: 60;
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 32;
                text: "Время обработки 1 заказа"
            }
        }


    }


    //Нижнее меню

    function setUserStart(message){
        var json_temp = JSON.parse(message)
        txt2.text = json_temp["sr"] + " в среднем пошлина"
        txt3.text = json_temp["min"] + " минимальная пошлина"
        txt.text = json_temp["max"] + " максимальная пошлина"
        sr = parseInt(json_temp["sr"]) === 0 ? 1 : parseInt(json_temp["sr"]);
        min = parseInt(json_temp["min"]) === 0 ? 1 : parseInt(json_temp["min"]);
        max = parseInt(json_temp["max"]) === 0 ? 1 : parseInt(json_temp["max"]);
        console.log("+++++++++++++++++++" + sr + " " + min + " " + max)
        var time1 = json_temp["time"]
        var timel = time1.split(":");
        var minp = parseInt(timel[0] * 60);
        minp += parseInt(timel[1]);
        now = parseInt(minp);
        var ChartBarData1 = {
            labels: ["У сотрудника", "В среднем", "лучший"],
            datasets: [{
                    fillColor: "rgba(220,220,220,0.5)",
                    strokeColor: "rgba(220,220,220,1)",
                    data: [now,40,28, 0]
                }
            ]
        }

        chart_BAR.chartType = Charts.ChartType.BAR
        chart_BAR.chartData = ChartBarData1;
    }

    Connections {
        target: network
        onSetStatUser: {
            setUserStart(message);
        }
    }

}
