import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import "button"

Page {
    id: loginPage
    background: Rectangle {
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#375677";
            }
            GradientStop {
                position: 1.00;
                color: "#182941";
            }
        }
    }

    Item {
        id: iconRect
        width: parent.width
        height: parent.height / 3
        Text {
            id: icontext
            text: "\uf13e"
            anchors.centerIn: parent
            font.pointSize: 112
            font.family: "fontawesome"
            color: mainAppColor
        }
    }

    ColumnLayout {
        width: parent.width
        anchors.top: iconRect.bottom
        spacing: 15

        TextField {
            id: loginUsername
            placeholderText: "Логин"
            Layout.preferredWidth: parent.width - 20
            Layout.alignment: Qt.AlignHCenter
            color: mainTextCOlor
            font.pointSize: 14
            font.family: "fontawesome"
            leftPadding: 30
            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 50
                radius: implicitHeight / 2
                color: "transparent"

                Text { //Иконка
                    text: "\uf007"
                    font.pointSize: 14
                    font.family: "fontawesome"
                    color: mainAppColor
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: 10
                }

                Rectangle { //Нижняя полоска
                    width: parent.width - 10
                    height: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    color: mainAppColor
                }
            }
        }


        TextField {
            id: loginPassword
            placeholderText: "Пароль"
            Layout.preferredWidth: parent.width - 20
            Layout.alignment: Qt.AlignHCenter
            color: mainTextCOlor
            font.pointSize: 14
            font.family: "fontawesome"
            leftPadding: 30
            echoMode: TextField.Password
            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 50
                radius: implicitHeight / 2
                color: "transparent"

                Text {
                    text: "\uf023"
                    font.pointSize: 14
                    font.family: "fontawesome"
                    color: mainAppColor
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: 10
                }

                Rectangle {
                    width: parent.width - 10
                    height: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    color: mainAppColor
                }
            }
        }

        Item {
            height: 20
        }
        CButton{
            height: 50
            Layout.preferredWidth: loginPage.width - 20
            Layout.alignment: Qt.AlignHCenter
            name: "Вход"
            baseColor: mainAppColor
            borderColor: mainAppColor
            onClicked: {
                loginUser(loginUsername.text, loginPassword.text)
            }
        }
    }

}
