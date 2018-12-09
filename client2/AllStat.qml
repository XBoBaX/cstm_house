import QtQuick 2.9
import QtCharts 2.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
Rectangle{
    anchors.fill: parent;
    property variant masM: ["Январь", "Ферваль", "Март", "Апрель", "Май", "Июнь", "Июль", "Апрель", "Сентябрь", "Ноябрь", "Октябрь", "Декабрь"]
    //    Text{ id: txtAll; font.pixelSize: 48; color: "#d4d4d4";}
    ComboBox{
        id: cbmx
        width: parent.width / 3
        height: 60
        model: ["За весь год", "За месяц"]
        background: Rectangle{anchors.fill: parent; color: "#1c2227"}
        font.pixelSize: 42;
        contentItem: Text {
            leftPadding: 20
            rightPadding: cbmx.indicator.width + cbmx.spacing
            text: cbmx.displayText
            font.pixelSize: 42;
            color: "white"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            elide: Text.ElideRight;
        }
        onCurrentTextChanged: {
            chart.visible = false; chart01.visible = false; //chart02.visible = false;
            console.log(masM.indexOf(cbmx2.currentText))
            if (currentText == "За месяц"){
                cbmx2.visible = true; chart01.visible = true;
            }
            else if (currentText == "За весь год") {
                cbmx2.visible = false; chart.visible = true;
            }
        }
    }
    ComboBox{
        id: cbmx2; visible: false
        anchors.right: parent.right
        width: parent.width / 3
        height: 60
        model: ["Январь", "Ферваль", "Март", "Апрель", "Май", "Июнь", "Июль", "Апрель", "Сентябрь", "Ноябрь", "Октябрь", "Декабрь", "Все"]
        background: Rectangle{anchors.fill: parent; color: "#1c2227"}
        font.pixelSize: 42;
        contentItem: Text {
            leftPadding: 20
            rightPadding: cbmx2.indicator.width + cbmx2.spacing
            text: cbmx2.displayText
            font.pixelSize: 42;
            color: "white"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            elide: Text.ElideRight;
        }
        onCurrentIndexChanged: {
            if (currentIndex == 12){
                li.visible = false; li1.visible = true; li2.visible = true; li3.visible = true; li4.visible = true; li5.visible = true; li6.visible = true;
                li9.visible = true; li8.visible = true; li9.visible = true; li10.visible = true; li11.visible = true; li12.visible = true;
                axisY1.max = root.maxMounth
                return
            }
            li.visible = true; li1.visible = false; li2.visible = false; li3.visible = false; li4.visible = false; li5.visible = false; li6.visible = false;
            li7.visible = false; li8.visible = false; li9.visible = false; li10.visible = false; li11.visible = false; li12.visible = false;
            li.clear();
            li.append(1, root.week[cbmx2.currentIndex * 5]);
            li.append(2, root.week[(cbmx2.currentIndex * 5) + 1]);
            li.append(3, root.week[(cbmx2.currentIndex * 5) + 2]);
            li.append(4, root.week[(cbmx2.currentIndex * 5) + 3]);
            li.append(5, root.week[(cbmx2.currentIndex * 5) + 4]);

            axisY1.max = Math.max(root.week[cbmx2.currentIndex * 5], root.week[(cbmx2.currentIndex * 5) + 1], root.week[(cbmx2.currentIndex * 5) + 2], root.week[(cbmx2.currentIndex * 5) + 3], root.week[(cbmx2.currentIndex * 5) + 4]); ;
        }
    }
    Rectangle{anchors.top: cbmx.top; width: parent.width; height: 1; color: "#d4d4d4"}
    Rectangle{
        id: chart
        anchors.top: cbmx.bottom; anchors.topMargin: 20
        anchors.left: parent.left; anchors.right: parent.right; height: parent.height - cbmx.height
        ChartView {
            id: chart1
            title: "Доход от всех ПП"
            anchors.fill: parent
            antialiasing: true
            animationOptions: ChartView.AllAnimations
            animationDuration: 1000
            theme: ChartView.ChartThemeBlueNcs
            ValueAxis {
                id: axisY
                min: 0
                max: root.maxMounth
                tickCount: 12
            }
            ScatterSeries {
                id: series2
                axisY: axisY
            }
            LineSeries {
                axisX: CategoryAxis {
                    min: 1
                    max: 12
                    CategoryRange {
                        label: "Январь"
                        endValue: 1; id: sel1
                    }
                    CategoryRange {
                        label: "Ферваль"
                        endValue: 2; id: sel2
                    }
                    CategoryRange {
                        label: "Март"
                        endValue: 3; id: sel3
                    }
                    CategoryRange {
                        label: "Апрель"
                        endValue: 4; id: sel4
                    }
                    CategoryRange {
                        label: "Май"
                        endValue: 5; id: sel5
                    }
                    CategoryRange {
                        label: "Июнь"
                        endValue: 6; id: sel6
                    }
                    CategoryRange {
                        label: "Июль"
                        endValue: 7; id: sel7
                    }
                    CategoryRange {
                        label: "Август"
                        endValue: 8; id: sel8
                    }
                    CategoryRange {
                        label: "Сентябрь"
                        endValue: 9; id: sel9
                    }
                    CategoryRange {
                        label: "Октябрь"
                        endValue: 10; id: sel10
                    }
                    CategoryRange {
                        label: "Ноябрь"
                        endValue: 11; id: sel11
                    }
                    CategoryRange {
                        label: "Декабрь"
                        endValue: 12; id: sel12
                    }
                }
                XYPoint { x: 1; y: root.mounthList[0]}
                XYPoint { x: 2; y: root.mounthList[1]}
                XYPoint { x: 3; y: root.mounthList[2]}
                XYPoint { x: 4; y: root.mounthList[3]}
                XYPoint { x: 5; y: root.mounthList[4]}
                XYPoint { x: 6; y: root.mounthList[5]}
                XYPoint { x: 7; y: root.mounthList[6]}
                XYPoint { x: 8; y: root.mounthList[7]}
                XYPoint { x: 9; y: root.mounthList[8]}
                XYPoint { x: 10; y: root.mounthList[9]}
                XYPoint { x: 11; y: root.mounthList[10]}
                XYPoint { x: 12; y: root.mounthList[11]}
            }
        }
    }
    Rectangle{
        id: chart01
        anchors.top: cbmx.bottom; anchors.topMargin: 20
        anchors.left: parent.left; anchors.right: parent.right; height: parent.height - cbmx.height
        ChartView {
            id: chart11
            title: "Доход от всех ПП"
            anchors.fill: parent
            antialiasing: true
            animationOptions: ChartView.AllAnimations
            animationDuration: 1000
            theme: ChartView.ChartThemeBlueNcs
            ValueAxis {
                id: axisY1
                min: 0
                max: root.maxMounth
                tickCount: 5
            }
            ScatterSeries {
                id: series21
                axisY: axisY1
                axisX: CategoryAxis {
                    min: 1
                    max: 5
                    CategoryRange {
                        label: "1 неделя"
                        endValue: 1;
                    }
                    CategoryRange {
                        label: "2 неделя"
                        endValue: 2;
                    }
                    CategoryRange {
                        label: "3 неделя"
                        endValue: 3;
                    }
                    CategoryRange {
                        label: "4 неделя"
                        endValue: 4;
                    }
                    CategoryRange {
                        label: "5 неделя"
                        endValue: 5;
                    }
                }
            }
            LineSeries {
                id: li;
                name: "Выбранный месяц"
                XYPoint { id: xy1; x: 1; y: root.week[0]}
                XYPoint { id: xy2; x: 2; y: root.week[1]}
                XYPoint { id: xy3; x: 3; y: root.week[2]}
                XYPoint { id: xy4; x: 4; y: root.week[3]}
                XYPoint { id: xy5; x: 5; y: root.week[4]}
            }
            LineSeries {
                id: li1; visible: false;
                name: "Январь"
                XYPoint {x: 1; y: root.week[0]}
                XYPoint {x: 2; y: root.week[1]}
                XYPoint {x: 3; y: root.week[2]}
                XYPoint {x: 4; y: root.week[3]}
                XYPoint {x: 5; y: root.week[4]}
            }
            LineSeries {
                id: li2; visible: false;
                name: "Февраль"
                XYPoint {x: 1; y: root.week[5]}
                XYPoint {x: 2; y: root.week[6]}
                XYPoint {x: 3; y: root.week[7]}
                XYPoint {x: 4; y: root.week[8]}
                XYPoint {x: 5; y: root.week[9]}
            }
            LineSeries {
                id: li3; visible: false;
                name: "Март"
                XYPoint {x: 1; y: root.week[10]}
                XYPoint {x: 2; y: root.week[11]}
                XYPoint {x: 3; y: root.week[12]}
                XYPoint {x: 4; y: root.week[13]}
                XYPoint {x: 5; y: root.week[14]}
            }
            LineSeries {
                id: li4; visible: false;
                name: "Апрель"
                XYPoint {x: 1; y: root.week[15]}
                XYPoint {x: 2; y: root.week[16]}
                XYPoint {x: 3; y: root.week[17]}
                XYPoint {x: 4; y: root.week[18]}
                XYPoint {x: 5; y: root.week[19]}
            }
            LineSeries {
                id: li5; visible: false;
                name: "Май"
                XYPoint {x: 1; y: root.week[20]}
                XYPoint {x: 2; y: root.week[21]}
                XYPoint {x: 3; y: root.week[22]}
                XYPoint {x: 4; y: root.week[23]}
                XYPoint {x: 5; y: root.week[24]}
            }
            LineSeries {
                id: li6; visible: false;
                name: "Июнь"
                XYPoint {x: 1; y: root.week[25]}
                XYPoint {x: 2; y: root.week[26]}
                XYPoint {x: 3; y: root.week[27]}
                XYPoint {x: 4; y: root.week[28]}
                XYPoint {x: 5; y: root.week[29]}
            }
            LineSeries {
                id: li7; visible: false;
                name: "Июль"
                XYPoint {x: 1; y: root.week[30]}
                XYPoint {x: 2; y: root.week[31]}
                XYPoint {x: 3; y: root.week[32]}
                XYPoint {x: 4; y: root.week[33]}
                XYPoint {x: 5; y: root.week[34]}
            }
            LineSeries {
                id: li8; visible: false;
                name: "Август"
                XYPoint {x: 1; y: root.week[35]}
                XYPoint {x: 2; y: root.week[36]}
                XYPoint {x: 3; y: root.week[37]}
                XYPoint {x: 4; y: root.week[38]}
                XYPoint {x: 5; y: root.week[39]}
            }
            LineSeries {
                id: li9; visible: false;
                name: "Сентябрь"
                XYPoint {x: 1; y: root.week[40]}
                XYPoint {x: 2; y: root.week[41]}
                XYPoint {x: 3; y: root.week[42]}
                XYPoint {x: 4; y: root.week[43]}
                XYPoint {x: 5; y: root.week[44]}
            }
            LineSeries {
                id: li10; visible: false;
                name: "Октябрь"
                XYPoint {x: 1; y: root.week[45]}
                XYPoint {x: 2; y: root.week[46]}
                XYPoint {x: 3; y: root.week[47]}
                XYPoint {x: 4; y: root.week[48]}
                XYPoint {x: 5; y: root.week[49]}
            }
            LineSeries {
                id: li11; visible: false;
                name: "Ноябрь"
                XYPoint {x: 1; y: root.week[50]}
                XYPoint {x: 2; y: root.week[51]}
                XYPoint {x: 3; y: root.week[52]}
                XYPoint {x: 4; y: root.week[53]}
                XYPoint {x: 5; y: root.week[54]}
            }
            LineSeries {
                id: li12; visible: false;
                name: "Декабрь"
                XYPoint {x: 1; y: root.week[55]}
                XYPoint {x: 2; y: root.week[56]}
                XYPoint {x: 3; y: root.week[57]}
                XYPoint {x: 4; y: root.week[58]}
                XYPoint {x: 5; y: root.week[59]}
            }
        }
    }

    function setText(){
        console.log(root.maxMounth)
        axisY.max = root.maxMounth
        //        txtAll.text = "выполненных записей: " + root.allCount;

    }
}
