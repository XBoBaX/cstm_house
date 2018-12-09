import QtQuick 2.0
import QtQuick.Controls 2.2

Button{
    property string country
    property string textCnt

    width: itemGrid.width / 9; height: itemGrid.height / 3
    background: Image {
        anchors.fill: parent
        source: country
    }
    Rectangle {
        id: block; visible: parent.hovered
        anchors.fill: parent;
        color: "#4c000000"
        Text {
            anchors.centerIn: parent;
            font.family: "fontRoboto"; font.pixelSize: 36; font.bold: true
            text: textCnt; color: "white"
        }
    }
    onClicked: {selectCstmHs(textCnt);}
}
