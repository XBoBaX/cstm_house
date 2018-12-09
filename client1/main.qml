import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import io.qt.examples.NetworkConnection 1.0
import "GlobalVariables.js" as GlobalVariables
import "button"

ApplicationWindow {
    id: root
    visibility: Window.Maximized
    visible: true
    minimumHeight: 900; minimumWidth: 1200
    title: qsTr("Вход")
    property string userName : "vova"
    property string selectHour
    property string selectMin
    property string selectDay
    property string selectMounth
    property string selectYear
    property string grap1 : "Декларация"
    property string grap2 : "Отправитель/Экспортер"
    property string grap3 : "1/" + (tovars.length+1)
    property string grap4 : "Отгрузочные спецификации"
    property string grap5 : "0" //Всего товаров
    property string grap6 : "0" //Всего мест
    property string grap7 : "Справочный номер"
    property string grap8 : "Получатель"
    property string grap9 : "Лицо, ответственное за финансовое урегулирование"
    property string grap10 : "Стр. перв.назн./ послед. отправил"
    property string grap11 : "Тор. страна/ Стр. произ."
    property string grap12 : "Сведения о стоимости"
    property string grap13 : "ЕСП"
    property string grap14 : "Декларант/Представитель"
    property string grap15 : "Страна отправителя/экспорта"
    property string grap15_1 : "Код страны отправителя/экспорта"
    property string grap16 : "Страна происхождения"
    property string grap17 : "Страна назначачения"
    property string grap17_1 : "Код страны назначачения"
    property string grap18 : "Идентификация и страна регистрации транспортного средства при отправлении/прибытии"
    property string grap19 : "Конт."
    property string grap20 : "Условия поставки"
    property string grap21 : "Идентификация и страна регистрации активного транспортного средства на границе"
    property string grap22 : "Валюта и общая сумма по счету"
    property string grap23 : "Курс валюты"
    property string grap24 : "Характер сделки"
    property string grap25 : "Вид транспорта на границе"
    property string grap26 : "Вид транспорта внутри страны"
    property string grap27 : "Место погрузки/разгрузки"
    property string grap28 : "Финансовые и банковские сведения"
    property string grap28_2//dsddsddввв
    property string grap29 : "Таможенный орган выезда/въезда"
    property string grap30 : "Местонахождение товара"
    property string grap31 : "Грузовые места и описание товаров"
    property string grap31_1 : "Грузовые места и описание товаров. Маркировка и количество - Номера контейнеров - Количество и отличительные особенности"
    property string grap32 : "Товар №"
    property string grap33 : "Код товара"
    property string grap34 : "Код страны происх."
    property string grap35 : "Вес брутто (кг)"
    property string grap36 : "Преференции"
    property string grap37 : "Процедура"
    property string grap38 : "Вес нетто (кг)"
    property string grap39 : "Квота"
    property string grap40 : "Общая декларация/Предварительный документ"
    property string grap41 : "Дополнительные единицы измерения"
    property string grap42 : "Цена товара"
    property string grap43 : "Метод определения стоимости"
    property string grap44 : "Доп. информ./Предст. док./Серт. и разр."
    property string grap44_1 : "Дополнительная информация"
    property string grap45 : "Корректировка"
    property string grap46 : "Статистическая стоимост"
    property string grap47 : "Начисление платежей"
    property string grap48 : "Отсрочка платежей"
    property string grap49 : "Реквизиты склада"
    property string grap50 : "Принципал"
    property string grap51 : "предп. таможенные органы"
    property string grap52 : "Гарантия не действительна для.."
    property string grap53 : "Таможенный орган (и страна) назначения"
    property string grap54
    property string country : "0"
    property string countryEng: "0"
    property string pntId
    property string pntName
    property string pntAdress
    property string pntEntry
    property variant graph: []
    property variant tovars: []
    property variant files: []
    property int tovar_count: 0
    property int files_count: 0
    property int count_graph: 0
    property int count_predmet: 0
    property int prevBtn: 1
    property string arrivaltime
    property bool usrFlag: false
    property string mail: ""
    property string phone: ""
    property string count: ""
    property string longitude2
    property string latitude2
    NetworkConnection {
        id: network
    }

    FontLoader{
        id: fontRoboto
        name: "fontRoboto"
        source: "qrc:/Roboto-Medium.ttf"
    }

    FontLoader{
        id: fontIcon
        name: "fontIcon"
        source: "qrc:/fontawesome-webfont.ttf"
    }

    Item{
        anchors.fill: parent
        //Выбранный блок из навигации
        Loader{
            id: loader_main;
            anchors.bottom: navigation.top; anchors.top: parent.top
            anchors.left: parent.left; anchors.right: parent.right
        }
        //Навигация
        Rectangle{
            id: navigation
            anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
            height: 120
            color: "#2b2e35";
            Item {
                anchors.left: parent.left; anchors.right: nav5.left
                anchors.top: parent.top; anchors.bottom: parent.bottom

                NavBttn{
                    id: nav1
                    textIcon: "\uf017"; text1: "назначение"
                    selected: true
                    onClicked: { selectedMenu(1) }
                }
                Rectangle{
                    id: nav1Dop
                    anchors.left: nav1.right
                    width: 600; height: 120; clip: true
                    color: "#fafafa"
                    Row{
                        NavBtnDop{
                            text1:"время\nи дата"; id: navDop1; selected: true
                            onClicked: selectDopMenu(1)
                        }
                        NavBtnDop{
                            text1:"место\nотправления"; id: navDop7;
                            onClicked: selectDopMenu(7)
                        }
                        NavBtnDop{
                            text1:"страна\nвъезда или\nвыезда"; id: navDop2
                            onClicked: selectDopMenu(2)
                        }
                        NavBtnDop{
                            text1:"пропускной\nпункт"; id: navDop3
                            onClicked: selectDopMenu(3)
                        }
                    }
                }

                NumberAnimation {
                    id: openRec
                    target: nav1Dop; property: "width"
                    duration: 200; from: 0; to: 600
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    id: closeRec
                    target: nav1Dop; property: "width"
                    duration: 200; from: 600; to: 0
                    easing.type: Easing.InOutQuad
                }

                NavBttn{
                    id: nav2
                    anchors.left: nav1Dop.right; anchors.leftMargin: 20
                    textIcon: "\uf018"; text1: "декларация"
                    onClicked: { selectedMenu(2) }
                }
                Rectangle{
                    id: nav2Dop
                    anchors.left: nav2.right
                    width: 0; height: 120; clip: true
                    color: "#fafafa"
                    Row{
                        NavBtnDop{
                            text1:"выбор\nшаблона"; id: navDop4; selected: true
                            onClicked: selectDopMenu(4)
                        }
                        NavBtnDop{
                            text1:"заполнение\nдекларации"; id: navDop5
                            onClicked: selectDopMenu(5)
                        }
                        NavBtnDop{
                            text1:"Добавление\nтоваров"; id: navDop6
                            onClicked: selectDopMenu(6)
                        }
                    }
                }

                NumberAnimation {
                    id: openRec2
                    target: nav2Dop; property: "width"
                    duration: 200; from: 0; to: 450
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    id: closeRec2
                    target: nav2Dop; property: "width"
                    duration: 200; from: 450; to: 0
                    easing.type: Easing.InOutQuad
                }
                NavBttn{
                    id: nav3
                    anchors.left: nav2Dop.right; anchors.leftMargin: 20
                    textIcon: "\uf15c"; text1: "документы"
                    onClicked: { console.log("gl:" + GlobalVariables.globalNowBttn); selectedMenu(3) }
                }
                NavBttn{
                    id: nav4
                    anchors.left: nav3.right; anchors.leftMargin: 20
                    textIcon: "\uf093"; text1: "предпросмотр"
                    onClicked: { selectedMenu(4) }
                }

            }
            NavBttn{
                id: nav5
                anchors.right: parent.right
                textIcon: "\uf138"; text1: "Далее"
                    onClicked: {
                    if (GlobalVariables.globalNowBttn == 1) selectedMenu(2)
                    else if (GlobalVariables.globalNowBttn == 2) {console.log("gl: " + GlobalVariables.globalNowBttn); selectedMenu(3)}
                    else if (GlobalVariables.globalNowBttn == 3) selectedMenu(4)
                    else if (GlobalVariables.globalNowBttn == 4) sendAll(1)
                }
            }
        }
        Loader{
            id: loader_signIn
            anchors.fill: parent
            source: "SingnIn.qml"
        }
        //Окно уведомления
        Popup {
            id: popup
            property alias popMessage: message.text
            property bool colorSelect: false
            property color errorColor: "#b44"
            property color successColor: "#369636"

            background: Rectangle {
                implicitWidth: root.width
                implicitHeight: 120
                color: popup.colorSelect ? popup.successColor : popup.errorColor
            }
            y: (root.height - 120)
            modal: true
            focus: true
            closePolicy: Popup.CloseOnPressOutside
            Text {
                id: message
                anchors.centerIn: parent
                font.pointSize: 32
                color: "white"
            }
            onOpened: popupClose.start()
        }

    }

    function setDec(){
        arrivaltime = selectYear + "-" + selectMounth + "-" + selectDay + " " + selectHour + ":" + selectMin + ":00";
        var obj = '{'
                +'"gp1" : "' + grap1.replace("\"", "'") + '",'
                +'"gp2" : "' + grap2.replace("\"", "'") + '",'
                +'"gp6" : "' + grap6.replace("\"", "'") + '",'
                +'"gp8" : "' + grap8.replace("\"", "'") + '",'
                +'"gp9" : "' + grap9.replace("\"", "'") + '",'
                +'"gp10" : "' + grap10.replace("\"", "'") + '",'
                +'"gp11" : "' + grap11.replace("\"", "'") + '",'
                +'"gp13" : "' + grap13.replace("\"", "'") + '",'
                +'"gp14" : "' + grap14.replace("\"", "'") + '",'
                +'"gp15" : "' + grap15.replace("\"", "'") + '",'
                +'"gp15_1" : "' + grap15_1.replace("\"", "'") + '",'
                +'"gp16" : "' + grap16.replace("\"", "'") + '",'
                +'"gp17" : "' + grap17.replace("\"", "'") + '",'
                +'"gp17_1" : "' + grap17_1.replace("\"", "'") + '",'
                +'"gp18" : "' + grap18.replace("\"", "'") + '",'
                +'"gp19" : "' + grap19.replace("\"", "'") + '",'
                +'"gp20" : "' + grap20.replace("\"", "'") + '",'
                +'"gp21" : "' + grap21.replace("\"", "'") + '",'
                +'"gp22" : "' + grap22.replace("\"", "'") + '",'
                +'"gp23" : "' + grap23.replace("\"", "'") + '",'
                +'"gp24" : "' + grap24.replace("\"", "'") + '",'
                +'"gp25" : "' + grap25.replace("\"", "'") + '",'
                +'"gp26" : "' + grap26.replace("\"", "'") + '",'
                +'"gp27" : "' + grap27.replace("\"", "'") + '",'
                +'"gp28" : "' + grap28.replace("\"", "'") + " " + grap28_2.replace("\"", "'") + '",'
                +'"gp28_2" : "' + grap28_2.replace("\"", "'") + '",'//s
                +'"gp29" : "' + grap29.replace("\"", "'") + '",'
                +'"gp30" : "' + grap30.replace("\"", "'") + '",'
                +'"gp49" : "' + grap49.replace("\"", "'") + '",'
                +'"gp50" : "' + grap50.replace("\"", "'") + '",'
                +'"gp52" : "' + grap52.replace("\"", "'") + '",'
                +'"gp53" : "' + grap53.replace("\"", "'") + '",'
                +'"country" : "' + countryEng + '",'
                +'"adress" : "' + pntAdress + '",'
                +'"arrivaltime" : "' + arrivaltime + '",'
                +'"gp54" : "' + root.selectYear + ". Месяц - " + root.selectMounth + ". День - " + root.selectDay + ". " + root.selectHour + ":" + root.selectMin + "\n" + root.pntAdress + '_._"'
               +'}';
        network.setDeclr(obj);
    }

    //Спрятать через
    Timer {
        id: popupClose
        interval: 3000
        onTriggered: popup.close()
    }
    function selectDopMenu(idButton){
        navDop1.selected = navDop2.selected = navDop3.selected = navDop4.selected = navDop5.selected = navDop6.selected = navDop7.selected = false
        if (prevBtn == 5) setDec();
        if (prevBtn == 6) {network.setProd(tovars); console.log(tovar_count + " aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")}

        prevBtn = idButton;
        switch(idButton){
        case 1:
            navDop1.selected = true; loader_main.source = "CalendarDatePicker.qml"
        break;
        case 2:
            navDop2.selected = true; loader_main.source = "SelectCountryPnt.qml"; root.title = qsTr("Выбор страны с въездом или выездом");
        break;
        case 3:
            if (root.country === "0") {
                popup.popMessage = "Выберите страну"; popup.colorSelect = false;
                popup.open();
                return
            }

            navDop3.selected = true; loader_main.source = "SelectPnt.qml"; root.title = qsTr("Выбор пропускного пункта в " + country);
        break;
        case 4:
            navDop4.selected = true; loader_main.source = "SelectTemplateDecl.qml";
            network.sendingTakePrewRec(root.userName);
        break;
        case 5:
            navDop5.selected = true; loader_main.source = "Declaration.qml"; root.title = qsTr("Заполнение декларации");
        break;
        case 6:
            navDop6.selected = true; loader_main.source = "AddItemDecl.qml"; root.title = qsTr("Добавление товаров");
        break;
        case 7:
            navDop7.selected = true;
            loader_main.source = "MapSelectStart.qml";
            root.title = qsTr("Выберете точку отправления");
        break;
        }

    } //f

    function selectedMenu(idButton){
        var gl = GlobalVariables.globalNowBttn
        if ((parseInt(gl)+parseInt(1)) < parseInt(idButton)) return
        if (GlobalVariables.globalNowBttn === idButton) return;
        if (GlobalVariables.globalNowBttn === 3) {
            console.log(idButton + " . files: " + files)
            network.setFiles(files);
        }

        nav1.selected = nav2.selected = nav3.selected = nav4.selected = false;
        nav5.text1 = "Далее"

        switch(idButton){
        case 1:
            console.log("Выбрал 1")
            nav1.selected = true;
            openRec.restart();
            if (nav2Dop.width != 0) closeRec2.restart();
            selectDopMenu(1);
            prevBtn = 1
            root.title = qsTr("Выбор даты и времени");
        break;
        case 2:
            console.log("Выбрал 2")
            nav2.selected = true; selectDopMenu(4);
            openRec2.restart(); root.title = qsTr("Выбор шаблона");
            if (nav1Dop.width != 0) closeRec.restart();
        break;
        case 3:
            console.log("Выбрал 3")
            if (prevBtn == 5) setDec();
            if (prevBtn == 6) {network.setProd(tovars); console.log(tovars + " aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")}
            if (nav2Dop.width != 0) closeRec2.restart();
            if (nav1Dop.width != 0) closeRec.restart();
            nav3.selected = true; loader_main.source = "DocumentAdd.qml"
            root.title = qsTr("Приложение остальных документов");
        break;
        case 4:
            console.log("Выбрал 4")
            if (prevBtn == 6) network.setProd(tovars);
            nav4.selected = true;
            if (nav2Dop.width != 0) closeRec2.restart();
            if (nav1Dop.width != 0) closeRec.restart();
            loader_main.source = "ASend.qml"
            nav5.text1 = "Отправить"
            root.title = qsTr("Предпросмотр перед отправкой");
        break;
        }
        GlobalVariables.globalNowBttn = idButton
    }

    function loginUser(uname, pword){
        if (uname === "" || pword === ""){
            popup.popMessage = "Заполните поля"
            popup.open()
            return
        }
        else {
            network.sendingSignUp(uname, pword);
        }
    }

    function registerUser(uname, pword, pword2){
        if (uname === "" || pword === "" || pword2 === ""){
            popup.popMessage = "Заполните поля"
            popup.open()
        }
        else if (pword !== pword2){
            popup.popMessage = "Пароли не совпадают"
            popup.open()
        }
        else {
            network.sendingRegister(uname, pword);
        }
    }

    function successEnter(success, username, userflag, mail, phone, count){
        console.log("______________" + username + " " + userflag + " " + mail + " " + phone + " " + count)
        root.usrFlag = userflag === 'true'
        root.mail = mail; root.phone = phone; root.count = count
        popup.popMessage = "Неверный логин или пароль"
        return success ? showMainMenu(username) : popup.open();
    }

    function setTimeMain(hour, min, year, mounth, day){
        root.selectHour = hour; root.selectMin = min
        root.selectMounth = mounth; root.selectDay = day; root.selectYear = year
        popup.popMessage = year + "-" + mounth + "-" + day + ". Время выбрано на " + selectHour + ":" + selectMin
        popup.colorSelect = true; popup.open(); selectDopMenu(7);
    }

    // Показать главное меню
    function showMainMenu(username){
        loader_signIn.visible = false; root.userName = username
        loader_main.source = "CalendarDatePicker.qml"
    }

    function answerRegister(message, username){
        if (message === "UserAlreadyEx") {
            popup.popMessage = "Такой пользователь уже существует";
            popup.open();
        }
        else {
            root.userName = username;
            loader_signIn.visible = false;
            showMainMenu(username)
        }
    }

    function fillModel(message){
        graph[count_graph] = message;
        console.log(graph[count_graph++])
    }

    function sendAll(){
        var obj = '{' //sdsdd
               +'"name" : "Raj",'
               +'"age"  : 32,'
               +'"married" : false'
               +'}';
        network.sendingRegisterRecord(obj)
    }
    function setRecordSuc(message){
        var json_temp = JSON.parse(message)
        var adress = json_temp["adress"]
        var arrivaltime = json_temp["arrivaltime"]
        pntAdress = adress
        var messageTo = "Прибыть в " + arrivaltime + ". На ПП: " + adress;
        popup.popMessage = messageTo;
        popupClose.interval = 30000
        popup.open();
        loader_main.source = "mapFinish.qml"
    }

    Connections{
        target: network
        onSuccessSignUp:{
            successEnter(success, username, userflag, mail, phone, count)
        }
        onRegisterAnswer:{
            answerRegister(message, username);
        }
        onSetRecord: {
            setRecordSuc(message);
        }
    }
}
