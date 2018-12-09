import QtQuick 2.9
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "GlobalVariables.js" as GlobalVariables
import "button"

Rectangle {
    id: rootAdd
    //Нижнее меню
    Item{
        id: menuAdd
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 80

        Rectangle{
            color: "#2b2e35"
            anchors.fill: parent
        }

        MButton{
            id: toolAddQueue
            anchors.left: parent.left
            width: 100; height: 80
            text: "\uf073"
            font.pointSize: 42
            font.family: "fontawesome"
            bottomButton: true
            colorText: "white"
            select: true
            onClicked: selectMenu(2)
        }
        MButton{
            id: toolAddDecor
            anchors.left: toolAddQueue.right
            width: 100; height: 80
            text: "\uf06e"
            font.pointSize: 42
            font.family: "fontawesome"
            bottomButton: true
            colorText: "white"
            onClicked: selectMenu(1)
        }
        MButton{
            id: toolAddItem
            anchors.left: toolAddDecor.right
            width: 100; height: 80
            text: "\uf055"
            font.pointSize: 42
            font.family: "fontawesome"
            bottomButton: true
            colorText: "white"
            onClicked: selectMenu(3)
        }
        MButton{
            id: toolAddComment
            anchors.left: toolAddItem.right
            width: 100; height: 80
            text: "\uf075"
            font.pointSize: 42
            font.family: "fontawesome"
            bottomButton: true
            colorText: "white"
            onClicked: selectMenu(4)
        }

    }

    //Очередь
    Item{
        anchors.top: parent.top; anchors.bottom: menuAdd.top
        anchors.left: parent.left; anchors.right: parent.right
        //основа
        Rectangle {
            id: recBG; anchors.fill: parent

            color: { //При инициализации
                editWeekList();
                updateRecords();
                otdelText.text = "Отдел №" + numberBranch;
                return "white"
            }

            Item { // Товар
                anchors.fill: parent
                id: tovar
                ItemDecl{id: model; anchors.fill: parent}
            }

            Item { //Комментарии
                anchors.fill: parent
                id: coomment
                Rectangle{anchors.fill: parent; color: "red"}
                TextArea{
                    id: txtar
                    anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
                    height: parent.height / 2; font.pixelSize: 48; wrapMode: Text.WordWrap
                    Text{
                        anchors.fill: parent; anchors.margins: 5
                        visible: !txtar.text
                        text: "Комментарий к заявке"
                        font.pixelSize: 48
                    }
                }
                Tmb{
                    id: one
                    anchors.top: txtar.bottom; anchors.left: parent.left; width: parent.width/2; height: parent.height / 6
                    text1: "ЧЧ"
                    validator: IntValidator{bottom: 0; top: 23;}
                }
                Tmb{
                    id: two
                    anchors.top: txtar.bottom; anchors.left: one.right; width: parent.width/2; height: parent.height / 6
                    text1: "МН"
                    validator: IntValidator{bottom: 0; top: 59;}
                }
                Rectangle{
                    color: "white"; id: top
                    anchors.top: one.bottom; anchors.left: parent.left; anchors.right: parent.right; height: 80;
                    Text{
                        id: needOpl; anchors.fill: parent; anchors.margins: 10; text: "К оплате: ";
                        font.pixelSize: 48
                    }
                }
                BtnAdd{
                    id: cancel; text1: "Отменить заказ"
                    anchors.left: parent.left; anchors.top: top.bottom; width: parent.width/2; anchors.bottom: parent.bottom
                    onClicked: zakaz("1");
                }
                BtnAdd{
                    id: success; text1: "Подтвердить заказ"
                    anchors.left: cancel.right; anchors.top: top.bottom; width: parent.width/2; anchors.bottom: parent.bottom
                    onClicked: zakaz("2");
                }
            }

            Item { //Расписание
                id: road
                anchors.fill: parent
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
                            visible: false;
                            Button{
                                id: buttonAddInRect
                                width: parent.width; height: 80
                                Rectangle{
                                    anchors.fill: parent; color: "#fafafa";
                                    Item{
                                        anchors.centerIn: parent
                                        height: textIconAdd.height; width: textIconAdd.width + textAdd.width
                                        Text{
                                            id: textIconAdd
                                            font.family: "fontawesome"
                                            font.pixelSize: 32
                                            text: "\uf055"; color: "#787878"
                                        }
                                        Text{
                                            id: textAdd
                                            anchors.left: textIconAdd.right; anchors.leftMargin: 10
                                            anchors.verticalCenter: textIconAdd.verticalCenter
                                            font.family: "fontRoboto";font.pixelSize: 32
                                            text: "Добавить"; color: "#787878"
                                        }
                                    }
                                }
                                Rectangle{
                                    anchors.top: parent.top; height: 2; width: parent.width; color: "#f5f5f5"
                                }

                                onClicked: {
                                    addRecord();
                                    if (buttonAdd.height == 80) animanitionAdd.restart();
                                    else animanitionAddBack.restart();
                                }
                            }
                            Rectangle{
                                id: rectAddField;
                                anchors.top: buttonAddInRect.bottom;
                                height: 80; anchors.left: parent.left; anchors.right: parent.right
                                TextInput {
                                    id: textInputAutoNomer; anchors.leftMargin: 10
                                    anchors.left: parent.left; anchors.right: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 42; font.family: "fontRoboto";
                                    Text{
                                        id: textInputAutoNomerPlacholder
                                        text: "Введите номер машины"; color: "#787878";
                                        font.pixelSize: 36; font.family: "fontRoboto"
                                        visible: !textInputAutoNomer.text
                                    }
                                }
                            }
                            Rectangle{
                                id: rectAddFieldPhoneNumber;
                                anchors.top: rectAddField.bottom;
                                height: 80; anchors.left: parent.left; anchors.right: parent.right
                                TextInput {
                                    id: textInputPhoneNumber; anchors.leftMargin: 10
                                    anchors.left: parent.left; anchors.right: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 42; font.family: "fontRoboto";
                                    Text{
                                        id: textInputPhoneNumberPlacholder
                                        text: "Введите номер телефона"; color: "#787878";
                                        font.pixelSize: 36; font.family: "fontRoboto"
                                        visible: !textInputPhoneNumber.text
                                    }
                                }
                            }
                            Rectangle{
                                id: rectAddFieldTime;
                                anchors.top: rectAddFieldPhoneNumber.bottom;
                                height: 80; anchors.left: parent.left; anchors.right: parent.right
                                TextInput {
                                    id: textInputTime;
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left; anchors.right: parent.right
                                    anchors.leftMargin: 10
                                    font.pixelSize: 42; font.family: "fontRoboto";
                                    validator: RegExpValidator { regExp: /^(?:(?:([01]?\d|2[0-3]):)?([0-5]?\d))$/ }
                                    Text{
                                        id: textInputTimePlacholder
                                        text: "чч:мм"; color: "#787878";
                                        font.pixelSize: 36; font.family: "fontRoboto"
                                        visible: !textInputTime.text
                                    }
                                }
                            }
                            Button{ //Сделать и удалить комментарий
                                id: buttomAddEnter; width: parent.width; height: 80
                                anchors.top: rectAddFieldTime.bottom
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
                                            text: "Добавить в очередь"; color: "white"
                                        }

                                    }
                                }
                                onClicked: {
                                    setRecord();
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
                                Item {
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
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            width: parent.width / 3
                            CustomBorder{
                                lBorderwidth: 2
                                rBorderwidth: 2
                                color: "#f7f7f7"
                            }
                        }
                        Rectangle { //Третья часть верхней панель
                            id: rightPanelTopThird
                            anchors.left: rightPanelTopSecond.right
                            anchors.top: parent.top; anchors.bottom: parent.bottom
                            width: parent.width / 3
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
                            clip: true
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
            Item { //Просмотр декларации
                id: rootRec
                visible: false; clip: true
                anchors.fill: parent
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
                                text: root.grap[0]
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
                                text: root.grap[1]
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
                                text: root.grap[3]
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
                                text: root.grap[4]
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
                                text: root.grap[5]
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
                                text: root.grap[6]
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
                                text: root.grap[7]
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
                                text: root.grap[8]
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
                                text: root.grap[9]
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
                                text: root.grap[10]
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
                                text: root.grap[11]
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
                                text: root.grap[12]
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
                                text: root.grap[13]
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
                                text: root.grap[14]
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
                                text: root.grap[15]
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
                                text: root.grap[16]
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
                                text: root.grap[17]
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
                                text: root.grap[18]
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
                                text: root.grap[19]
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
                                text: root.grap[20]
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
                                text: root.grap[21]
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
                                text: root.grap[22]
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
                                text: root.grap[23]
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
                                text: root.grap[24]
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
                                text: root.grap[25]
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
                                text: root.grap[26]
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
                                text: root.grap[27]
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
                                text: root.grap[28]
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
                                text: root.grap[29]
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
                                text: root.grap[30]
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
                            text: root.grap[31]
                        }
                    }
                    }
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

    }

    function zakaz(number){
        var hhmm = one.text + ":" + two.text
        if (number === "1"){
            console.log("Отменить заказ");
            network.setRecordReport(root.username, root.oplata, "canсell", txtar.text, tovar_count, hhmm);
        }
        else {
            console.log("Подтвердить заказ");
            network.setRecordReport(root.username, root.oplata, "success", txtar.text, tovar_count, hhmm);
        }
        selectMenu(1);
    }

    //Изменение состояния активности
    function selectMenu(mButtonSelect){
        toolAddQueue.select = false; toolAddDecor.select = false
        toolAddItem.select = false; toolAddComment.select = false
        switch (mButtonSelect){
        case 1:
            toolAddDecor.select = true
            road.visible = false; rootRec.visible = true; coomment.visible = false; tovar.visible = false;
            break
        case 2:
            toolAddQueue.select = true
            road.visible = true; rootRec.visible = false; coomment.visible = false; tovar.visible = false;
            break
        case 3:
            toolAddItem.select = true;
            road.visible = false; rootRec.visible = false; coomment.visible = false; tovar.visible = true;
            break
        case 4:
            toolAddComment.select = true
            var allPrice = 0;
            console.log(root.tovar_count)
            for (var i = 0; i < root.tovar_count; i++){
                var json_temp = JSON.parse(root.tovars[i])
                var addPrice = 0;
                var full_price = parseInt(json_temp["graph38"]); var poshlina = parseInt(json_temp["full"])
                addPrice = (poshlina * full_price) / 100;
                full_price += addPrice; addPrice += (full_price * 20) / 100
                allPrice += addPrice
            }
            root.oplata = allPrice;
            needOpl.text = "К оплате: " + allPrice;
            road.visible = false; rootRec.visible = false; coomment.visible = true; tovar.visible = false;
            break

        }
    }

    //Запрос к БД, и обновления нв странице календаря
    function updateRecords(){
        console.log(GlobalVariables.dataFirst.getDate() + "," + (GlobalVariables.dataFirst.getMonth() + 1) +
                    "," + GlobalVariables.dataFirst.getFullYear());
        network.sendingTakeShedule(GlobalVariables.dataFirst.getDate() +
                                   " " + (GlobalVariables.dataFirst.getMonth() + 1) +
                                   " " + GlobalVariables.dataFirst.getFullYear(), username);
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

    function selectNowRecord(textCar){
        console.log(textCar);
        network.getRecord(textCar);
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
    }

    function addRecord(){
        if (textAdd.text == "Добавить") {
            textIconAdd.text = "\uf057";
            textAdd.text = "Отмена";
        }
        else {
            textIconAdd.text = "\uf055";
            textAdd.text = "Добавить";
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
        dateStr.setMinutes(textInputTime.text.split(':')[1] === undefined ? 0 : textInputTime.text.split(':')[1]);

        var dateStrList = dateStr
        console.log(dateStrList);
        network.sendingSetRecord(textInputAutoNomer.text, textInputPhoneNumber.text, dateStrList.getFullYear() + " " + (dateStrList.getMonth() + 1) + " " + dateStrList.getDate() + " " + dateStrList.getHours() + " " + dateStrList.getMinutes());
        animanitionAddBack.restart();
        timerUpd.restart();
        textInputAutoNomer.text = ""; textInputPhoneNumber.text = ""; textInputTime.text = "";
    }
    function declGet(message){
        var jsonMessage = JSON.parse(message);
        console.log(jsonMessage["files"])
        console.log(jsonMessage["username"])
        selectMenu(1)
    }

    function declSet(message){
        var json_temp = JSON.parse(message)
        var list = ["Декларация", "Отправитель / Экспортер", "Всего мест", "Получатель", "Лицо, ответственное за финансовое урегулирование",
                "Страна перв. назн./послед. отправил", "Торговая страна / страна производства", "ЕСП", "Декларант/Представитель",
                "Страна отправления/экспорта", "Код страны отправления/экспорта", "Страна происхождения", "страна назначения",
                "Код страны назначения", "Идентификация и страна регистрации транспортного средства при отправлении/прибытии",
                "Контейнер", "Условия поставки", "Идентификация и страна регистрации активного транспортного средства на границе",
                "Валюта и общая сумма по счету", "Курс валюты", "Характер сделки", "Вид транспорта на границе",
                "Вид транспорта внутри страны", "Место погрузки/разгрузки", "Финансовые и банковские сведения", "Таможенный орган выезда/въезда",
                "Местонахождение товара", "Реквизиты склада", "Принципал", "Гарантия не действительна для",
                "Таможенный орган (и страна) назначения", "Дата"];
        for (var i=0; i<32;i++){
            grap[i] = json_temp[list[i]]
            console.log(list[i] + " " + i + " " + grap[i]);
            setText(i);
        }
        root.tovar_count = 0;
        var n = parseInt(json_temp["count"])
        for (i=0; i<n;i++){
            root.tovars[root.tovar_count] = "{\"code_tovar\": \"" + json_temp["tovar" + i]["Код товара"] + "\", \"graph31\": \"" + json_temp["tovar" + i]["Описание"] + "\", \"graph34\": \"" + json_temp["tovar" + i]["Код страны происх."] +
                    "\", \"graph35\": \"" + json_temp["tovar" + i]["Вес брутто"] + "\",\"graph36\": \"" + json_temp["tovar" + i]["преферанция"] + "\", \"graph37\": \"" + json_temp["tovar" + i]["нетто"] + "\", \"graph38\": \"" + json_temp["tovar" + i]["цена"] +
                    "\", \"pref\": \"" + json_temp["tovar" + i]["Пошлина"] + "\", \"full\": \"" + json_temp["tovar" + i]["Пошлина"] + "\"}";
            root.tovar_count += 1
        }
        model.modelFill();
        console.log("count tovar" + json_temp["count"]);
    }

    function setText(i){
        switch(i){
        case 1: rec1Txt1.text = grap[i]; break; case 2: rec2Txt1.text = grap[i]; break
        case 3: rec3Txt1.text = grap[i]; break; case 4: rec4Txt1.text = grap[i]; break
        case 5: rec5Txt1.text = grap[i]; break; case 6: rec6Txt1.text = grap[i]; break
        case 7: rec7Txt1.text = grap[i]; break; case 8: rec8Txt1.text = grap[i]; break
        case 9: rec9Txt1.text = grap[i]; break; case 10: rec10Txt1.text = grap[i]; break
        case 11: rec11Txt1.text = grap[i]; break; case 12: rec12Txt1.text = grap[i]; break
        case 13: rec13Txt1.text = grap[i]; break; case 14: rec14Txt1.text = grap[i]; break
        case 15: rec15Txt1.text = grap[i]; break; case 16: rec16Txt1.text = grap[i]; break
        case 17: rec17Txt1.text = grap[i]; break; case 18: rec18Txt1.text = grap[i]; break
        case 19: rec19Txt1.text = grap[i]; break; case 20: rec20Txt1.text = grap[i]; break
        case 21: rec21Txt1.text = grap[i]; break; case 22: rec22Txt1.text = grap[i]; break
        case 23: rec23Txt1.text = grap[i]; break; case 24: rec24Txt1.text = grap[i]; break
        case 25: rec25Txt1.text = grap[i]; break; case 26: rec26Txt1.text = grap[i]; break
        case 27: rec27Txt1.text = grap[i]; break; case 28: rec28Txt1.text = grap[i]; break
        case 29: rec29Txt1.text = grap[i]; break; case 30: rec30Txt1.text = grap[i]; break
        case 31: rec31Txt1.text = grap[i]; break;
        }
    }

    Timer{
        id: timerUpd;
        interval: 1000; running: false; repeat: false;
        onTriggered: {updateRecords(); selectDate.restart();}
    }

    Connections {
        target: network
        onRecordsWeek:{
            calendarFill(message);
        }
        onRecordsDecl: {
            declGet(message);
        }
        onSetDecl1: {
            declSet(message);
        }

    }

}
