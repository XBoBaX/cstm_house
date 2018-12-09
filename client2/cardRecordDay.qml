import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
    id: btnParent
    background: Rectangle{anchors.fill: parent; color: btnParent.hovered ? "#fbfbfb" : "white"}
    property string textCar
    property string textTime
    property int iterator

    width: parent.width; height: 70;
    Text {
        anchors.top: parent.top; anchors.topMargin: 4;
        anchors.left: parent.left
        anchors.leftMargin: 16; font.pixelSize: 24
        font.family: "fontRoboto"; text: textCar
    }
    Text{
        anchors.top: parent.top; anchors.topMargin: 35
        anchors.left: parent.left
        anchors.leftMargin: 16; font.pixelSize: 24
        font.family: "fontRoboto"; text: textTime; color: "#9d9d9d";
    }
    Rectangle{
        color: iterator%2 == 0 ? "#f1765b" : "#3ca1d0"; width: 6; height: parent.height
    }
    onClicked: selectNowRecord(textCar)

}
