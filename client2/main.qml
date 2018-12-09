import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import io.qt.examples.NetworkConnection 1.0
import "button"

ApplicationWindow { //kokjsdfdsdfd1d
    id: root
    width: 420
    height: 680
    visible: true
    title: qsTr("Контроль грузопотоков")
    property color backGroundColor : "#394454"
    property color mainAppColor: "#6fda9c"
    property color mainTextCOlor: "#f0f0f0"
    property color popupBackGroundColor: "#b44"
    property color popupTextCOlor: "#ffffff"
    property string username: "0"
    property string oplata: "0"
    property variant grap: []
    property variant tovars: []
    property variant users: []
    property variant adress: []
    property variant max: []
    property variant min: []
    property variant sr: []
    property variant wait: []
    property variant countZap: []
    property variant realwait: []
    property variant mounthList: []
    property int countUs: 0
    property int countAd: 0
    property int tovar_count: 0
    property bool admin: false
    property int allCount: 0
    property int maxMounth
    property variant week: []
    property variant weekMax: []

    NetworkConnection {
        id: network
    }

    FontLoader {
        id: fontAwesome
        name: "fontawesome"
        source: "qrc:/fontawesome-webfont.ttf"
    }

    FontLoader{
        id: fontRoboto
        name: "fontRoboto"
        source: "qrc:/Roboto-Medium.ttf"
    }

    StackView{
        id: stackView
        focus: true
        anchors.fill: parent
    }

    Component.onCompleted: {
        stackView.push("qrc:/LogInPage.qml")   //Инициализация страницы логина
    }

    //Окно уведомления
    Popup {
        id: popup
        property alias popMessage: message.text

        background: Rectangle {
            implicitWidth: root.width
            implicitHeight: 60
            color: popupBackGroundColor
        }
        y: (root.height - 60)
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        Text {
            id: message
            anchors.centerIn: parent
            font.pointSize: 12
            color: popupTextCOlor
        }
        onOpened: popupClose.start()
    }
    Timer {
        id: popupClose
        interval: 2000
        onTriggered: popup.close()
    }

    function loginUser(uname, pword){
        if (uname === "" || pword === ""){
            popup.popMessage = "Заполните поля"
            popup.open()
            return
        }
        else {
            network.sendingSignUp(uname, pword);
            console.log("Отправка на сервер");
        }
    }

    function successEnter(success, messageNumber, admin, count1, count2, users1, list2, list3, list4, list5, list6, list7, list8){
        if (admin === "yes") root.admin = true
        else root.admin = false
        var list = users1.split(","); var countL = list3.split(","); var adressL = list2.split(","); var maxL = list4.split(",");
        var minL = list5.split(","); var srL = list6.split(","); var waitL = list7.split(","); var realwaitL = list8.split(",");

        countUs = parseInt(count1);
        countAd = parseInt(count2);
        for (var j = 0; j < parseInt(count1); j++){
            users[j] = list[j];
        }
        for (var j2 = 0; j2 < parseInt(count2); j2++){
            adress[j2] = adressL[j2];
            countZap[j2] = countL[j2];
            max[j2] = maxL[j2];
            min[j2] = minL[j2];
            sr[j2] = srL[j2];
            wait[j2] = waitL[j2];
            realwait[j2] = realwaitL[j2];
        }
        for (var i=0; i<32;i++){
            grap[i] = ""
        }
        network.getAllStat();
        popup.popMessage = "Неверный логин или пароль"
        return success ? showMainMenu(messageNumber) : popup.open();
    }
    function logoutSession()
    {
        stackView.push("qrc:/LogInPage.qml")
        root.minimumWidth = 420; root.minimumHeight = 680
        root.width = 420; root.height = 680;
    }

    // Показать главное меню ваsdsdsfdfdfrnnnb;ааfddfsfdfsdfsSDsd
    function showMainMenu(messageNumber)
    {
        username = messageNumber
        stackView.replace("qrc:/MainMenu.qml", {"numberBranch": messageNumber})
        console.log(messageNumber)
        root.width = Screen.width; root.height = Screen.height - 60
        root.setX(0); root.setY(30);
        root.minimumHeight = 900; root.minimumWidth = 1000

    }
    function setStat(count, mounth, week){
        root.allCount = parseInt(count)
        var list = mounth.split(",")
        var list2 = week.split(",")
        root.maxMounth = list[0];
        for (var i=0;i<12;i++){
            root.mounthList[i] = list[i];
            if (root.maxMounth < list[i]){
                root.maxMounth = list[i]
            }
        }
        for (i=0;i<list2.length;i++){
            root.week[i] = list2[i];
        }
        console.log(root.week)
        console.log(root.mounthList)
    }

    Connections{
        target: network
        onSuccessSignUp:{
            successEnter(success, messageNumber, admin, count1, count2, users1, list2, list3, list4, list5, list6, list7, list8)
        }
        onSucGetAllStat:{
            setStat(count, mounth, week);
        }
    }
}
