import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
    id: control
    hoverEnabled: true
    property bool selected: false

    property alias text1: text1.text

    width: 150; height: 120;
    background: Rectangle {
        color: selected || hovered ? "#3b4752" : "#2c353d"
    }
    Text {
        id: text1
        anchors.centerIn: parent
        text: "время\nи дата"; color: "white";
        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
        font.family: "fontRoboto"; font.pointSize: 18;
    }
    onClicked: {

    }
}
