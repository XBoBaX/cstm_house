import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
    property string text1: "Отменить заказ"
    id: btn
    background: Rectangle{anchors.fill: parent; color: btn.hovered ? "#3b4752" : "white"}
    Text{
        anchors.centerIn: parent;
        font.pixelSize: 48;
        color: btn.hovered ? "white" : "#787878"
        text: text1
    }
}
