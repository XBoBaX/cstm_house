import QtQuick 2.0
import QtQuick.Controls 2.2

Item{
    height: 60; width: parent.width
    property alias name: control.text
    property bool selected: false
    property bool exit: false
    property color baseColor
    Button {
        id: control
        text: "Графа 1. Декларация"
        font.pointSize: 18; font.family: "fontRoboto"
        hoverEnabled: true
        width: parent.width; height: 60

        contentItem: Text {
            text: control.text
            font: control.font
            opacity: enabled ? 1.0 : 0.3
            color: selected || exit ? "white" : "#787776"
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            id: bgrect
            color: selected || exit ? "#0078d7" : "#fafafa"
            opacity: control.down ? 0.7 : 1
            border.color: "#f6f6f6"
        }
        onClicked: {
            for (var i = 0; i < columnButton.children.length - 1; i++)
            {
                columnButton.children[i].selected = false
                columnButton.children[i].indexed = i;
            }
            selected = true; placholderInput.text = control.text
            idBtnSelected = index
            grpSelected = modelData
            selectGrap(modelData)
        }
    }
}
