import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
    id: control
    text: "Вход"
    font.pointSize: 16
    hoverEnabled: true
    property alias name: control.text
    property color colorText
    property bool select : false
    property bool exit
    property bool bottomButton

    contentItem: Text {
        id: text
        text: control.text
        font: control.font
//        opacity: control.hovered ? 0.3 : 1.0
        color: control.select ? colorText : "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight

    }
    Rectangle{
        anchors.left: parent.left
        width: bottomButton ? 0 : 3
        height: parent.height
        color: colorText
    }
    Rectangle{
        anchors.left: parent.left
        width: bottomButton ? 3 : 0
        height: parent.height
        color: "#282b32"
    }
    Rectangle{
        anchors.left: parent.right
        width: bottomButton ? 3 : 0
        height: parent.height
        color: "#282b32"
    }
    background: Rectangle {
        id: bgrect
        implicitWidth: 100
        implicitHeight: 50
        color: {
            if (bottomButton) "#2b2e35"
            if (exit) return "#182121"
            if (control.hovered || control.select) return "#2c353d"
            else return "transparent"
        }
    }
}
