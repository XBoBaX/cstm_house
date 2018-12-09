import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import "button"

Rectangle {
    color: "white"
    Rectangle{
        id: blockSignIn
        anchors.centerIn: parent
        width: parent.width/3; height: parent.height - parent.height/3;
        color: "#f7f7f7"
        Text {
            id: logo
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "fontIcon"
            font.pixelSize: parent.width / 3
            text: "\uf086"; color: "#bdbdbc"
        }
        Item{
            id: blockForm;
            height: 160;
            width: parent.width - 60
            anchors.top: logo.bottom;
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle{
                id: loginBlock; color: "white"
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width; height: 80;
                TextInput {
                    id: inputLogin; clip: true; font.pixelSize: 36
                    anchors.left: parent.left; anchors.right: parent.right;
                    anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
                    Text{
                        id: textInputlogin
                        text: "Введите логин"; color: "#787878";
                        font.pixelSize: 36; font.family: "fontRoboto"
                        visible: !inputLogin.text
                    }
                }
            }
            DropShadow {
                anchors.fill: loginBlock
                horizontalOffset: 1; verticalOffset: 1
                radius: 8; samples: 17
                source: loginBlock; color: inputLogin.focus ? "#448bfc" : "#dadada"
            }
            Rectangle{
                id: passwordBlock; color: "white"
                anchors.top: loginBlock.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width; height: 80;
                TextInput {
                    id: inputPassword; clip: true; font.pixelSize: 36;
                    echoMode: TextField.Password
                    anchors.left: parent.left; anchors.right: parent.right;
                    anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
                    Text{
                        id: textInputPassword
                        text: "Введите пароль"; color: "#787878";
                        font.pixelSize: 36; font.family: "fontRoboto"
                        visible: !inputPassword.text
                    }
                }
            }
            DropShadow {
                anchors.fill: passwordBlock
                horizontalOffset: 1; verticalOffset: 1
                radius: 8; samples: 17
                source: passwordBlock; color: inputPassword.focus ? "#448bfc" : "#dadada"
            }
            Rectangle{
                id: passwordBlock2; color: "white"
                anchors.top: passwordBlock.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width; height: 0; visible: false
                TextInput {
                    id: inputPassword2; clip: true; font.pixelSize: 36;
                    echoMode: TextField.Password;
                    anchors.left: parent.left; anchors.right: parent.right;
                    anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
                    Text{
                        id: textInputPassword2;
                        text: "Повторите пароль"; color: "#787878";
                        font.pixelSize: 36; font.family: "fontRoboto"
                        visible: !inputPassword2.text
                    }
                }
            }
            DropShadow {
                anchors.fill: passwordBlock2
                horizontalOffset: 1; verticalOffset: 1
                radius: 8; samples: 17
                source: passwordBlock2; color: inputPassword2.focus ? "#448bfc" : "#dadada"
            }

            NumberAnimation {
                target: blockForm; id: blockFormHeightOne
                property: "height"
                duration: 200
                from: 160; to: 240;
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: blockForm; id: blockFormHeightTwo
                property: "height"
                duration: 200
                from: 240; to: 160;
                easing.type: Easing.InOutQuad
            }
        }
        Button {
            width: parent.width - 60; height: 80; id: enterBtn
            anchors.top: blockForm.bottom; anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            hoverEnabled: true
            background: Rectangle {
                color: parent.hovered ? "#357ae8" : "#3a85ff";
                radius: 5
            }
            Text{
                anchors.centerIn: parent;
                color: "white"; font.pixelSize: 36;
                text: "Вход"
            }
            onClicked: {loginUser(inputLogin.text, inputPassword.text)}
        }
        Button {
            width: parent.width - 60; height: 80; id: regBtn
            anchors.top: blockForm.bottom; anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            hoverEnabled: true; visible: false
            background: Rectangle {
                color: parent.hovered ? "#357ae8" : "#3a85ff";
                radius: 5
            }
            Text{
                anchors.centerIn: parent;
                color: "white"; font.pixelSize: 36;
                text: "Зарегистрироваться"
            }
            onClicked: { registerUser(inputLogin.text, inputPassword.text, inputPassword2.text)}
        }

        Button{
            id: regBtnOrLog
            anchors.right: parent.right; width: parent.width / 2
            anchors.bottom: parent.bottom; height: 80;
            hoverEnabled: true
            onClicked: {
                textRegLog.text = textRegLog.text == "Регистрация" ? "Вход" : "Регистрация"
                passwordBlock2.height = passwordBlock2.height ? 0 : 80
                passwordBlock2.visible = !passwordBlock2.visible
                enterBtn.visible = !enterBtn.visible;
                regBtn.visible = !regBtn.visible
                if (blockForm.height == 160) blockFormHeightOne.restart();
                else blockFormHeightTwo.restart();
            }
            Rectangle{
                anchors.fill: parent; color: "#f7f7f7";
                Text{
                    id: textRegLog
                    color: "#3a85ff";
                    anchors.centerIn: parent
                    font.underline: regBtnOrLog.hovered
                    font.pixelSize: 36; text: "Регистрация";
                }
            }
        }
    }


    DropShadow {
        anchors.fill: blockSignIn
        horizontalOffset: 1
        verticalOffset: 1
        radius: 8
        samples: 17
        source: blockSignIn
        color: "#aa000000"
    }
}
