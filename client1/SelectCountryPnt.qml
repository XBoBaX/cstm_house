import QtQuick 2.9
import "GlobalDecl.js" as GlobalDecl
import "button"

Rectangle {
    id: recSelectCstmHs;
    color: "#1f2228"; anchors.fill: parent;
    Text {
        id: txtSelcCH; font.family: "fontRoboto"; font.pixelSize: 42
        text: "ВЫБОР СТРАНЫ ПЕРЕСЕЧЕНИЯ"; color: "white"
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.topMargin: 25; anchors.top: parent.top
    }
    Item {
        id: itemGrid
        anchors.top: txtSelcCH.bottom; anchors.topMargin: 25;
        anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
        Grid{
            anchors.fill: parent
            leftPadding: itemGrid.width / 9
            rightPadding: itemGrid.width / 9
            columns: 4; spacing: itemGrid.width / 9;

            BtnFlag{country: "qrc:/Images/flags/moldabia.svg"; textCnt: "Молдавия"}
            BtnFlag{country: "qrc:/Images/flags/roman.svg"; textCnt: "Румыния"}
            BtnFlag{country: "qrc:/Images/flags/hungary.svg"; textCnt: "Венгрия"}
            BtnFlag{country: "qrc:/Images/flags/slovakia.svg"; textCnt: "Словакия"}
            BtnFlag{country: "qrc:/Images/flags/poland.svg"; textCnt: "Польша"}
            BtnFlag{country: "qrc:/Images/flags/belarus.svg"; textCnt: "Беларусь"}
            BtnFlag{country: "qrc:/Images/flags/russia.svg"; textCnt: "Россия"}
            BtnFlag{country: "qrc:/Images/flags/Crimea.png"; textCnt: "Крым"}
        }
    }
    function selectCstmHs(country){
        var listRus = ["Молдавия", "Румыния", "Венгрия", "Словакия", "Польша", "Беларусь", "Россия", "Крым"]
        var listEng = ["moldova", "roman", "hungary", "slovakia", "poland", "belarus", "russia", "Crimea"]
        root.country = country.toUpperCase();
        root.countryEng = listEng[listRus.indexOf(country)];
        network.sendingTakeChpnts(listEng[listRus.indexOf(country)])
        selectDopMenu(3)
    }
}
