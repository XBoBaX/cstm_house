import QtQuick 2.0
import QtQuick.Controls 2.2

Button {
    id: control
    hoverEnabled: true
    property bool selected: false

    property alias textIcon: text1.text
    property alias text1: text2.text

    width: 180; height: 120
    background: Rectangle {
        color: selected || hovered ? "#2c353d" : "#2b2e35"
    }
    Rectangle{
        anchors.left: parent.left
        width: 3; height: parent.height
        color: "#282b32"
    }
    Rectangle{
        anchors.right: parent.right
        width: 3; height: parent.height
        color: "#282b32"
    }
    Item{
        width: parent.width; height: text1.height + text2.height
        anchors.centerIn: parent
        Text{
            id: text1
            font.family: "fontIcon"
            font.pointSize: 42
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white";
        }
        Text{
            id: text2
            anchors.top: text1.bottom;
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "fontRoboto"
            font.pointSize: 18;
            color: "white";
        }
    }
}
