import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4

Item {
    property int hour: control.currentIndex
    property int min: control2.currentIndex
    property alias modeldata1: control.currentIndex
    property alias modeldata2: control2.currentIndex
    Row{
        anchors.fill: parent;
        Tumbler{
            id: control
            width: parent.width / 2
            model: 24
            delegate: Text {
                text: modelData
                horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                font.pixelSize: 28;
                opacity: 1.0 - Math.abs(Tumbler.displacement) / (control.visibleItemCount / 2)
            }
        }
        Tumbler{
            id: control2
            width: parent.width / 2
            model: 60
            delegate: Text {
                text: modelData
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 28
                opacity: 1.0 - Math.abs(Tumbler.displacement) / (control2.visibleItemCount / 2)
            }
        }
    }
}
