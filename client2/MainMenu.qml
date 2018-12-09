import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "button"

Page {

    id: mainMenu
    property string numberBranch: "temp"

    background:
        Rectangle {
        color: "#1c2227"
    }

    Loader{
        id: loader_main
        anchors.top: parent.top
        anchors.left: column.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        source: "MenuAdd.qml"

    }

    //Меню
    Item{
        width: 100
        height: parent.height
        id: column

        Rectangle {
            id: mToolBar
            height: parent.height
            width: parent.width
            color: "#1c2227"
        }

        Rectangle{
            id: logo
            width: mToolBar.width
            height: exit.height
            anchors.top: parent.top
            color: "transparent"
            Text {
                id: logoText
//                text: "\uf197"
                color: "white"
                anchors.centerIn: parent
                font.pointSize: 42
                font.family: "fontawesome"
            }
        }

        MButton{
            id: toolAdd
            width: mToolBar.width
            height: exit.height
            anchors.top: logo.bottom
            text: "\uf044"
            font.pointSize: 42
            font.family: "fontawesome"
            colorText: "#2892ce"
            select: true
            onClicked: {
                loader_main.source = "MenuAdd.qml"
                selectMenu(1)
            }
        }
        MButton{
            id: toolAnalitic
            anchors.top: toolAdd.bottom
            width: mToolBar.width
            height: exit.height
            text: "\uf06e"
            font.pointSize: 42
            font.family: "fontawesome"
            colorText: "#b69247"
            onClicked: {
                console.log(root.admin)
                if (root.admin){
                    loader_main.source = "MenuAnalis.qml"
                    selectMenu(2)
                }
                else {
                    loader_main.source = "MenuAnalitic.qml"
                    selectMenu(2)
                }
            }
        }
        MButton{
            id: toolStatus
            visible: root.admin
            anchors.top: toolAnalitic.bottom
            width: mToolBar.width
            height: exit.height
            text: "\uf075"
            font.pointSize: 42
            font.family: "fontawesome"
            colorText: "#c0615e"
            onClicked: {
                loader_main.source = "MenuAnalis2.qml"
                selectMenu(3)
            }
        }
        MButton{
            id: exit
            anchors.bottom: parent.bottom
            width: mToolBar.width
            height: 80
            text: "\uf08b"
            font.pointSize: 42
            font.family: "fontawesome"
            colorText: "#182121"
            onClicked: logoutSession()
            exit: hovered ? false : true
        }

    }



    //Изменение состояния активности
    function selectMenu(mButtonSelect){
        toolAdd.select = false
        toolAnalitic.select = false
        toolStatus.select = false
        switch (mButtonSelect){
        case 1:
            toolAdd.select = true
            break
        case 2:
            toolAnalitic.select = true
            break
        case 3:
            toolStatus.select = true
            break
        }
    }


}
