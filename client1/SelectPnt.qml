import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: recSelectCstmHs;
    color: "#1f2228"; anchors.fill: parent;
    Text {
        id: txtSelcCH; font.family: "fontRoboto"; font.pixelSize: 42
        text: {
            if (root.country === "0") return "ВЫБЕРИ СТРАНУ"
            return "ВЫБОР ПРОПУСКНОГО ПУНКТА";
        }
        color: "#c9c9c9"
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.topMargin: 25; anchors.top: parent.top
    }
    Text {
        font.family: "fontRoboto"; font.pixelSize: 42
        anchors.top: txtSelcCH.bottom; anchors.topMargin: 20
        anchors.left: parent.left; anchors.leftMargin: 10
        id: txtSelect1; text: "название"; color: "white"
    }
    Text {
        font.family: "fontRoboto"; font.pixelSize: 42
        anchors.top: txtSelcCH.bottom; anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        text: "УКРАИНА - " + root.country; color: "white"
    }
    Text {
        font.family: "fontRoboto"; font.pixelSize: 42
        anchors.top: txtSelcCH.bottom; anchors.topMargin: 20
        anchors.right: parent.right; anchors.rightMargin: 10
        text: "направление"; color: "white"
    }


    ListView{
        anchors.top: txtSelect1.bottom; anchors.topMargin: 25; anchors.bottom: goMap.top
        anchors.left: parent.left; anchors.right: parent.right; clip: true
        delegate: Item {
            id: item
            anchors.left: parent.left
            anchors.right: parent.right
            height: 120
            Button {
                id: btnNow; anchors.fill: parent
                background: Rectangle{id: bgRec; anchors.fill: parent; color: btnNow.hovered ? "#3b4752" : "white"}
                Text{
                    anchors.left: parent.left; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter
                    font.family: "fontRoboto"; font.pointSize: 24;
                    text: name; color: btnNow.hovered ? "white" : "black"
                }
                Text{
                    anchors.centerIn: parent
                    font.family: "fontRoboto"; font.pointSize: 24;
                    text: adress; color: btnNow.hovered ? "white" : "black"
                }
                Text{
                    id: iconV
                    anchors.right: parent.right; anchors.rightMargin: 10; anchors.verticalCenter: parent.verticalCenter
                    font.family: "fontIcon"; font.pointSize: 24;
                    color: entry ? "#369636" : "#b44"
                    text: entry ? "\uf139" : "\uf13a"
                }
                Text{
                    anchors.right: iconV.left; anchors.rightMargin: 10; anchors.verticalCenter: parent.verticalCenter
                    font.family: "fontRoboto"; font.pointSize: 24;
                    text: entry ? "Въезд" : "Выезд"; color: btnNow.hovered ? "white" : "black"
                }
                onClicked: {
                    root.pntId = id; root.pntName = name; root.pntAdress = adress; root.pntEntry = entry
                    popup.popMessage = (entry ? "Въезд" : "Выезд") + ". Выбран пропускной пункт: " + pntAdress + "(" + pntName + ")";
                    popup.colorSelect = true; popup.open();
                    selectedMenu(2);
                }

            }
        }
        model: ListModel {
            id: listModel // задаём ей id для обращения
        }
    }

    Button{
        id: goMap
        anchors.bottom: parent.bottom; height: 60
        anchors.left: parent.left; anchors.right: parent.right
        background: Rectangle{ anchors.fill: parent; color: goMap.hovered ? "#fbfbfb" : "#de6062";}
        Text{
            id: txtMap
            anchors.centerIn: parent
            font.family: "fontRoboto"; font.pointSize: 24;
            text: "Перейти к карте"; color: goMap.hovered ? "#87c5c1" : "white"
        }
        onClicked: {
            txtMap.text = txtMap.text == "Назад" ? "Перейти к карте" : "Назад"
            mapVis.visible = !mapVis.visible
        }
    }
    Rectangle{
        id: mapVis
        visible: false
        anchors.top: parent.top; anchors.bottom: goMap.top
        anchors.left: parent.left; anchors.right: parent.right
        Map{
            anchors.fill: parent
            country: root.countryEng
        }
    }

    function chpntsFill(JsonGet){
        var jsonMessage = JSON.parse(JsonGet);
        var i = 0
        for (var val in jsonMessage["chpnts"]){
            listModel.append({name: jsonMessage["chpnts"][val]["name"], adress: jsonMessage["chpnts"][val]["adress"],
                             entry: jsonMessage["chpnts"][val]["entry_or_departure"], id: jsonMessage["chpnts"][val]["id"]})
        }
    }

    Connections {
        target: network
        onTakeChpnts: {
            chpntsFill(message);
        }
    }
}

