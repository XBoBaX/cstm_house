import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2

Rectangle{
    id: rectRoot; anchors.fill: parent;
    Button{
        id: addBtnPdf
        anchors.left: parent.left; anchors.top: parent.top
        anchors.margins: 20
        height: 240; width: (parent.width - 60) / 2
        background: Rectangle { anchors.fill: parent; color: addBtnPdf.hovered ? "#3b4752" : "#fafafa" }
        onClicked: fileDialog.visible = true
        Text{
            anchors.centerIn: parent; id: txtAddBtn
            text: "выбрать\nшаблон"; color: addBtnPdf.hovered ? "white" : "#787878"
            font.pixelSize: 42; font.family: "fontRoboto"
            verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
        }
    }
    Button{
        id: addBtnEmty
        anchors.left: addBtnPdf.right; anchors.top: parent.top
        anchors.margins: 20
        height: 240; width: (parent.width - 60) / 2
        background: Rectangle { anchors.fill: parent; color: addBtnEmty.hovered ? "#3b4752" : "#fafafa" }
        Text{
            anchors.centerIn: parent; id: txtEmptyBtn
            text: "выбрать\nпустой\nшаблон"; color: addBtnEmty.hovered ? "white" : "#787878"
            font.pixelSize: 42; font.family: "fontRoboto"
            verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
        }
        onClicked: selectDopMenu(5)
    }
    Rectangle {
        anchors.left: parent.left; anchors.top: addBtnEmty.bottom
        anchors.right: parent.right; anchors.bottom: parent.bottom
        anchors.margins: 20; color: "#fafafa"; id: recDecl
        Text{
            id: textCopyDecl
            anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 25
            text: "скопировать предыдущую декларацию"; color: "#787878"
            font.pixelSize: 42; font.family: "fontRoboto"
        }
        GridView{
            anchors.top: textCopyDecl.bottom; anchors.topMargin: 25; anchors.bottom: parent.bottom
            anchors.left: parent.left; anchors.right: parent.right; anchors.leftMargin: 25
            cellWidth: (parent.width / 5) - 5; cellHeight: 225; clip: true
            delegate: Button{
                id: item; width: parent.width / 5 - 20; height: 200
                background: Rectangle{
                    anchors.fill: parent;
                    color: item.hovered ? "#3b4752" : "white"
                }
                Text {
                    anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter
                    text: "декл №:"; id: textNumber; color: item.hovered ? "white" : "#787878"
                    font.pixelSize: 38; font.family: "fontRoboto"
                }
                Text {
                    anchors.top: textNumber.bottom; anchors.horizontalCenter: parent.horizontalCenter
                    text: autonumber; color: item.hovered ? "white" : "black"
                    font.pixelSize: 38; font.family: "fontRoboto"; id: avto
                }
                Text {
                    anchors.bottom: date.top; anchors.horizontalCenter: parent.horizontalCenter
                    text: dateSel; color: item.hovered ? "white" : "#787878"
                    font.pixelSize: 38; font.family: "fontRoboto"
                }
                Text {
                    anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
                    text: timeSel; id: date; color: item.hovered ? "white" : "#787878"
                    font.pixelSize: 38; font.family: "fontRoboto"
                }
                onClicked: getDecl(autonumber);
            }
            model: ListModel {id: listModel1}
        }

    }
    function appendRecords(JsonGet){
        var jsonMessage = JSON.parse(JsonGet);
        var i = 0
        for (var val in jsonMessage["chpnts"]){
            var date1 = jsonMessage["chpnts"][val]["date"];
            var dateM_D_Y = "" + date1.split('T')[0]
            if (date1 === "") continue
            console.log(date1.split('T')[1].split(':')[0])
            console.log(date1.split('T')[1].split(':')[1])
            var dateH_m = date1.split('T')[1].split(':')[0] + ":" + date1.split('T')[1].split(':')[1]
            listModel1.append({autonumber: jsonMessage["chpnts"][val]["autonumber"], phonenumber: jsonMessage["chpnts"][val]["phonenumber"],
                             dateSel: dateM_D_Y, timeSel: dateH_m, id: jsonMessage["chpnts"][val]["id"]})
            i++;
        }
        if (i == 0) {
            addBtnEmty.height = addBtnPdf.height = rectRoot.height; recDecl.visible = false
            txtAddBtn.font.pixelSize = 72; txtEmptyBtn.font.pixelSize = 72
        }
        else {
            addBtnPdf.height = 240; addBtnEmty.height = 240; recDecl.visible = true
            txtAddBtn.font.pixelSize = 42; txtEmptyBtn.font.pixelSize = 42

        }
    }

    FileDialog {
        id: fileDialog
        title: "Выберите файл с шаблоном"
        nameFilters: ["Шаблон (*.txt)"]
        folder: shortcuts.home
        onAccepted: {
            var url = fileDialog.fileUrl + ""
            url = url.substring(8, url.length)
            network.readDeclTemplate(url);
        }
        onRejected: {console.log("Canceled")}
        Component.onCompleted: visible = false;
    }
    function getDecl(autonumber){
        network.getPrewDecl(autonumber);
    }

    function setParam(message){
        var json_temp = JSON.parse(message)
        root.grap1 = json_temp["Декларация"]
        root.grap2 = json_temp["Отправитель / Экспортер"]
        root.grap6 = json_temp["Всего мест"]
        root.grap8 = json_temp["Получатель"]
        root.grap9 = json_temp["Лицо, ответственное за финансовое урегулирование"]
        root.grap10 = json_temp["Страна перв. назн./послед. отправил"]
        root.grap11 = json_temp["Торговая страна / страна производства"]
        root.grap13 = json_temp["ЕСП"]
        root.grap14 = json_temp["Декларант/Представитель"]
        root.grap15 = json_temp["Страна отправления/экспорта"]
        root.grap15_1 = json_temp["Код страны отправления/экспорта"]
        root.grap16 = json_temp["Страна происхождения"]
        root.grap17 = json_temp["страна назначения"]
        root.grap17_1 = json_temp["Код страны назначения"]
        root.grap18 = json_temp["Идентификация и страна регистрации транспортного средства при отправлении/прибытии"]
        root.grap19 = json_temp["Контейнер"]
        root.grap20 = json_temp["Условия поставки"]
        root.grap21 = json_temp["Идентификация и страна регистрации активного транспортного средства на границе"]
        root.grap22 = json_temp["Валюта и общая сумма по счету"]
        root.grap23 = json_temp["Курс валюты"]
        root.grap24 = json_temp["Характер сделки"]
        root.grap25 = json_temp["Вид транспорта на границе"]
        root.grap26 = json_temp["Вид транспорта внутри страны"]
        root.grap27 = json_temp["Место погрузки/разгрузки"]
        root.grap28 = json_temp["Финансовые и банковские сведения"]
        root.grap29 = json_temp["Таможенный орган выезда/въезда"]
        root.grap30 = json_temp["Местонахождение товара"]
        root.grap49 = json_temp["Реквизиты склада"]
        root.grap50 = json_temp["Принципал"]
        root.grap52 = json_temp["Гарантия не действительна для"]
        root.grap53 = json_temp["Таможенный орган (и страна) назначения"]
        root.grap54 = json_temp["Дата"]

        root.tovar_count = 0;
        var n = parseInt(json_temp["count"])
        for (var i=0; i<n;i++){
            root.tovars[root.tovar_count] = "{\"code_tovar\": \"" + json_temp["tovar" + i]["Код товара"] + "\", \"graph31\": \"" + json_temp["tovar" + i]["Описание"] + "\", \"graph34\": \"" + json_temp["tovar" + i]["Код страны происх."] +
                    "\", \"graph35\": \"" + json_temp["tovar" + i]["Вес брутто"] + "\",\"graph36\": \"" + json_temp["tovar" + i]["преферанция"] + "\", \"graph37\": \"" + json_temp["tovar" + i]["нетто"] + "\", \"graph38\": \"" + json_temp["tovar" + i]["цена"] +
                    "\", \"pref\": \"" + json_temp["tovar" + i]["Пошлина"] + "\", \"full\": \"" + json_temp["tovar" + i]["Пошлина"] + "\"}";
            root.tovar_count += 1
        }

        console.log("count tovar" + json_temp["count"]);
        root.selectDopMenu(5);
    }

    Connections{
        target: network
        onTakeRecords: {
            appendRecords(message);
        }
        onFileRead: {
            setParam(message)
        }
        onDeclSet: {
            setParam(message)
        }
    }
}
