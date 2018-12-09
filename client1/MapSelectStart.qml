import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle{
    id: selectStart1
    anchors.fill: parent
    property string selectedStart: "false"
    property string longitude1
    property string latitude1
    Map{
        anchors.top: parent.top; anchors.bottom: btnback.top;
        anchors.left: parent.left; anchors.right: parent.right
        start1: "true"
    }
    Button{
        id: btnback
        anchors.bottom: parent.bottom;
        anchors.left: parent.left; anchors.right: parent.right
        background: Rectangle{ anchors.fill: parent; color: btnback.hovered ? "#fbfbfb" : "#de6062";}
        onClicked: {
            if (txtbtn.text === "Назад") {
                popup.popMessage = "Не выбрана точка отправки"
                popup.open();
                return
            }
            root.latitude2 = latitude1
            root.longitude2 = longitude1
            selectDopMenu(2)
        }
        height: 60
        Text{
            anchors.centerIn: parent; text: "Назад"; color: btnback.hovered ? "#87c5c1" : "white"
            font.pixelSize: 46; font.bold: true; id: txtbtn
        }
    }
    function selectPoint(){
        txtbtn.text = "Выбрать"
        console.log(longitude1 + " " + latitude1)
    }
}
