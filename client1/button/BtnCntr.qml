import QtQuick 2.0
import QtQuick.Controls 2.2
import "../GlobalDecl.js" as GlobalDecl

Flickable{
    id: grid_list
    contentHeight: 14500
    Column{
        Repeater{
            model: 235
            Button{
                id: btn
                width: grid_list.width; height: 60;
                background: Rectangle{ anchors.fill: parent; color: btn.hovered ? "#e9f2ff" : "white" }
                onClicked: selectCountry(btnGrap, GlobalDecl.country_code[index], GlobalDecl.country_rus[index])
                Text {
                    id: txt1; clip: true
                    width: parent.width / 3;
                    anchors.left: parent.left; anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family: "fontRoboto"
                    text: GlobalDecl.country_rus[index]
                }
                Text {
                    id: txt2; clip: true
                    width: parent.width / 3;
                    anchors.left: txt1.right; anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family: "fontRoboto"
                    text: GlobalDecl.country_code[index]
                }
                Text {
                    id: txt3; clip: true
                    width: parent.width / 3;
                    anchors.left: txt2.right; anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family: "fontRoboto"
                    text: GlobalDecl.country_world[index]
                }
            }
        }
    }
}
