import QtQuick 2.9
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "GlobalVariables.js" as GlobalVariables

Rectangle{
    property string tempday
    anchors.fill: parent
    //основа
    Rectangle {
        id: recBG; anchors.fill: parent;

        color: { //При инициализации
            editWeekList();
            updateRecords();
            otdelText.text = "Пользователь: " + userName;
            return "white"
        }

        Item { //Добавление в расписание
            id: road
            anchors.fill: parent;
            Rectangle{ //Левя панель
                id: leftPanel
                color: "#fafafa"; anchors.left: parent.left
                anchors.top: parent.top; anchors.bottom: parent.bottom
                width: {
                    if (parent.width / 4 > 300) return parent.width / 4;
                    else return 300;
                }

                Item { //Левая панель СВЕРХУ
                    id: leftPanelTop
                    anchors.left: parent.left; anchors.top: parent.top
                    height: 80; width: parent.width - (parent.width / 4)
                    Rectangle{
                        color: "#f7f7f7"
                        width: 2; height: parent.height
                        anchors.right: parent.right
                    }

                    Text {
                        font.family: "fontRoboto"
                        font.pixelSize: {
                            if (parent.width / 10 > 16) return parent.width / 10;
                            else return 16;
                        }
                        text: "Расписание"; color: "#3d3d3d"
                        anchors.centerIn: parent
                    }
                }
                Item { //Левая панель остальное
                    id: leftPanelCenter
                    anchors.left: parent.left; anchors.right: parent.right
                    anchors.top: leftPanelTop.bottom; anchors.bottom: parent.bottom
                    Item { //Календарь
                        anchors.fill: parent
                        Item {
                            anchors.top: parent.top; height: parent.height / 2; id: calendarLeft
                            anchors.left: parent.left; anchors.right: parent.right
                            Calendar{
                                id: customCalendar; anchors.fill: parent
                                minimumDate: new Date(2018, 0, 1)
                                maximumDate: new Date(2118, 0, 1)
                                property var locale: Qt.locale()
                                onClicked: {
                                    var dataString = Date.parse(customCalendar.selectedDate)
                                    GlobalVariables.curr_now = new Date(Date.parse(customCalendar.selectedDate))
                                    var curr = new Date(dataString)

                                    var dayWeek = 1
                                    if(curr.getDay()==0) dayWeek = 7;
                                    else dayWeek = curr.getDay();

                                    var first = curr.getDate() - (dayWeek - 1);
                                    var last = first + 6;
                                    var data1 = new Date(curr.setDate(first));
                                    //                                                + masMount[data2.getMonth()] + " " + data2.getDate() + ", " + data2.getFullYear();
                                    var data2 = new Date(curr.setDate(last));
                                    updatePainitg();
                                    //Вносим изменния в глобальную переменную
                                    if (GlobalVariables.dataFirst.getDate() !== data1.getDate())
                                    {
                                        selectDate.restart()
                                        GlobalVariables.dataFirst = data1
                                        GlobalVariables.dataSecond = data2
                                        updateRecords();
                                        editWeekList();
                                    }
                                }

                                style: CalendarStyle {
                                    gridVisible: false; gridColor: "transparent"
                                    background: Rectangle {
                                        anchors.fill: parent
                                        color: "#fafafa"
                                    }
                                    navigationBar: Rectangle {
                                        height: 60; color: "#fafafa"

                                        Button {
                                            id: previousMonth
                                            width: (customCalendar.width / 5) - 5
                                            height: parent.height; anchors.left: parent.left
                                            anchors.verticalCenter: parent.verticalCenter
                                            style: ButtonStyle{
                                                background: Rectangle{
                                                    color: "#fafafa"
                                                }
                                            }
                                            Text{
                                                anchors.centerIn: parent
                                                font.pixelSize: 28
                                                font.family: "fontawesome"
                                                text: "\uf053"; color: "#787878"
                                            }
                                            onClicked: control.showPreviousMonth()
                                        }
                                        Label {
                                            id: dateText; text: styleData.title
                                            elide: Text.ElideRight
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 28
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: previousMonth.right
                                            anchors.leftMargin: 2
                                            anchors.right: nextMonth.left
                                            anchors.rightMargin: 2
                                            color: "#787878"
                                        }
                                        Button {
                                            id: nextMonth
                                            width: (customCalendar.width / 5) - 5
                                            height: parent.height
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.right: parent.right
                                            style: ButtonStyle{
                                                background: Rectangle{
                                                    color: "#fafafa"
                                                }
                                            }
                                            Text{
                                                anchors.centerIn: parent
                                                font.pixelSize: 28
                                                font.family: "fontawesome"
                                                text: "\uf054"; color: "#787878"
                                            }
                                            onClicked: control.showNextMonth()
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Rectangle { //Добавить
                        id: buttonAdd; color: "#fafafa"; clip: true
                        anchors.bottom: parent.bottom; height: 80
                        anchors.left: parent.left; anchors.right: parent.right
                        Button{
                            id: buttonAddInRect
                            width: parent.width; height: 80
                            Rectangle{
                                anchors.fill: parent; color: "#0078d7"; id: bgBtn
                                Item{
                                    anchors.centerIn: parent;
                                    height: textIconAdd.height; width: textIconAdd.width + textAdd.width
                                    Text{
                                        id: textIconAdd
                                        font.family: "fontawesome"
                                        font.pixelSize: 32
                                        text: "\uf055"; color: "#fff"
                                    }
                                    Text{
                                        id: textAdd
                                        anchors.left: textIconAdd.right; anchors.leftMargin: 10
                                        anchors.verticalCenter: textIconAdd.verticalCenter
                                        font.family: "fontRoboto";font.pixelSize: 32
                                        text: "Выбор времени"; color: "#fff"
                                    }
                                }
                            }
                            Rectangle{
                                anchors.top: parent.top; height: 2; width: parent.width; color: "#f5f5f5"
                            }

                            onClicked: {
                                addRecord();
                                if (buttonAdd.height == 80) {
                                    animanitionAdd.restart();
                                    bgBtn.color = "#fafafa"; textIconAdd.color = "#787878"; textAdd.color = "#787878"
                                }
                                else {
                                    animanitionAddBack.restart();
                                    bgBtn.color = "#0078d7"; textIconAdd.color = "#fff"; textAdd.color = "#fff"
                                }
                            }
                        }
                        TumblerCalendar{
                            id: tumblerCal
                            anchors.top: buttonAddInRect.bottom;
                            height: 160; anchors.left: parent.left; anchors.right: parent.right
                        }
                        Rectangle{
                            id: rctgTime; height: 80; anchors.top: tumblerCal.bottom;
                            anchors.left: parent.left; anchors.right: parent.right
                            Row{
                                anchors.fill: parent
                                TextField{
                                    text: tumblerCal.hour
                                    validator: IntValidator{bottom: 0; top: 23;}
                                    onTextChanged: {
                                        if (text == "") return;
                                        tumblerCal.modeldata1 = text;
                                    }
                                    width: parent.width/2; height: parent.height
                                    font.pixelSize: 28
                                }
                                TextField{
                                    text: tumblerCal.min
                                    validator: IntValidator{bottom: 0; top: 59;}
                                    onTextChanged: {
                                        if (text == "") return;
                                        tumblerCal.modeldata2 = text;
                                    }
                                    width: parent.width/2; height: parent.height
                                    font.pixelSize: 28
                                }
                            }
                        }
                        Button{ //Сделать и удалить комментарий
                            id: buttomAddEnter; width: parent.width; height: 80
                            anchors.top: rctgTime.bottom
                            Rectangle{
                                anchors.fill: parent; color: "#0078d7";
                                Item{
                                    anchors.horizontalCenter: parent.horizontalCenter;
                                    anchors.verticalCenter: parent.verticalCenter
                                    height: textAddEnter.height; width: textAddEnter.width
                                    Text{
                                        id: textAddEnter
                                        anchors.centerIn: parent
                                        font.family: "fontRoboto"; font.pixelSize: 32
                                        text: "На таможню в " + tumblerCal.hour + ":" + tumblerCal.min  ; color: "white"
                                    }

                                }
                            }
                            onClicked: {
                                var hour1 = tumblerCal.hour.toString().length == 1 ? "0" + tumblerCal.hour :
                                                                                     tumblerCal.hour
                                var min1 = tumblerCal.min.toString().length == 1 ? "0" + tumblerCal.min :
                                                                                   tumblerCal.min
                                var dateStr = new Date(customCalendar.selectedDate);
                                console.log(dateStr)
                                setTimeMain(hour1, min1, dateStr.getFullYear(), dateStr.getMonth() + 1, dateStr.getDate());
                                animanitionAddBack.restart();
                            }
                        }
                    }

                    NumberAnimation {
                        id: animanitionAdd
                        target: buttonAdd
                        property: "height"
                        duration: 200
                        from: 80
                        to: 400
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        id: animanitionAddBack
                        target: buttonAdd
                        property: "height"
                        duration: 200
                        from: 400
                        to: 80
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            Rectangle { //Правая панель
                id: rightPanel; color: "white"
                anchors.left: leftPanel.right; anchors.right: parent.right
                anchors.top: parent.top; anchors.bottom: parent.bottom


                Item { //Верхняя панель
                    id: rightPanelTop
                    anchors.left: parent.left; anchors.right: parent.right
                    anchors.top: parent.top; height: 80

                    Rectangle { //Первая часть верхней панель
                        id: rightPanelTopFirst
                        anchors.left: parent.left; width: parent.width / 3
                        anchors.top: parent.top; anchors.bottom: parent.bottom

                        CustomBorder{
                            rBorderwidth: 2
                            color: "#f7f7f7"
                        }
                        Item {
                            id: whatWeek
                            anchors.fill: parent
                            MouseArea{
                                z: 1
                                hoverEnabled: true
                                anchors.fill: parent
                                onClicked: {
                                    console.log("fdf")
                                    if (textWeek.text == "Неделя"){
                                        tempday = textNowWeek.text
                                        textNowWeek.text = "Назад"
                                        daySelectRec.visible = true
                                        var masMount = ["Янв", "Фев", "Мар", "Апр", "Май", "Июнь", "Июль", "Авг", "Сен", "Окт", "Ноя", "Дек"]
                                        network.sendGetRecodDay(GlobalVariables.curr_now.getFullYear() + "-" + (GlobalVariables.curr_now.getMonth()+1) + "-" + GlobalVariables.curr_now.getDate())
                                        textWeek.text = "День " + masMount[GlobalVariables.curr_now.getMonth()] + ", " + GlobalVariables.curr_now.getDate()
                                    }
                                    else{
                                        textNowWeek.text = tempday
                                        daySelectRec.visible = false
                                        textWeek.text = "Неделя"
                                    }
                                }
                                onEntered: {
                                    mnFr.color = "#fbfbfb"
                                }
                                onExited: { mnFr.color = "white"}
                                id: ms
                            }
                            Rectangle {
                                id: mnFr
                                anchors.verticalCenter: parent.verticalCenter
                                height: textNowWeek.height + textWeek.height
                                width: parent.width
                                Text{
                                    id: textNowWeek
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.styleName: "fontRoboto"
                                    font.pixelSize: {
                                        if (whatWeek.width / 10 - 15 <= 15) return 15;
                                        return whatWeek.width / 10 - 15;
                                    }
                                    color: "#87c5c1"; text: "Окт 8, 2018 - Окт 14, 2018"
                                }
                                Text{
                                    id: textWeek
                                    anchors.top: textNowWeek.bottom
                                    anchors.left: textNowWeek.left
                                    font.styleName: "fontRoboto"
                                    font.pixelSize: {
                                        if (whatWeek.width / 10 - 25 <= 12) return 12;
                                        return whatWeek.width / 10 - 25;
                                    }
                                    color: "#d3d3d3"; text: "Неделя"
                                }
                            }

                        }

                    }
                    Rectangle { //Вторая часть верхней панель
                        id: rightPanelTopSecond
                        anchors.left: rightPanelTopFirst.right;
                        anchors.top: parent.top; anchors.bottom: parent.bottom
                        width: parent.width / 3
                        Text{
                            id: textCalendar
                            anchors.centerIn: parent
                            font.styleName: "fontRoboto"
                            font.pixelSize: 32
                            color: "#87c5c1"; text: "Открыть карту"
                        }
                        MouseArea{
                            anchors.fill: parent;
                            hoverEnabled: true
                            onEntered: rightPanelTopSecond.color = "#fbfbfb"
                            onExited: rightPanelTopSecond.color = "white"
                            onClicked: {
                                textCalendar.text = textCalendar.text == "Назад" ? "Открыть карту" : "Назад"
                                calendar.visible = !calendar.visible
                            }
                        }
                    }
                    Rectangle { //Третья часть верхней панель
                        MouseArea{ //ДОБАВИТЬ ОТКРЫТИЕ БЛОКА
                            id: btnGo; hoverEnabled: true
                            anchors.fill: parent
                            onClicked: {
                                network.getCount();
                            }
                            onEntered: {
                                rightPanelTopThird.color = "#fbfbfb"
                                otdelText.color = "#00867c"
                            }
                            onExited:{
                                otdelText.color = "#c9c9c9"
                                rightPanelTopThird.color = "white"
                            }
                        }
                        id: rightPanelTopThird
                        anchors.left: rightPanelTopSecond.right
                        anchors.top: parent.top; anchors.bottom: parent.bottom
                        width: parent.width / 3
                        color: btnGo.hovered ? "black" : "white"
                        Text {
                            anchors.centerIn: parent
                            font.styleName: "fontRoboto"
                            font.pixelSize: {
                                if (whatWeek.width / 10 - 15 <= 15) return 15;
                                return whatWeek.width / 10 - 15;
                            }
                            color: "#c9c9c9"; text: "12"; id: otdelText
                        }
                        CustomBorder{
                            lBorderwidth: 2
                            color: "#f7f7f7"
                        }
                    }
                }


                Item { //Остальная часть
                    id: calendarPart
                    anchors.top: rightPanelTop.bottom; anchors.bottom: parent.bottom
                    anchors.left: parent.left; anchors.right: parent.right

                    Flickable{
                        id: flckPN; anchors.top: parent.top; anchors.bottom: parent.bottom
                        anchors.left: parent.left; anchors.right: parent.right
                        clip: true; contentHeight: 10000
                        Rectangle { //День недели ПН
                            id: weekMon
                            anchors.left: parent.left
                            anchors.top: parent.top; anchors.bottom: parent.bottom
                            width: parent.width / 7

                            Item { //Текст ПН
                                anchors.top: parent.top; anchors.topMargin: 20
                                anchors.left: parent.left; anchors.right: parent.right
                                property string colorText: "#c9c9c9"; id: mon
                                Text {
                                    id: weekMonText
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"
                                    font.pixelSize: 32
                                    text: "1"

                                    font.bold: true
                                    color: mon.colorText
                                }
                                Text {
                                    anchors.top: weekMonText.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"
                                    font.pixelSize: 32
                                    text: "ПН"
                                    color: mon.colorText
                                }
                            }

                            Column { // Для записей
                                id: columnMon; anchors.topMargin: 120; spacing: 10
                                anchors.left: parent.left; anchors.top: parent.top;
                                anchors.right: parent.right; anchors.bottom: parent.bottom
                            }

                            CustomBorder{
                                rBorderwidth: 2
                                color: "#f9f9f9"
                            }

                        }
                        Rectangle { //День недели ВТ
                            id: weekTue
                            anchors.left: weekMon.right; width: parent.width / 7
                            anchors.top: parent.top; anchors.bottom: parent.bottom

                            Item { //Текст ВТ
                                anchors.top: parent.top; anchors.topMargin: 20
                                anchors.left: parent.left; anchors.right: parent.right
                                property string colorText: "#c9c9c9"; id: tue
                                Text {
                                    id: weekTueText
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"; font.pixelSize: 32
                                    text: "1"; font.bold: true
                                    color: tue.colorText
                                }
                                Text {
                                    anchors.top: weekTueText.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"; font.pixelSize: 32
                                    text: "ВТ"; color: tue.colorText
                                }
                            }

                            Column { // Для записей
                                id: columnTue; anchors.topMargin: 120; spacing: 10
                                anchors.left: parent.left; anchors.top: parent.top;
                                anchors.right: parent.right; anchors.bottom: parent.bottom
                            }

                            CustomBorder{
                                rBorderwidth: 2
                                lBorderwidth: 2
                                color: "#f9f9f9"
                            }
                        }
                        Rectangle { //День недели СР
                            id: weekWed
                            anchors.left: weekTue.right; width: parent.width / 7
                            anchors.top: parent.top; anchors.bottom: parent.bottom

                            Item { //Текст СР
                                anchors.top: parent.top; anchors.topMargin: 20
                                anchors.left: parent.left; anchors.right: parent.right
                                property string colorText: "#c9c9c9"; id: wed
                                Text {
                                    id: weekWedText
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"; font.pixelSize: 32
                                    text: "1"; font.bold: true
                                    color: wed.colorText
                                }
                                Text {
                                    anchors.top: weekWedText.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"; font.pixelSize: 32
                                    text: "СР"; color: wed.colorText
                                }
                            }

                            Column { // Для записей
                                id: columnWed; anchors.topMargin: 120; spacing: 10
                                anchors.left: parent.left; anchors.top: parent.top;
                                anchors.right: parent.right; anchors.bottom: parent.bottom
                            }

                            CustomBorder{
                                rBorderwidth: 2
                                lBorderwidth: 2
                                color: "#f9f9f9"
                            }
                        }
                        Rectangle { //День недели ЧТ
                            id: weekThu
                            anchors.left: weekWed.right; width: parent.width / 7
                            anchors.top: parent.top; anchors.bottom: parent.bottom

                            Item { //Текст ЧТ
                                anchors.top: parent.top; anchors.topMargin: 20
                                anchors.left: parent.left; anchors.right: parent.right
                                property string colorText: "#c9c9c9"; id: thu
                                Text {
                                    id: weekThuText
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"; font.pixelSize: 32
                                    text: "1"; font.bold: true
                                    color: thu.colorText
                                }
                                Text {
                                    anchors.top: weekThuText.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"; font.pixelSize: 32
                                    text: "ЧТ"; color: thu.colorText
                                }
                            }

                            Column { // Для записей
                                id: columnThu; anchors.topMargin: 120; spacing: 10
                                anchors.left: parent.left; anchors.top: parent.top;
                                anchors.right: parent.right; anchors.bottom: parent.bottom
                            }

                            CustomBorder{
                                rBorderwidth: 2
                                lBorderwidth: 2
                                color: "#f9f9f9"
                            }
                        }
                        Rectangle { //День недели ПT
                            id: weekFri
                            anchors.left: weekThu.right; width: parent.width / 7
                            anchors.top: parent.top; anchors.bottom: parent.bottom
                            Item { //Текст Пт
                                anchors.top: parent.top; anchors.topMargin: 20
                                anchors.left: parent.left; anchors.right: parent.right
                                property string colorText: "#c9c9c9"; id: fri
                                Text {
                                    id: weekFriText
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"; font.pixelSize: 32
                                    text: "1"; font.bold: true
                                    color: fri.colorText
                                }
                                Text {
                                    anchors.top: weekFriText.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"; font.pixelSize: 32
                                    text: "ПТ"; color: fri.colorText
                                }
                            }

                            Column { // Для записей
                                id: columnFri; anchors.topMargin: 120; spacing: 10
                                anchors.left: parent.left; anchors.top: parent.top;
                                anchors.right: parent.right; anchors.bottom: parent.bottom
                            }

                            CustomBorder{
                                rBorderwidth: 2
                                lBorderwidth: 2
                                color: "#f9f9f9"
                            }
                        }
                        Rectangle { //День недели СБ
                            id: weekSat
                            anchors.left: weekFri.right; width: parent.width / 7
                            anchors.top: parent.top; anchors.bottom: parent.bottom

                            Item { //Текст СБ
                                anchors.top: parent.top; anchors.topMargin: 20
                                anchors.left: parent.left; anchors.right: parent.right
                                property string colorText: "#c9c9c9"; id: sat
                                Text {
                                    id: weekSatText
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"; font.pixelSize: 32
                                    text: "1"; font.bold: true
                                    color: parent.colorText;
                                }
                                Text {
                                    anchors.top: weekSatText.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"; font.pixelSize: 32
                                    text: "СБ"; color: parent.colorText;
                                }
                            }

                            Column { // Для записей
                                id: columnSat; anchors.topMargin: 120; spacing: 10
                                anchors.left: parent.left; anchors.top: parent.top;
                                anchors.right: parent.right; anchors.bottom: parent.bottom
                            }

                            CustomBorder{
                                rBorderwidth: 2
                                lBorderwidth: 2
                                color: "#f9f9f9"
                            }
                        }
                        Rectangle { //День недели ВС
                            id: weekSun;
                            anchors.left: weekSat.right; width: parent.width / 7
                            anchors.top: parent.top; anchors.bottom: parent.bottom

                            Item { //Текст ВС
                                anchors.top: parent.top; anchors.topMargin: 20
                                anchors.left: parent.left; anchors.right: parent.right
                                property string colorText: "#c9c9c9"; id: sun
                                Text {
                                    id: weekSunText
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"; font.pixelSize: 32
                                    text: "1"; font.bold: true
                                    color: sun.colorText
                                }
                                Text {
                                    anchors.top: weekSunText.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.family: "fontRoboto"; font.pixelSize: 32
                                    text: "ВС"; color: sun.colorText
                                }
                            }

                            Column { // Для записей
                                id: columnSun; anchors.topMargin: 120; spacing: 10
                                anchors.left: parent.left; anchors.top: parent.top;
                                anchors.right: parent.right; anchors.bottom: parent.bottom
                            }

                            CustomBorder{
                                rBorderwidth: 2
                                lBorderwidth: 2
                                color: "#f9f9f9"
                            }
                        }
                        Rectangle {
                            id: daySelectRec;
                            visible: false;
                            color: "white"
                            anchors.fill: parent
                            ListView{
                                anchors.fill: parent; clip: true;
                                delegate: Rectangle{
                                    id: item
                                    anchors.margins: 15; height: status == "Выполнен" ? txt1.height * 7 : txt1.height * 5;
                                    Rectangle{anchors.bottom: item.bottom; anchors.topMargin: 5; anchors.bottomMargin: 5; width: parent.width; height: 1; color: "#66000000"}
                                    anchors.left: parent.left; anchors.right: parent.right;
                                    Text{
                                        anchors.top: parent.top
                                        anchors.topMargin: 5
                                        id: txt1; width: parent.width
                                        anchors.left: parent.left;
                                        font.pointSize: 18; font.family:"fontRoboto"
                                        text: (parseInt(index) + 1)  + ") " + country
                                    }
                                    Text {
                                        id: txt2; clip: true; width: parent.width / 5;
                                        anchors.top: txt1.bottom; anchors.left: parent.left;
                                        font.pointSize: 18; font.family:"fontRoboto"
                                        text: "Адресс ПП: "; color: "#bcb6bd"
                                    }
                                    Text {
                                        id: txt2_1; clip: true; width: parent.width / 2; text: adress
                                        anchors.top: txt1.bottom; anchors.left: txt2.right;
                                        font.pointSize: 18; font.family:"fontRoboto"
                                    }
                                    Text {
                                        id: txt3; clip: true
                                        width: parent.width / 5;
                                        anchors.top: txt2.bottom; anchors.left: parent.left;
                                        font.pointSize: 18; font.family:"fontRoboto"
                                        text: "Время: "; color: "#bcb6bd"
                                    }
                                    Text {
                                        id: txt3_1; clip: true
                                        width: parent.width / 2;
                                        anchors.top: txt2.bottom; anchors.left: txt3.right;
                                        font.pointSize: 18; font.family:"fontRoboto"
                                        text: time
                                    }
                                    Text {
                                        id: txt4; clip: true
                                        width: parent.width / 5;
                                        anchors.top: txt3.bottom; anchors.left: parent.left;
                                        font.pointSize: 18; font.family:"fontRoboto"
                                        text: "Состояние: "; color: "#bcb6bd"
                                    }
                                    Text {
                                        id: txt4_1; clip: true
                                        width: parent.width / 2;
                                        anchors.top: txt3.bottom; anchors.left: txt4.right;
                                        font.pointSize: 18; font.family:"fontRoboto"
                                        text: status; color: status == "Выполнен" ? "#369636" : "#b44"
                                    }
                                    Text {
                                        visible: status == "Выполнен"
                                        id: txt5; clip: true
                                        width: parent.width / 5;
                                        anchors.top: status == "Выполнен" ? txt4.bottom : txt2.bottom; anchors.left: parent.left;
                                        font.pointSize: 18; font.family:"fontRoboto"
                                        text: "Пошлина: "; color: "#bcb6bd"
                                    }
                                    Text {
                                        id: txt5_1; clip: true
                                        width: parent.width / 2;
                                        anchors.top: status == "Выполнен" ? txt4.bottom : txt2.bottom; anchors.left: txt5.right;
                                        font.pointSize: 18; font.family:"fontRoboto"
                                        text: poshlina
                                    }
                                    Text {
                                        visible: status == "Выполнен"
                                        id: txt6; clip: true
                                        width: parent.width / 5;
                                        anchors.top: status == "Выполнен" ? txt5.bottom : txt3.bottom; anchors.left: parent.left;
                                        font.pointSize: 18; font.family:"fontRoboto"
                                        text: "Комментарий: "; color: "#bcb6bd"
                                    }
                                    Text {
                                        visible: status == "Выполнен"
                                        id: txt6_1; clip: true
                                        width: parent.width / 2;
                                        anchors.top: status == "Выполнен" ? txt5.bottom : txt3.bottom; anchors.left: txt6.right;
                                        font.pointSize: 18; font.family:"fontRoboto"
                                        text: comment
                                    }
                                }
                                model: ListModel{id:listModel}

                            }
                        }

                    }
                    Rectangle{
                        id: calendar;
                        anchors.fill: parent;
                        visible: false
                        Map{
                            anchors.fill: parent;
                        }
                    }
                }

                SequentialAnimation{ // Анимация для календаря
                    id: selectDate
                    NumberAnimation{
                        target: calendarPart
                        properties: "opacity, scale"
                        from: 1; to: 0.4;
                        duration: 100
                    }

                    NumberAnimation{
                        target: calendarPart
                        properties: "opacity, scale"
                        from: 0.4; to: 1;
                        duration: 100
                    }
                }
            }

            Rectangle { //Правая полоска от левой панели
                id: rightBorderOnLeftPanel
                color: "#f9f9f9"; width: 2
                height: parent.height; anchors.right: leftPanel.right
            }
            Rectangle { //Полоска сверху
                width: parent.width; color: "#f9f9f9"
                height: 3; y: 79
                anchors.left: parent.left
            }

        }

    }

    DropShadow {
        anchors.fill: recBG
        horizontalOffset: 1
        verticalOffset: 1
        radius: 8
        samples: 10
        source: recBG
        color: "black"
    }

    Profile{
        id: prof
        scale: 0; opacity: 0
        anchors.fill: parent;
    }
    NumberAnimation{
        id: closeProf
        target: prof
        properties: "opacity, scale"
        from: 1; to: 0;
        duration: 200
    }
    NumberAnimation{
        id: openProf
        target: prof
        properties: "opacity, scale"
        from: 0; to: 1;
        duration: 200
    }

    function editWeekList() {
        var weekDay = 0;
        var tomorrow = new Date(GlobalVariables.dataFirst);
        tomorrow.setDate(tomorrow.getDate()+1);
        weekMonText.text = GlobalVariables.dataFirst.getDate();
        weekTueText.text = tomorrow.getDate();
        tomorrow.setDate(tomorrow.getDate()+1);
        weekWedText.text = tomorrow.getDate();
        tomorrow.setDate(tomorrow.getDate()+1);
        weekThuText.text = tomorrow.getDate();
        tomorrow.setDate(tomorrow.getDate()+1);
        weekFriText.text = tomorrow.getDate();
        tomorrow.setDate(tomorrow.getDate()+1);
        weekSatText.text = tomorrow.getDate();
        weekSunText.text = GlobalVariables.dataSecond.getDate();
        var masMount = ["Янв", "Фев", "Мар", "Апр", "Май", "Июнь", "Июль", "Авг", "Сен", "Окт", "Ноя", "Дек"]
        var data1 = GlobalVariables.dataFirst;
        var data2 = GlobalVariables.dataSecond;
        textNowWeek.text = masMount[data1.getMonth()] + " " + data1.getDate() + ", " + data1.getFullYear() + " - "
                + masMount[data2.getMonth()] + " " + data2.getDate() + ", " + data2.getFullYear();
        updatePainitg();
    }

    function updatePainitg(){
        weekSat.color = weekFri.color = weekThu.color = weekWed.color = weekTue.color = weekMon.color = weekSun.color = "white";
        sat.colorText = fri.colorText = thu.colorText = wed.colorText = tue.colorText = mon.colorText = sun.colorText = "#c9c9c9";
        switch(GlobalVariables.curr_now.getDay()){
        case 0: weekSun.color = "#fbfbfb"; sun.colorText = "#00867c"; break;
        case 1: weekMon.color = "#fbfbfb"; mon.colorText = "#00867c"; break;
        case 2: weekTue.color = "#fbfbfb"; tue.colorText = "#00867c"; break;
        case 3: weekWed.color = "#fbfbfb"; wed.colorText = "#00867c"; break;
        case 4: weekThu.color = "#fbfbfb"; thu.colorText = "#00867c"; break;
        case 5: weekFri.color = "#fbfbfb"; fri.colorText = "#00867c"; break;
        case 6: weekSat.color = "#fbfbfb"; sat.colorText = "#00867c"; break;
        }
    }

    //Запрос к БД, и обновления нв странице календаря
    function updateRecords(){
        network.sendingTakeShedule(GlobalVariables.dataFirst.getDate() +
                                   " " + (GlobalVariables.dataFirst.getMonth() + 1) +
                                   " " + GlobalVariables.dataFirst.getFullYear(), userName);
    }

    function addRecord(){
        if (textAdd.text == "Выбор времени") {
            textIconAdd.text = "\uf057";
            textAdd.text = "Отмена";
        }
        else {
            textIconAdd.text = "\uf055";
            textAdd.text = "Выбор времени";
        }
    }

    function setRecord(){
        if (!textInputAutoNomer.text) {
            textInputAutoNomerPlacholder.color = "#f1765b"; return;
        }
        else textInputAutoNomerPlacholder.color = "#787878";
        if (!textInputPhoneNumber.text) {
            textInputPhoneNumberPlacholder.color = "#f1765b"; return;
        }
        else textInputPhoneNumberPlacholder.color = "#787878";
        if (!textInputTime.text) {
            textInputTimePlacholder.color = "#f1765b"; return;
        }
        else textInputTimePlacholder.color = "#787878";
        var dateStr = new Date(customCalendar.selectedDate);
        dateStr.setHours(textInputTime.text.split(':')[0]);
        var masMount = ["Янв", "Фев", "Мар", "Апр", "Май", "Июнь", "Июль", "Авг", "Сен", "Окт", "Ноя", "Дек"]

        dateStr.setMinutes(textInputTime.text.split(':')[1] === undefined ? 0 : textInputTime.text.split(':')[1]);

        var dateStrList = dateStr
        console.log(dateStrList);
        network.sendingSetRecord(textInputAutoNomer.text, textInputPhoneNumber.text, dateStrList.getFullYear() + " " + (dateStrList.getMonth() + 1) + " " + dateStrList.getDate() + " " + dateStrList.getHours() + " " + dateStrList.getMinutes());
        animanitionAddBack.restart();
        timerUpd.restart();
        textInputAutoNomer.text = ""; textInputPhoneNumber.text = ""; textInputTime.text = "";
    }

    function calendarFill(JsonGet){
        while(GlobalVariables.listObjec.length > 0){//очистка глобального массива с объектами
            GlobalVariables.listObjec.pop().destroy();
        }

        var jsonMessage = JSON.parse(JsonGet);
        var i = 0
        for (var val in jsonMessage["records"]){
            var data = new Date(Date.parse(jsonMessage["records"][val]["time"]));
            var component = Qt.createComponent("CardRecordDay.qml");
            var object;
            switch(data.getDay()){
            case 0: object = component.createObject(columnSun); break;
            case 1: object = component.createObject(columnMon); break;
            case 2: object = component.createObject(columnTue); break;
            case 3: object = component.createObject(columnWed); break;
            case 4: object = component.createObject(columnThu); break;
            case 5: object = component.createObject(columnFri); break;
            case 6: object = component.createObject(columnSat); break;
            }
            var hours = data.getHours().toString().length == 1 ? "0" + data.getHours() : data.getHours();
            var minutes = data.getMinutes().toString().length == 1 ? data.getMinutes() + "0" : data.getMinutes();
            object.textTime = hours + ":" + minutes;
            object.textCar = jsonMessage["records"][val]["nomer"]
            object.iterator = i++
            GlobalVariables.listObjec.push(object);
        }
        var arr = [columnSun.height, columnMon.height, columnTue.height, columnWed.height,
                   columnThu.height, columnFri.height, columnSat.height];
        flckPN.contentHeight = Math.max.apply(null, arr) + 180;
        var masMount = ["Янв", "Фев", "Мар", "Апр", "Май", "Июнь", "Июль", "Авг", "Сен", "Окт", "Ноя", "Дек"]
        network.sendGetRecodDay(GlobalVariables.curr_now.getFullYear() + "-" + (GlobalVariables.curr_now.getMonth()+1) + "-" + GlobalVariables.curr_now.getDate())
    }

    Timer{
        id: timerUpd;
        interval: 1000; running: false; repeat: false;
        onTriggered: {updateRecords(); selectDate.restart();}
    }
    function setDecl1(count_wait, count_success, count_fatal){
        console.log(count_wait + " " + count_success + " " + count_fatal)
        prof.count_wait = count_wait
        prof.count_success = count_success
        prof.count_fatal = count_fatal
        openProf.restart();
    }
    function setRecordDay(count, adress, country, arrivaltime,resultnow,commentfinish, poshlina){
        var list1 = adress.split(",");
        var list2 = country.split(",");
        var list3 = arrivaltime.split(",");
        var list4 = resultnow.split(",");
        var list5 = commentfinish.split(",");
        var list6 = poshlina.split(",");
        listModel.clear();
        var listRus = ["Молдавия", "Румыния", "Венгрия", "Словакия", "Польша", "Беларусь", "Россия", "Крым"]
        var listEng = ["moldova", "roman", "hungary", "slovakia", "poland", "belarus", "russia", "Crimea"]
        for(var i=0;i<parseInt(count);i++){
            var temp = list3[i].split("T");
            if (list4[i] === "success") listModel.append({comment: list5[i], poshlina: list6[i], status: "Выполнен", adress: list1[i], country: listRus[listEng.indexOf(list2[i])], time: temp[0] + " " + temp[1]})
            else listModel.append({comment: "", poshlina: "",status: "Ожидает", adress: list1[i], country: listRus[listEng.indexOf(list2[i])], time: temp[0] + " " + temp[1]})
        }
    }

    Connections {
        target: network
        onRecordsWeek:{
            calendarFill(message);
        }
        onSetCount: {
            setDecl1(count_wait, count_success, count_fatal);
        }
        onSetRecordDay: {
            setRecordDay(count, adress, country, arrivaltime,resultnow,commentfinish, poshlina)
        }
    }
}

