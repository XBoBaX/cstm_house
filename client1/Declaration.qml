import QtQuick 2.0
import QtQuick.Controls 2.2
import "GlobalDecl.js" as GlobalDecl
import "button"

Item { //Добавление транспортных средств
    id: vehicle
    anchors.fill: parent
    property int idBtnSelected: 0
    property string grpSelected: "Декларация"
    property string textInpGr : "Декларация"
    property string btnGrap

    Rectangle{
        id: md_2_navigation; anchors.top: parent.top; anchors.bottom: parent.bottom;
        width: parent.width / 3
        color: "white"
        clip: true
        Flickable{
            anchors.fill: parent
            contentHeight: columnButton.height
            Column{
                id: columnButton
                width: parent.width
                Repeater{
                    model: ["Декларация", "Отправитель/Экспортер", "Формы", "Отгрузочные спецификации", "Всего товаров", "Всего мест", "Справочный номер", "Получатель", "Лицо, ответственное за финансовое урегулирование", "Страна перв. назн./послед. отправил",
                        "Торговая страна / Страна производства", "Сведения о стоимости", "ЕСП", "Декларант/Представитель", "Страна отправления/экспорта", "Код страны отправления/экспорта", "Страна происхождения", "Страна назначения и код", "Страна назначения", "Идентификация и страна регистрации транспортного средства при отправлении/прибытии",
                        "Контейнер", "Условия поставки", "Идентификация и страна регистрации активного транспортного средства на границе", "Валюта и общая сумма по счету", "Курс валюты", "Характер сделки", "Вид транспорта на границе", "Вид транспорта внутри страны", "Место погрузки/разгрузки",
                        "Финансовые и банковские сведения", "Финансовые и банковские сведения(п)", "Таможенный орган выезда/въезда", "Местонахождение товаров", "Грузовые места и описание товаров", "Товар N", "Код товара", "Код страны происхождения", "Вес брутто (кг)", "Преференции", "Процедура", "Вес нетто (кг)", "Квота", "Общая декларация/Предварительный документ",
                        "Дополнительные единицы измерения", "Цена товара", "Метод определения стоимости", "Дополнительная информация", "Корректировка", "Статистическая стоимость", "Начисление платежей", "Отсрочка платежей", "Реквизиты склада", "Принципал", "Предполагаемые органы", "Гарантия не действительна для..", "Таможенный орган (и страна) назначения",
                        "Место и дата", "Перейти к товарам"]
                    Column{
                        property alias selected: rec.selected
                        property int indexed: 0
                        width: parent.width;
                        ButtonNavigationForm {
                            id: rec
                            onNameChanged: {
                                if (index == 57) exit = true
                            }

                            onSelectedChanged: {
                                if (selected) openHelp.restart()
                                else closeHelp.restart()
                            }
                            visible: if (index == 2 || index == 3 || index == 4 || index == 6 || index == 11 || index == 15 || index == 18  || (index >= 33 && index <= 50) || index == 53|| index == 56) return false;
                            else true
                            name: {
                                if (index < 15) return "Графа " + (index+1) + ". " + modelData
                                if (index == 15) return "Графа 15б. " + modelData
                                if (index == 16 || index == 17) return "Графа " + index + ". " + modelData
                                if (index == 18) return "Графа 17б. " + modelData
                                if (index > 18 && index < 30) return "Графа " + (index-1) + ". " + modelData
                                if (index == 30) return "Графа 28п. " + modelData
                                if (index > 29) return "Графа " + (index-2) + ". " + modelData
                            }
                        }
                        Rectangle{
                            id: recHelp
                            height: 0; clip: true
                            anchors.left: parent.left; anchors.right: parent.right
                            Text {
                                id: helpText
                                anchors.left: parent.left; anchors.right: parent.right
                                anchors.margins: 10; color: "#787776"
                                font.pointSize: 18; font.family: "fontRoboto"
                                verticalAlignment: Text.AlignVCenter
                                elide: Text.ElideRight;
                                wrapMode: TextEdit.Wrap; text: GlobalDecl.mas[indexed]
                            }
                        }

                        NumberAnimation {
                            id: openHelp;
                            target: recHelp
                            property: "height"
                            duration: 200
                            from: 0; to: recHelp.childrenRect.height
                            easing.type: Easing.InOutQuad
                        }
                        NumberAnimation {
                            id: closeHelp;
                            target: recHelp
                            property: "height"
                            duration: 200
                            from: recHelp.childrenRect.height; to: 0
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }

        }
    }
    Rectangle{ //Правая часть
        id: md_2;
        anchors.top: parent.top; anchors.bottom: parent.bottom;
        anchors.left: md_2_navigation.right; anchors.right: parent.right
        Rectangle{
            id: recTxtEdt
            anchors.left: parent.left; anchors.right: parent.right; anchors.top: parent.top;
            height: 240;
            Flickable{
                id: flick
                anchors.fill: parent; clip: true
                contentHeight: textEditInput.paintedHeight

                function ensureVisible(r){
                    if (contentX >= r.x) contentX = r.x;
                    else if (contentX+width <= r.x+r.width)contentX = r.x+r.width-width;
                    if (contentY >= r.y) contentY = r.y;
                    else if (contentY+height <= r.y+r.height) contentY = r.y+r.height-height;
                }

                TextEdit{
                    id: textEditInput
                    width: flick.width
                    height: flick.height
                    font.family: "fontRoboto"; font.pixelSize: 28
                    wrapMode: TextEdit.Wrap
                    onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
                    text: textInpGr
                    onTextChanged: {editGrap(grpSelected)}
                    Text {
                        id: placholderInput; visible: !textEditInput.text
                        font.family: "fontRoboto"; font.pixelSize: 28; color: "#787878"
                    }
                }
            }
            Rectangle{
                anchors.left: parent.left; anchors.bottom: parent.bottom; anchors.right: parent.right
                height: 3; color: "#f8f8f8"
            }
        }
        Rectangle{
            anchors.top: recTxtEdt.bottom; anchors.bottom: parent.bottom
            anchors.left: parent.left; anchors.right: parent.right
            color: "#fbfbfb"; clip: true
            Flickable{
                id: flickDcklr
                anchors.fill: parent;
                contentHeight: dcklView.height
                Item{
                    id: dcklView;
                    height: childrenRect.height
                    Rectangle { // Пункт 3
                        id: pynkt3
                        anchors.left: parent.left; anchors.top: parent.top
                        height: 850; width: 50; border.width: 2;
                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 26; font.family: "fontRoboto"
                            text: "Экземпляр для отправителя/экспортера"
                            rotation: -90
                        }
                    }
                    Rectangle { // Пункт 8
                        id: pynkt8
                        anchors.left: pynkt3.right; anchors.top: parent.top
                        height: 850; width: 50; border.width: 2;
                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 26; font.family: "fontRoboto"
                            text: "Экземпляр для получателя"
                            rotation: -90
                        }
                    }
                    Rectangle { //2
                        id: grap2; border.width: 1;
                        anchors.top: pynkt3.top; anchors.left: pynkt8.right;
                        height: 200; width: (md_2.width / 2) - 100;
                        Text {
                            id: grap2text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap2;
                            color: {
                                if (text == "Отправитель/Экспортер") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //1
                        id: grap1; border.width: 2
                        anchors.top: pynkt3.top; anchors.left: grap2.right
                        height: 100; width: md_2.width / 5; color: "#e8e8e8"
                        Text {
                            id: grap1text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap1;
                            color: {
                                if (text == "Декларация") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //3
                        id: grap3; border.width: 1
                        anchors.top: grap1.bottom; anchors.left: grap2.right
                        height: 50; width: (md_2.width / 5) / 2
                        Text {
                            id: grap3text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "1/" + (tovars.length+1);
                            color: {
                                if (text == "Формы") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //4
                        id: grap4; border.width: 1
                        anchors.top: grap1.bottom; anchors.left: grap3.right
                        height: 50; width: (md_2.width / 5) / 2
                        Text {
                            id: grap4text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "0";
                            color: {
                                if (text == "Отгрузочные спецификации") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //5
                        id: grap5; border.width: 1
                        anchors.top: grap4.bottom; anchors.left: grap2.right
                        height: 50; width: (md_2.width / 5) / 2
                        Text {
                            id: grap5text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: tovars.length;
                            color: {
                                if (text == "Всего товаров") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //6
                        id: grap6; border.width: 1
                        anchors.top: grap4.bottom; anchors.left: grap5.right
                        height: 50; width: ((md_2.width / 5) / 2) + 50
                        Text {
                            id: grap6text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap6;
                            color: {
                                if (text == "Всего мест") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //7
                        id: grap7; border.width: 1
                        anchors.top: grap4.bottom; anchors.left: grap6.right
                        height: 50; width: (md_2.width / 2) - (md_2.width / 5) - 50
                        Text {
                            id: grap7text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap7;
                            color: {
                                if (text == "Справочный номер") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //A
                        id: grapA
                        anchors.top: grap1.top; anchors.bottom: grap7.top
                        anchors.left: grap1.right; border.width: 1
                        width: (md_2.width / 2) - (md_2.width / 5);
                        Text {
                            id: grapAtext; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "Орган отправления/экспорта/назначения (Таможеник)";
                            color: {
                                if (text == "Орган отправления/экспорта/назначения (Таможеник)") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //8
                        id: grap8; border.width: 1;
                        anchors.top: grap2.bottom; anchors.left: pynkt8.right;
                        height: 200; width: (md_2.width / 2) - 100;
                        Text {
                            id: grap8text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap8;
                            color: {
                                if (text == "Получатель") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //9
                        id: grap9; border.width: 1;
                        anchors.top: grap5.bottom; anchors.left: grap8.right;
                        height: 150; width: (md_2.width / 2);
                        Text {
                            id: grap9text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap9;
                            color: {
                                if (text == "Лицо, ответственное за финансовое урегулирование") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //10
                        id: grap10; border.width: 1
                        anchors.top: grap9.bottom; anchors.left: grap8.right
                        height: 50; width: ((md_2.width / 4) - 50) / 2
                        Text {
                            id: grap10text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap10;
                            color: {
                                if (text == "Стр. перв.назн./ послед. отправил") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //11
                        id: grap11; border.width: 1
                        anchors.top: grap9.bottom; anchors.left: grap10.right
                        height: 50; width: ((md_2.width / 4) - 50) / 2
                        Text {
                            id: grap11text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap11;
                            color: {
                                if (text == "Тор. страна/ Стр. произ.") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //12
                        id: grap12; border.width: 1
                        anchors.top: grap9.bottom; anchors.left: grap11.right
                        height: 50; width: ((md_2.width / 4) - 50)
                        Text {
                            id: grap12text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap12;
                            color: {
                                if (text == "Сведения о стоимости") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //13
                        id: grap13; border.width: 1
                        anchors.top: grap9.bottom; anchors.left: grap12.right
                        anchors.right: grap9.right; height: 50;
                        Text {
                            id: grap13text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap13;
                            color: {
                                if (text == "ЕСП") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //14
                        id: grap14; border.width: 1;
                        anchors.top: grap8.bottom; anchors.left: pynkt8.right;
                        height: 150; width: (md_2.width / 2) - 100;
                        Text {
                            id: grap14text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap14;
                            color: {
                                if (text == "Декларант/Представитель") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //15
                        id: grap15; border.width: 1;
                        anchors.top: grap10.bottom; anchors.left: grap14.right;
                        height: 75; width: (md_2.width / 4);
                        Text {
                            id: grap15text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap15;
                            color: {
                                if (text == "Страна отправителя/экспорта") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //15_1
                        id: grap15_1; border.width: 2;
                        anchors.top: grap10.bottom; anchors.left: grap15.right;
                        height: 75; width: md_2.width / 8;
                        Text {
                            id: grap15_1text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap15_1;
                            color: {
                                if (text == "Код страны отправителя/экспорта") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //17_1
                        id: grap17_1; border.width: 2;
                        anchors.top: grap10.bottom; anchors.left: grap15_1.right;
                        height: 75; width: md_2.width / 8;
                        Text {
                            id: grap17_1text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap17_1;
                            color: {
                                if (text == "Код страны назначачения") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //16
                        id: grap16; border.width: 1;
                        anchors.top: grap15.bottom; anchors.left: grap14.right;
                        height: 75; width: (md_2.width / 4);
                        Text {
                            id: grap16text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap16;
                            color: {
                                if (text == "Страна происхождения") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //17
                        id: grap17; border.width: 1;
                        anchors.top: grap15.bottom; anchors.left: grap16.right;
                        height: 75; width: (md_2.width / 4);
                        Text {
                            id: grap17text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap17;
                            color: {
                                if (text == "Страна назначачения") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //18
                        id: grap18; border.width: 1;
                        anchors.top: grap14.bottom; anchors.left: pynkt8.right;
                        height: 75; width: (md_2.width / 2) - 150;
                        Text {
                            id: grap18text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap18;
                            color: {
                                if (text == "Идентификация и страна регистрации транспортного средства при отправлении/прибытии") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //19
                        id: grap19; border.width: 2;
                        anchors.top: grap14.bottom; anchors.left: grap18.right;
                        height: 75; width: 50;
                        Text {
                            id: grap19text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap19;
                            color: {
                                if (text == "Конт.") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //20
                        id: grap20; border.width: 1;
                        anchors.top: grap16.bottom; anchors.left: grap19.right;
                        anchors.right: grap17.right; height: 75;
                        Text {
                            id: grap20text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap20;
                            color: {
                                if (text == "Условия поставки") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //21
                        id: grap21; border.width: 1;
                        anchors.top: grap18.bottom; anchors.left: pynkt8.right;
                        height: 75; width: (md_2.width / 2) - 100;
                        Text {
                            id: grap21text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap21;
                            color: {
                                if (text == "Идентификация и страна регистрации активного транспортного средства на границе") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //22
                        id: grap22; border.width: 1;
                        anchors.top: grap20.bottom; anchors.left: grap21.right
                        height: 75; width: (md_2.width / 4);
                        Text {
                            id: grap22text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap22;
                            color: {
                                if (text == "Валюта и общая сумма по счету") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //23
                        id: grap23; border.width: 1;
                        anchors.top: grap20.bottom; anchors.left: grap22.right
                        height: 75; width: (md_2.width / 8);
                        Text {
                            id: grap23text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap23;
                            color: {
                                if (text == "Курс валюты") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //24
                        id: grap24; border.width: 1;
                        anchors.top: grap20.bottom; anchors.left: grap23.right
                        height: 75; width: (md_2.width / 8);
                        Text {
                            id: grap24text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap24;
                            color: {
                                if (text == "Характер сделки") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //25
                        id: grap25; border.width: 1;
                        anchors.top: grap21.bottom; anchors.left: pynkt8.right;
                        height: 75; width: ((md_2.width / 2) - 100) / 4;
                        Text {
                            id: grap25text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap25;
                            color: {
                                if (text == "Вид транспорта на границе") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //26
                        id: grap26; border.width: 1;
                        anchors.top: grap21.bottom; anchors.left: grap25.right;
                        height: 75; width: ((md_2.width / 2) - 100) / 4;
                        Text {
                            id: grap26text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap26;
                            color: {
                                if (text == "Вид транспорта внутри страны") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //27
                        id: grap27; border.width: 1;
                        anchors.top: grap21.bottom; anchors.left: grap26.right;
                        height: 75; width: ((md_2.width / 2) - 100) / 2;
                        Text {
                            id: grap27text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.pntAdress + " " + root.selectDay + "." + root.selectMounth + "." + root.selectYear + ". id: " + root.pntId;
                            color: {
                                if (text == "Место погрузки/разгрузки") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //28
                        id: grap28; border.width: 1;
                        anchors.top: grap22.bottom; anchors.left: grap27.right;
                        anchors.right: grap24.right; height: 75;
                        Text {
                            id: grap28text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap28;
                            color: {
                                if (text == "Финансовые и банковские сведения") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //29
                        id: grap29; border.width: 1;
                        anchors.top: grap25.bottom; anchors.left: pynkt8.right;
                        height: 75; width: ((md_2.width / 2) - 100) / 2;
                        Text {
                            id: grap29text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap29;
                            color: {
                                if (text == "Таможенный орган выезда/въезда") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //30
                        id: grap30; border.width: 1;
                        anchors.top: grap25.bottom; anchors.left: grap29.right;
                        height: 75; width: ((md_2.width / 2) - 100) / 2;
                        Text {
                            id: grap30text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap30;
                            color: {
                                if (text == "Местонахождение товара") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //28_2
                        id: grap28_2
                        anchors.top: grap28.bottom; anchors.left: grap30.right;
                        anchors.right: grap28.right; height: 75; border.width: 1;
                        Text {
                            id: grap28_2text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap28_2;
                        }
                    }
                    Rectangle { //31
                        id: grap31
                        anchors.top: pynkt3.bottom; height: 330; border.width: 1;
                        anchors.right: pynkt8.right; anchors.left: pynkt3.left
                        Text {
                            id: grap31text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "Грузовые места и описание товаров";
                            color: {
                                if (text == "Грузовые места и описание товаров") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //31_1
                        id: grap31_1
                        anchors.top: pynkt3.bottom; anchors.left: grap31.right
                        height: 330; width: (md_2.width / 2) + 75;
                        border.width: 1;
                        Text {
                            id: grap31_1text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap31_1;
                            color: {
                                if (text == "Грузовые места и описание товаров. Маркировка и количество - Номера контейнеров - Количество и отличительные особенности") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //32
                        id: grap32
                        anchors.top: pynkt3.bottom; anchors.right: grap31_1.right
                        height: 50; width: 50; border.width: 1
                        Text {
                            id: grap32text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "1";
                            color: {
                                if (text == "Товар №") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //32_2
                        id: grap32_2
                        anchors.top: grap31_1.bottom; anchors.left: grap31.right
                        width: (md_2.width / 2) + (md_2.width / 4); height: 170;
                        border.width: 1;
                    }
                    Rectangle { //33
                        id: grap33
                        anchors.left: grap31_1.right; anchors.right: grap28.right;
                        anchors.top: pynkt3.bottom; height: 70;
                        border.width: 1;
                        Text {
                            id: grap33text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap33;
                            color: {
                                if (text == "Код товара") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //34
                        id: grap34
                        anchors.top: grap33.bottom; anchors.left: grap31_1.right
                        width: grap33.width / 3; height: 70;
                        border.width: 2;
                        Text {
                            id: grap34text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap34;
                            color: {
                                if (text == "Код страны происх.") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //35
                        id: grap35
                        anchors.top: grap33.bottom; anchors.left: grap34.right
                        width: grap33.width / 3; height: 70;
                        border.width: 1;
                        Text {
                            id: grap35text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap35;
                            color: {
                                if (text == "Вес брутто (кг)") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //36
                        id: grap36
                        anchors.top: grap33.bottom; anchors.left: grap35.right
                        width: grap33.width / 3; height: 70;
                        border.width: 1;
                        Text {
                            id: grap36text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap36;
                            color: {
                                if (text == "Преференции") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //37
                        id: grap37
                        anchors.top: grap34.bottom; anchors.left: grap31_1.right
                        width: grap33.width / 3; height: 70;
                        border.width: 2;
                        Text {
                            id: grap37text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap37;
                            color: {
                                if (text == "Процедура") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //38
                        id: grap38
                        anchors.top: grap34.bottom; anchors.left: grap37.right
                        width: grap33.width / 3; height: 70;
                        border.width: 1;
                        Text {
                            id: grap38text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap38;
                            color: {
                                if (text == "Вес нетто (кг)") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //39
                        id: grap39
                        anchors.top: grap34.bottom; anchors.left: grap38.right
                        width: grap33.width / 3; height: 70;
                        border.width: 1;
                        Text {
                            id: grap39text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap39;
                            color: {
                                if (text == "Квота") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //40
                        id: grap40
                        anchors.left: grap31_1.right; anchors.top: grap37.bottom;
                        anchors.right: grap39.right; height: 70;
                        border.width: 1;
                        Text {
                            id: grap40text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap40;
                            color: {
                                if (text == "Общая декларация/Предварительный документ") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //44_1
                        id: grap44_1
                        anchors.top: grap31.bottom;
                        anchors.left: grap44.right; anchors.right: grap45.left
                        height: 170; border.width: 1;
                        Text {
                            id: grap44_1text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap44_1;
                        }
                    }
                    Rectangle { //41
                        id: grap41
                        anchors.top: grap40.bottom; anchors.left: grap31_1.right
                        width: grap33.width / 3; height: 70;
                        border.width: 2;
                        Text {
                            id: grap41text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap41;
                            color: {
                                if (text == "Дополнительные единицы измерения") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //42
                        id: grap42
                        anchors.top: grap40.bottom; anchors.left: grap41.right
                        width: grap33.width / 3; height: 70;
                        border.width: 1;
                        Text {
                            id: grap42text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap42;
                            color: {
                                if (text == "Цена товара") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //43
                        id: grap43
                        anchors.top: grap40.bottom; anchors.left: grap42.right
                        width: grap33.width / 3; height: 70;
                        border.width: 1;
                        Text {
                            id: grap43text; anchors.margins: 5; wrapMode: Text.WordWrap
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap43;
                            color: {
                                if (text == "Метод определения стоимости") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //44
                        id: grap44
                        anchors.top: grap31.bottom;
                        anchors.right: grap31.right; anchors.left: grap31.left
                        height: 170; border.width: 1;
                        Text {
                            id: grap44text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap44;
                            color: {
                                if (text == "Доп. информ./Предст. док./Серт. и разр.") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //45
                        id: grap45
                        anchors.top: grap42.bottom;
                        anchors.left: grap32_2.right; anchors.right: grap43.right
                        height: 70; border.width: 1;
                        Text {
                            id: grap45text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap45;
                            color: {
                                if (text == "Корректировка") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //46
                        id: grap46
                        anchors.top: grap45.bottom; anchors.bottom: grap32_2.bottom
                        anchors.left: grap41.right; anchors.right: grap43.right
                        border.width: 1;
                        Text {
                            id: grap46text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap46;
                            color: {
                                if (text == "Статистическая стоимост") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //47
                        id: grap47
                        anchors.top: grap44.bottom;
                        anchors.left: grap44.left; anchors.right: grap44.right
                        height: 350; border.width: 1;
                        Text {
                            id: grap47text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap47;
                            color: {
                                if (text == "Начисление платежей") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //47_1
                        id: grap47_1
                        anchors.top: grap47.top
                        anchors.left: grap47.right
                        width: ((md_2.width / 2) - 100) / 8; height: 300;
                        border.width: 1;
                        Text {
                            id: grap47_1text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "Вид";
                            color: {
                                if (text == "Вид") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //47_2
                        id: grap47_2
                        anchors.top: grap47.top
                        anchors.left: grap47_1.right
                        width: ((md_2.width / 2) - 100) / 4; height: 300;
                        border.width: 1;
                        Text {
                            id: grap47_2text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "Основа начисления";
                            color: {
                                if (text == "Основа начисления") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //47_3
                        id: grap47_3
                        anchors.top: grap47.top
                        anchors.left: grap47_2.right
                        width: ((md_2.width / 2) - 100) / 4; height: 300;
                        border.width: 1;
                        Text {
                            id: grap47_3text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "Ставка";
                            color: {
                                if (text == "Ставка") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //47_4
                        id: grap47_4
                        anchors.top: grap47.top
                        anchors.left: grap47_3.right
                        width: ((md_2.width / 2) - 100) / 4; height: 300;
                        border.width: 1;
                        Text {
                            id: grap47_4text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "Сумма";
                            color: {
                                if (text == "Сумма") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //47_5
                        id: grap47_5
                        anchors.top: grap47.top
                        anchors.left: grap47_4.right
                        width: ((md_2.width / 2) - 100) / 8; height: 300;
                        border.width: 1;
                        Text {
                            id: grap47_5text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "СП";
                            color: {
                                if (text == "СП") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //47_6
                        id: grap47_6
                        anchors.top: grap47_1.bottom
                        anchors.left: grap47.right; anchors.right: grap47_5.right
                        height: 50;
                        border.width: 1;
                        Text {
                            id: grap47_6text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "Сумма: ";
                            color: {
                                if (text == "Сумма: ") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //48
                        id: grap48
                        anchors.left: grap47_6.right; anchors.top: grap46.bottom;
                        height: 70; width: (md_2.width / 4); border.width: 1;
                        Text {
                            id: grap48text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap48;
                            color: {
                                if (text == "Отсрочка платежей") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //49
                        id: grap49
                        anchors.left: grap48.right; anchors.top: grap46.bottom;
                        height: 70; width: (md_2.width / 4); border.width: 1;
                        Text {
                            id: grap49text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap49;
                            color: {
                                if (text == "Реквизиты склада") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //B
                        id: grapB
                        anchors.top: grap48.bottom; anchors.bottom: grap47_6.bottom
                        anchors.left: grap47_5.right; anchors.right: grap49.right
                        border.width: 1;
                        Text {
                            id: grapBtext; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "Подробности расчетов";
                            color: {
                                if (text == "Подробности расчетов") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //50
                        id: grap50
                        anchors.left: grap47.right; anchors.top: grap47_6.bottom
                        height: 300; width: (md_2.width / 2) + (md_2.width / 8);
                        border.width: 1;
                        Text {
                            id: grap50text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap50;
                            color: {
                                if (text == "Принципал") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //C
                        id: grapC
                        anchors.left: grap50.right; anchors.right: grapB.right
                        anchors.top: grap50.top; anchors.bottom: grap50.bottom
                        border.width: 1;
                        Text {
                            id: grapCtext; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "Таможенный орган отправления";
                            color: {
                                if (text == "Таможенный орган отправления") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //51
                        id: grap51
                        anchors.left: grap47.left; anchors.right: grap47.right
                        anchors.top: grap47.bottom; anchors.topMargin: 150
                        height: 150; border.width: 1;
                        Text {
                            id: grap51text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap51;
                            color: {
                                if (text == "предп. таможенные органы") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //52
                        id: grap52
                        anchors.left: grap51.left; anchors.right: grapC.left;
                        anchors.top: grap51.bottom;
                        height: 50; border.width: 1;
                        Text {
                            id: grap52text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap52;
                            color: {
                                if (text == "Гарантия не действительна для..") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //53
                        id: grap53
                        anchors.left: grap52.right; anchors.right: grapC.right;
                        anchors.top: grapC.bottom;
                        height: 50; border.width: 1;
                        Text {
                            id: grap53text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.grap53;
                            color: {
                                if (text == "Таможенный орган (и страна) назначения") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //D_J
                        id: grapD_J
                        anchors.left: grap52.left; anchors.right: grap41.left
                        anchors.top: grap52.bottom; height: 200;
                        border.width: 1;
                        Text {
                            id: grapD_Jtext; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: "Отметки таможенного органа отправления /назначения";
                            color: {
                                if (text == "Отметки таможенного органа отправления /назначения") return "#787878";
                                else return "black"
                            }
                        }
                    }
                    Rectangle { //54
                        id: grap54
                        anchors.left: grapD_J.right; anchors.right: grap53.right
                        anchors.top: grap52.bottom; height: 200;
                        border.width: 1;
                        Text {
                            id: grap54text; anchors.margins: 5; wrapMode: Text.WordWrap; clip: true
                            anchors.fill: parent; font.pixelSize: 18; font.family: "fontRoboto";
                            text: root.selectYear + ". Месяц - " + root.selectMounth + ". День - " + root.selectDay + ". " + root.selectHour + ":" + root.selectMin + "\n" + root.pntAdress
                            color: {
                                if (text == "Место и дата") return "#787878";
                                else return "black"
                            }
                        }
                    }
                }
            }
        }

    }
    Rectangle{
        id: recBtnCntr; anchors.fill: parent; visible: false
        Rectangle{
            id: recBtnCntTop
            anchors.top: parent.top; height: 60; width: parent.width;
            Button{
                id: txtNameFirst
                width: parent.width / 3; height: parent.height
                background: Rectangle{ anchors.fill: parent; color: txtNameFirst.hovered ? "#cfe4ff" : "white" }
                Text {
                    anchors.left: parent.left; anchors.leftMargin: 20; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family: "fontRoboto"
                    text: "Наименование"
                }
            }
            Button{
                id: txtNameAlpha2
                anchors.left: txtNameFirst.right
                width: parent.width / 3; height: parent.height
                background: Rectangle{ anchors.fill: parent; color: txtNameAlpha2.hovered ? "#cfe4ff" : "white" }
                Text {
                    anchors.left: parent.left; anchors.leftMargin: 20; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family: "fontRoboto"
                    text: "Alpha2"
                }
            }
            Button{
                id: txtNameWorld
                anchors.left: txtNameAlpha2.right
                width: parent.width / 3; height: parent.height
                background: Rectangle{ anchors.fill: parent; color: txtNameWorld.hovered ? "#cfe4ff" : "white" }
                Text {
                    anchors.left: parent.left; anchors.leftMargin: 20; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family: "fontRoboto"
                    text: "Часть света"
                }
            }


        }

        BtnCntr{anchors.top: recBtnCntTop.bottom; anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right}
    }

    function selectGrap(grapName){
        for (var i = 0; i < dcklView.children.length; i++)
        {
            dcklView.children[i].color = "white"
        }
        if (grapName === "Декларация") {
            grap1.color = "#e8e8e8"; textInpGr = grap1text.text; flickDcklr.contentY = grap1.y
        }
        else if (grapName === "Отправитель/Экспортер") {grap2.color = "#e8e8e8"; textInpGr = grap2text.text; flickDcklr.contentY = grap2.y}
        else if (grapName === "Формы") {grap3.color = "#e8e8e8"; textInpGr = grap3text.text; flickDcklr.contentY = grap3.y}
        else if (grapName === "Отгрузочные спецификации") {grap4.color = "#e8e8e8"; textInpGr = grap4text.text; flickDcklr.contentY = grap4.y}
        else if (grapName === "Всего товаров") {grap5.color = "#e8e8e8"; textInpGr = grap5text.text; flickDcklr.contentY = grap5.y}
        else if (grapName === "Всего мест") {grap6.color = "#e8e8e8"; textInpGr = grap6text.text; flickDcklr.contentY = grap6.y}
        else if (grapName === "Справочный номер") {grap7.color = "#e8e8e8"; textInpGr = grap7text.text; flickDcklr.contentY = grap7.y}
        else if (grapName === "Получатель") {grap8.color = "#e8e8e8"; textInpGr = grap8text.text; flickDcklr.contentY = grap8.y}
        else if (grapName === "Лицо, ответственное за финансовое урегулирование") {grap9.color = "#e8e8e8"; textInpGr = grap9text.text; flickDcklr.contentY = grap9.y}
        else if (grapName === "Страна перв. назн./послед. отправил") {
            grap10.color = "#e8e8e8"; textInpGr = grap10text.text; recBtnCntr.visible = true; btnGrap = 1;
        }
        else if (grapName === "Торговая страна / Страна производства") {
            grap11.color = "#e8e8e8"; textInpGr = grap11text.text; recBtnCntr.visible = true; btnGrap = 2;
        }
        else if (grapName === "Сведения о стоимости") {grap12.color = "#e8e8e8"; textInpGr = grap12text.text}
        else if (grapName === "ЕСП") {grap13.color = "#e8e8e8"; textInpGr = grap13text.text}
        else if (grapName === "Декларант/Представитель") {grap14.color = "#e8e8e8"; textInpGr = grap14text.text}
        else if (grapName === "Страна отправления/экспорта") {
            grap15_1.color = "#e8e8e8"; textInpGr = grap15_1text.text; recBtnCntr.visible = true; btnGrap = 3;
        }
        else if (grapName === "Код страны отправления/экспорта") {grap15.color = "#e8e8e8"; textInpGr = grap15text.text}
        else if (grapName === "Страна происхождения") {
            grap16.color = "#e8e8e8"; textInpGr = grap16text.text; recBtnCntr.visible = true; btnGrap = 4;
        }
        else if (grapName === "Страна назначения и код") {
            grap17.color = "#e8e8e8"; textInpGr = grap17text.text; recBtnCntr.visible = true; btnGrap = 5;
        }
        else if (grapName === "Идентификация и страна регистрации транспортного средства при отправлении/прибытии") {grap18.color = "#e8e8e8"; textInpGr = grap18text.text}
        else if (grapName === "Контейнер") {grap19.color = "#e8e8e8"; textInpGr = grap19text.text}
        else if (grapName === "Условия поставки") {grap20.color = "#e8e8e8"; textInpGr = grap20text.text}
        else if (grapName === "Идентификация и страна регистрации активного транспортного средства на границе") {grap21.color = "#e8e8e8"; textInpGr = grap21text.text}
        else if (grapName === "Валюта и общая сумма по счету") {grap22.color = "#e8e8e8"; textInpGr = grap22text.text; flickDcklr.contentY = grap22.y}
        else if (grapName === "Курс валюты") {grap23.color = "#e8e8e8"; textInpGr = grap23text.text; flickDcklr.contentY = grap23.y}
        else if (grapName === "Характер сделки") {grap24.color = "#e8e8e8"; textInpGr = grap24text.text; flickDcklr.contentY = grap24.y}
        else if (grapName === "Вид транспорта на границе") {grap25.color = "#e8e8e8"; textInpGr = grap25text.text; flickDcklr.contentY = grap25.y}
        else if (grapName === "Вид транспорта внутри страны") {grap26.color = "#e8e8e8"; textInpGr = grap26text.text; flickDcklr.contentY = grap26.y}
        else if (grapName === "Место погрузки/разгрузки") {grap27.color = "#e8e8e8"; textInpGr = grap27text.text; flickDcklr.contentY = grap27.y}
        else if (grapName === "Финансовые и банковские сведения") {grap28.color = "#e8e8e8"; textInpGr = grap28text.text; flickDcklr.contentY = grap28.y}
        else if (grapName === "Финансовые и банковские сведения(п)") {grap28_2.color = "#e8e8e8"; textInpGr = grap28_2text.text; flickDcklr.contentY = grap28.y}
        else if (grapName === "Таможенный орган выезда/въезда") {grap29.color = "#e8e8e8"; textInpGr = grap29text.text; flickDcklr.contentY = grap29.y}
        else if (grapName === "Местонахождение товаров") {grap30.color = "#e8e8e8"; textInpGr = grap30text.text; flickDcklr.contentY = grap30.y}
        else if (grapName === "Грузовые места и описание товаров") {grap31_1.color = "#e8e8e8"; textInpGr = grap31text.text; flickDcklr.contentY = grap31.y}
        else if (grapName === "Грузовые места и описание товаров. Маркировка и количество - Номера контейнеров - Количество и отличительные особенности") {grap31_1.color = "#e8e8e8"; textInpGr = grap31_1.text; flickDcklr.contentY = grap31.y}
        else if (grapName === "Товар N") {grap32.color = "#e8e8e8"; textInpGr = grap32text.text; flickDcklr.contentY = grap32.y}
        else if (grapName === "Код товара") {grap33.color = "#e8e8e8"; textInpGr = grap33text.text; flickDcklr.contentY = grap33.y}
        else if (grapName === "Код страны происхождения") {grap34.color = "#e8e8e8"; textInpGr = grap34text.text; flickDcklr.contentY = grap34.y}
        else if (grapName === "Вес брутто (кг)") {grap35.color = "#e8e8e8"; textInpGr = grap35text.text; flickDcklr.contentY = grap35.y}
        else if (grapName === "Преференции") {grap36.color = "#e8e8e8"; textInpGr = grap36text.text; flickDcklr.contentY = grap36.y}
        else if (grapName === "Процедура") {grap37.color = "#e8e8e8"; textInpGr = grap37text.text; flickDcklr.contentY = grap37.y}
        else if (grapName === "Вес нетто (кг)") {grap38.color = "#e8e8e8"; textInpGr = grap38text.text; flickDcklr.contentY = grap38.y}
        else if (grapName === "Квота") {grap39.color = "#e8e8e8"; textInpGr = grap39text.text; flickDcklr.contentY = grap39.y}
        else if (grapName === "Общая декларация/Предварительный документ") {grap40.color = "#e8e8e8"; textInpGr = grap40text.text; flickDcklr.contentY = grap40.y}
        else if (grapName === "Дополнительные единицы измерения") {grap41.color = "#e8e8e8"; textInpGr = grap41text.text; flickDcklr.contentY = grap41.y}
        else if (grapName === "Цена товара") {grap42.color = "#e8e8e8"; textInpGr = grap42text.text; flickDcklr.contentY = grap42.y}
        else if (grapName === "Метод определения стоимости") {grap43.color = "#e8e8e8"; textInpGr = grap43text.text; flickDcklr.contentY = grap43.y}
        else if (grapName === "Дополнительная информация") {grap44_1.color = "#e8e8e8"; textInpGr = grap44_1text.text; flickDcklr.contentY = grap44.y}
        else if (grapName === "Корректировка") {grap45.color = "#e8e8e8"; textInpGr = grap45text.text; flickDcklr.contentY = grap45.y}
        else if (grapName === "Статистическая стоимость") {grap46.color = "#e8e8e8"; textInpGr = grap46text.text; flickDcklr.contentY = grap46.y}
        else if (grapName === "Начисление платежей") {grap47.color = "#e8e8e8"; textInpGr = grap47text.text; flickDcklr.contentY = grap47.y}
        else if (grapName === "Отсрочка платежей") {grap48.color = "#e8e8e8"; textInpGr = grap48text.text; flickDcklr.contentY = grap48.y}
        else if (grapName === "Реквизиты склада") {grap49.color = "#e8e8e8"; textInpGr = grap49text.text; flickDcklr.contentY = grap49.y}
        else if (grapName === "Принципал") {grap50.color = "#e8e8e8"; textInpGr = grap50text.text; flickDcklr.contentY = grap50.y}
        else if (grapName === "Предполагаемые органы") {grap51.color = "#e8e8e8"; textInpGr = grap51text.text; flickDcklr.contentY = grap51.y}
        else if (grapName === "Гарантия не действительна для..") {grap52.color = "#e8e8e8"; textInpGr = grap52text.text; flickDcklr.contentY = grap52.y}
        else if (grapName === "Таможенный орган (и страна) назначения") {grap53.color = "#e8e8e8"; textInpGr = grap53text.text; flickDcklr.contentY = grap53.y}
        else if (grapName === "Место и дата") {grap54.color = "#e8e8e8"; textInpGr = grap54text.text; flickDcklr.contentY = grap54.y}
        else if (grapName === "Перейти к товарам") selectDopMenu(6)
    }
    function selectCountry(indexS, countryS, fullCountry){
        recBtnCntr.visible = false; textInpGr = countryS
        switch(indexS){
        case '1': root.grap10 = countryS; break;
        case '2': root.grap11 = countryS; break;
        case '3': root.grap15_1 = countryS; root.grap15 = fullCountry; break;
        case '4': root.grap16 = countryS; break;
        case '5': root.grap17 = countryS; root.grap17_1 = fullCountry; break;
        }
    }

    function editGrap(grapName){
        if (grapName === "Декларация") root.grap1 = textEditInput.text
        else if (grapName === "Отправитель/Экспортер") root.grap2 = textEditInput.text
        else if (grapName === "Формы") root.grap3 = textEditInput.text //Какая по счету МД и общее кол-во МД
        else if (grapName === "Отгрузочные спецификации") root.grap4 = textEditInput.text //МД6
        else if (grapName === "Всего товаров") root.grap5 = textEditInput.text
        else if (grapName === "Всего мест") root.grap6 = textEditInput.text
        else if (grapName === "Справочный номер") root.grap7 = textEditInput.text
        else if (grapName === "Получатель") root.grap8 = textEditInput.text
        else if (grapName === "Лицо, ответственное за финансовое урегулирование") root.grap9 = textEditInput.text
        else if (grapName === "Страна перв. назн./послед. отправил") root.grap10 = textEditInput.text
        else if (grapName === "Торговая страна / Страна производства") root.grap11 = textEditInput.text

        else if (grapName === "Сведения о стоимости") root.grap12 = textEditInput.text

        else if (grapName === "ЕСП") root.grap13 = textEditInput.text
        else if (grapName === "Декларант/Представитель") root.grap14 = textEditInput.text
        else if (grapName === "Код страны отправления/экспорта") root.grap15 = textEditInput.text
        else if (grapName === "Страна происхождения") root.grap16 = textEditInput.text
        else if (grapName === "Страна назначения и код") root.grap17 = textEditInput.text
        else if (grapName === "Идентификация и страна регистрации транспортного средства при отправлении/прибытии") root.grap18 = textEditInput.text
        else if (grapName === "Контейнер") root.grap19 = textEditInput.text
        else if (grapName === "Условия поставки") root.grap20 = textEditInput.text
        else if (grapName === "Идентификация и страна регистрации активного транспортного средства на границе") root.grap21 = textEditInput.text
        else if (grapName === "Валюта и общая сумма по счету") root.grap22 = textEditInput.text
        else if (grapName === "Курс валюты") root.grap23 = textEditInput.text
        else if (grapName === "Характер сделки") root.grap24 = textEditInput.text
        else if (grapName === "Вид транспорта на границе") root.grap25 = textEditInput.text
        else if (grapName === "Вид транспорта внутри страны") root.grap26 = textEditInput.text
        else if (grapName === "Место погрузки/разгрузки") root.grap27 = textEditInput.text
        else if (grapName === "Финансовые и банковские сведения") root.grap28 = textEditInput.text
        else if (grapName === "Таможенный орган выезда/въезда") root.grap29 = textEditInput.text
        else if (grapName === "Местонахождение товаров") root.grap30 = textEditInput.text
        else if (grapName === "Грузовые места и описание товаров") root.grap31 = textEditInput.text
        else if (grapName === "Товар N") root.grap32 = textEditInput.text
        else if (grapName === "Код товара") root.grap33 = textEditInput.text
        else if (grapName === "Код страны происхождения") root.grap34 = textEditInput.text
        else if (grapName === "Вес брутто (кг)") root.grap35 = textEditInput.text
        else if (grapName === "Преференции") root.grap36 = textEditInput.text
        else if (grapName === "Процедура") root.grap37 = textEditInput.text
        else if (grapName === "Вес нетто (кг)") root.grap38 = textEditInput.text
        else if (grapName === "Квота") root.grap39 = textEditInput.text
        else if (grapName === "Общая декларация/Предварительный документ") root.grap40 = textEditInput.text
        else if (grapName === "Дополнительные единицы измерения") root.grap41 = textEditInput.text
        else if (grapName === "Цена товара") root.grap42 = textEditInput.text
        else if (grapName === "Метод определения стоимости") root.grap43 = textEditInput.text
        else if (grapName === "Дополнительная информация") root.grap44_1 = textEditInput.text
        else if (grapName === "Корректировка") root.grap45 = textEditInput.text
        else if (grapName === "Статистическая стоимость") root.grap46 = textEditInput.text
        else if (grapName === "Начисление платежей") root.grap47 = textEditInput.text
        else if (grapName === "Отсрочка платежей") root.grap48 = textEditInput.text
        else if (grapName === "Реквизиты склада") root.grap49 = textEditInput.text
        else if (grapName === "Принципал") root.grap50 = textEditInput.text
        else if (grapName === "Предполагаемые органы") root.grap51 = textEditInput.text
        else if (grapName === "Гарантия не действительна для..") root.grap52 = textEditInput.text
        else if (grapName === "Таможенный орган (и страна) назначения") root.grap53 = textEditInput.text
        else if (grapName === "Место и дата") root.grap54 = textEditInput.text
    }
}
