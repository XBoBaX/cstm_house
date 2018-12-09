import QtQuick 2.9
import QtQuick.Controls 2.2

Button{
    property string iconT
    property string textMain
    id: rootPaarent
    width: (rootAdd.width / 2); height: rootAdd.height / 4; clip: true
    background: Rectangle{id: recBgr; anchors.fill: parent; color: rootPaarent.hovered ? "#c9c9c9" : "white"}
    Image {
        id: imgBtn; height: (parent.height / 2) + (parent.height / 5); anchors.top: recBgr.top;
        anchors.horizontalCenter: parent.horizontalCenter
        source: iconT; fillMode: Image.PreserveAspectFit
    }
    Text{
        anchors.top: imgBtn.bottom; anchors.horizontalCenter: parent.horizontalCenter
        font.family: "fontRoboto"; font.pixelSize: 24
        text: textMain
        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
    }
}
