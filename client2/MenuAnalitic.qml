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
        network.getStatUser(root.username);
        return "white"
    }
    Rectangle{
        id: chart
        anchors.left: parent.left; width: parent.width / 2; height: (parent.height / 2) - 60
        anchors.verticalCenter: parent.verticalCenter;
        color: "white"
        QChart {
            id: chart_pie;
            anchors.fill: parent
            chartAnimated: true;
            chartAnimationEasing: Easing.Linear;
            chartAnimationDuration: 1000;
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
                    text: "15 tests passed"
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
                    text: "3 tests failed"
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
                    text: "5 tests skipped"
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
            chartAnimated: true;
            chartAnimationEasing: Easing.Linear;
            chartAnimationDuration: 1000;
            chartOptions: {"segmentStrokeColor": "#ECECEC"};

        }
        Text{
            anchors.top: chart_BAR.bottom; height: 60;
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 32;
            text: "Время обработки 1 заказа"
        }
    }




    //Нижнее меню

    function setUserStart(message){
        console.log(message);
        var json_temp = JSON.parse(message)
        console.log(json_temp["time"])
        console.log(json_temp["count"])
        txt2.text = json_temp["sr"] + " в среднем пошлина"
        txt3.text = json_temp["min"] + " минимальная пошлина"
        txt.text = json_temp["max"] + " максимальная пошлина"
        sr = parseInt(json_temp["sr"]);
        min = parseInt(json_temp["min"]);
        max = parseInt(json_temp["max"]);
        var time1 = json_temp["time"]
        var timel = time1.split(":");
        var minp = parseInt(timel[0] * 60);
        minp += parseInt(timel[1]);
        now = parseInt(minp);
        console.log(minp)
        var ChartBarData1 = {
            labels: ["У сотрудника", "В среднем", "лучший"],
            datasets: [{
                    fillColor: "rgba(220,220,220,0.5)",
                    strokeColor: "rgba(220,220,220,1)",
                    data: [now,40,32, 0]
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
