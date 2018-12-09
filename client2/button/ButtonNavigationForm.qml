import QtQuick 2.0
import QtQuick.Controls 2.2

Button {

    id: control
    height: 60
    text: "Графа 1. Декларация"
    font.pointSize: 18
    width: parent.width
    font.family: "fontRoboto"
    hoverEnabled: true
    property alias name: control.text
    property bool selected: false
    property color baseColor

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: selected ? "white" : "#787776"
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        id: bgrect
        color: selected ? "#0078d7" : "#fafafa"
        opacity: control.down ? 0.7 : 1
        border.color: "#f6f6f6"
    }
}
