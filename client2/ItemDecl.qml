import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    Rectangle{
        anchors.fill: parent; color: "white"
        Rectangle{
            id: head2
            anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
            height: 60; color: {return"white"}
            Button{
                id: txtNameFirst
                width: parent.width / 4; height: 60;
                background: Rectangle{ anchors.fill: parent; color: txtNameFirst.hovered ?"#cfe4ff":"white"}
                Text {
                    anchors.left: parent.left; anchors.leftMargin: 20; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text:"Код товара"
                }
            }
            Button{
                id: txtPriceAll
                anchors.left: txtNameFirst.right
                width: parent.width / 4; height: 60;
                background: Rectangle{ anchors.fill: parent; color: txtPriceAll.hovered ?"#cfe4ff":"white"}
                Text {
                    anchors.left: parent.left; anchors.leftMargin: 20; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text:"цена без пошлин"
                }
            }
            Button{
                id: txtPriceAdd
                anchors.left: txtPriceAll.right
                width: parent.width / 4; height: 60;
                background: Rectangle{ anchors.fill: parent; color: txtPriceAdd.hovered ?"#cfe4ff":"white"}
                onClicked: modelFill();
                Text {
                    anchors.left: parent.left; anchors.leftMargin: 20; anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text:"добавочная стоимость (с НДС)"
                }
            }
            Button{
                id: bttnAdd
                anchors.left: txtPriceAdd.right;
                width: parent.width / 4; height: 60; //visible: false
                background: Rectangle{anchors.fill: parent; color: bttnAdd.hovered ?"#3b4752":"#fafafa"}
                onClicked: {
                    codeTovar.text = ""; codeTovar.enabled = true;
                    opisTovar.text = "";
                    cntrTovar.text = "";
                    bruttoTovar.text = "";
                    prefTovar.text = "";
                    nettoTovar.text = "";
                    priceTovar.text = "";
                    phl.text = ""; //Добавить пошлину
                    ind.text = root.tovar_count + 1;
                    poshlina.enabled = true;
                    poshlina.text = ""
                    tovarSelect.visible = true;
                }
                Item {
                    anchors.centerIn: parent
                    width: txtAddIcon.width + txtAddItem.width; height: parent.height
                    Text {
                        id: txtAddIcon; anchors.verticalCenter: parent.verticalCenter
                        font.family:"fontawesome"; font.pixelSize: 32
                        text:"\uf055"; color: bttnAdd.hovered ?"white":"#787878"
                    }

                    Text {
                        id: txtAddItem; anchors.leftMargin: 10
                        anchors.left: txtAddIcon.right; anchors.verticalCenter: parent.verticalCenter
                        text:"добавить товар"; font.pointSize: 18; font.family:"fontRoboto"
                        color: bttnAdd.hovered ?"white":"#787878"
                    }
                }
            }
        }
        ListView {
            visible: !tovarSelect.visible
            anchors.top: head2.bottom; anchors.bottom: parent.bottom
            anchors.left: parent.left; anchors.right: parent.right; clip: true
            delegate: Button{
                id: item
                anchors.left: parent.left; anchors.right: parent.right; height: 60;
                background: Rectangle{anchors.fill: parent; color: item.hovered ?"#e9f2ff":"white"}
                Text{
                    id: txt1; width: parent.width / 4
                    anchors.left: parent.left; anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: code//"1234567890"
                }
                Text {
                    id: txt2; clip: true
                    width: parent.width / 4;
                    anchors.left: txt1.right;
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: price
                }
                Text {
                    id: txt3; clip: true
                    width: parent.width / 4;
                    anchors.left: txt2.right;
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: full1
                }
                Item {
                    id: recBtn;
                    width: parent.width / 4; height: 60
                    anchors.left: txt3.right;
                    Button{
                        id: btnEdit
                        visible: false
                        width: parent.width / 2; height: 60;
                        background: Rectangle{anchors.fill: parent; color: item.hovered ?"#e9f2ff":"white"}
                        Text{
                            anchors.centerIn: parent
                            font.family:"fontawesome"
                            font.pixelSize: 52
                            text:"\uf14b"; color: parent.hovered ?"#369636":"#787878"
                        }
                    }
                    Button{
                        id: btnRem
                        anchors.left: btnEdit.right
                        width: parent.width / 2; height: 60;
                        onClicked: itemDel(indexTov);
                        background: Rectangle{anchors.fill: parent; color: item.hovered ?"#e9f2ff":"white"}
                        Text{
                            anchors.centerIn: parent
                            font.family:"fontawesome"
                            font.pixelSize: 52
                            text:"\uf057"; color: parent.hovered ?"#b44":"#787878"
                        }
                    }

                }
                MouseArea{
                    anchors.top: parent.top; anchors.bottom: parent.bottom
                    anchors.left: parent.left; anchors.right: recBtn.left;
                    onClicked: selectBtn(tovId);
                }

            }
            model: ListModel{id:listModel}
        }
        Rectangle {
            id: noTovar; visible: false; color: "white"
            anchors.top: head2.bottom; anchors.bottom: parent.bottom
            anchors.left: parent.left; anchors.right: parent.right;
            Text{
                clip: true
                anchors.centerIn: parent
                font.pointSize: 72; font.bold: true; font.family:"fontRoboto"
                text: "Нет товара"

            }
        }
        Rectangle {
            id: tovarSelect; visible: false
            anchors.fill: parent
            Button {
                anchors.left: parent.left; anchors.top: parent.top;
                onClicked: tovarSelect.visible = false;
                height: 60; width: parent.width / 2
                id: btn
                background: Rectangle{anchors.fill: parent; color: btn.hovered ? "#3b4752" : "#fafafa"}
                Text{
                    anchors.centerIn: parent
                    font.pointSize: 24; font.family:"fontRoboto"
                    color: btn.hovered ? "white" : "#787878"
                    text: "Назад"
                }
            }
            Button {
                anchors.left: btn.right; anchors.top: parent.top;
                onClicked: editTovar(ind.text);
                height: 60; width: parent.width / 2
                id: btn2
                background: Rectangle{anchors.fill: parent; color: btn2.hovered ? "#3b4752" : "#fafafa"}
                Text{
                    anchors.centerIn: parent
                    font.pointSize: 24; font.family:"fontRoboto"
                    color: btn2.hovered ? "white" : "#787878"
                    text: "подтвердить"
                }
            }
            Text{id: ind; text: "0"; width: 0; height: 0;}
            Text{id: phl; text: "0"; width: 0; height: 0;}

            TextField{
                id: codeTovar; enabled: false;
                anchors.top: btn.bottom; height: 120;
                anchors.left: parent.left; anchors.right: parent.right
                font.pixelSize: 46; placeholderText: "Код товара"
            }
            TextField{
                id: opisTovar;
                anchors.top: codeTovar.bottom; height: 120;
                anchors.left: parent.left; anchors.right: parent.right
                font.pixelSize: 46; placeholderText: "Описание"
            }
            TextField{
                id: cntrTovar;
                anchors.top: opisTovar.bottom; height: 120;
                anchors.left: parent.left; anchors.right: parent.right
                font.pixelSize: 46; placeholderText: "страна происхождения"
            }
            TextField{
                id: bruttoTovar;
                anchors.top: cntrTovar.bottom; height: 120;
                anchors.left: parent.left; anchors.right: parent.right
                font.pixelSize: 46; placeholderText: "Брутто"
            }
            TextField{
                id: prefTovar;
                anchors.top: bruttoTovar.bottom; height: 120;
                anchors.left: parent.left; anchors.right: parent.right
                font.pixelSize: 46; placeholderText: "Преференц."
            }
            TextField{
                id: nettoTovar;
                anchors.top: prefTovar.bottom; height: 120;
                anchors.left: parent.left; anchors.right: parent.right
                font.pixelSize: 46; placeholderText: "Нетто"
            }
            TextField{
                id: priceTovar;
                anchors.top: prefTovar.bottom; height: 120;
                anchors.left: parent.left; anchors.right: parent.right
                font.pixelSize: 46; placeholderText: "Сумма сделки"
            }
            TextField{
                id: poshlina; placeholderText: "Пошлина"; enabled: false;
                anchors.top: priceTovar.bottom; height: 60; font.pixelSize: 38;
                anchors.left: parent.left; anchors.right: parent.right
            }
        }
    }
    function editTovar(){
        console.log("edit tovar ")
        if (poshlina.enabled == true) {
            phl.text = poshlina.text
            console.log("o net" + phl.text)
        }

        tovarSelect.visible = false;
        var index = ind.text;
        addItem(index);
    }
    function addTovarTemp(){
        root.tovar_count++;

    }

    function addItem(ind){
        if (ind > root.tovar_count) root.tovar_count++;
        console.log("addItem2 " + ind)
        root.tovars[ind] = "{\"code_tovar\": \"" + codeTovar.text + "\", \"graph31\": \"" + opisTovar.text.replace("\n", " ") + "\", \"graph34\": \"" + cntrTovar.text.replace("\n", " ") +
                "\", \"graph35\": \"" + bruttoTovar.text.replace("\n", " ") + "\",\"graph36\": \"" + prefTovar.text.replace("\n", " ") + "\", \"graph37\": \"" + nettoTovar.text.replace("\n", " ") + "\", \"graph38\": \"" + priceTovar.text.replace("\n", " ") +
                "\", \"pref\": \"" + phl.text + "\", \"full\": \"" + phl.text + "\"}";
        modelFill();
    }
    function selectBtn(index){
        console.log(index);
        var json_temp = JSON.parse(root.tovars[index])
        console.log(json_temp["code_tovar"]);
        codeTovar.text = json_temp["code_tovar"];
        opisTovar.text = json_temp["graph31"];
        cntrTovar.text = json_temp["graph34"];
        bruttoTovar.text = json_temp["graph35"];
        prefTovar.text = json_temp["graph36"];
        nettoTovar.text = json_temp["graph37"];
        priceTovar.text = json_temp["graph38"];
        phl.text = json_temp["full"];
        poshlina.text = "Пошлина: " + json_temp["full"] + "%";
        ind.text = index;
        codeTovar.enabled = false;
        poshlina.enabled = false;
        tovarSelect.visible = true;
    }
    function itemDel(index){
        var i = 0; var j = 0;
        for (i=0, j = 0;i<root.tovar_count;i++, j++){
            if (i === index) i++;
            root.tovars[j] = root.tovars[i]
        }
        root.tovar_count--;
        modelFill();
    }
    function modelFill(){
        listModel.clear();
        for (var i = 0; i < root.tovar_count; i++){
            console.log(root.tovars[i])
            var json_temp = JSON.parse(root.tovars[i])
            var addPrice = 0;
            var full_price = parseInt(json_temp["graph38"]); var poshlina = parseInt(json_temp["full"])
            addPrice = (poshlina * full_price) / 100;
            full_price += addPrice; addPrice += (full_price * 20) / 100
            listModel.append({tovId: i, indexTov: i, code: json_temp["code_tovar"], price: json_temp["graph38"], pref1: json_temp["pref"], full1: addPrice})
        }
        if (root.tovar_count === 0) noTovar.visible = true
        else noTovar.visible = false
    }
}
