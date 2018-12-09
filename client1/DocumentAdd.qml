import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2

Rectangle {
    anchors.fill: parent;
    Button{
        id: addBtn
        anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right; height: 120
        background: Rectangle{anchors.fill: parent; color: addBtn.hovered ? "#3b4752" : "#fafafa";}
        Text {
            anchors.centerIn: parent;
            font.pixelSize: 32; font.family: "fontRoboto";
            text: "Выбор файла"; color:  addBtn.hovered ? "white" : "#787878";
        }
        onClicked: fileDialog.visible = true
    }
    ListView{
        anchors.top: addBtn.bottom; anchors.bottom: parent.bottom;
        anchors.left: parent.left; anchors.right: parent.right
        clip: true

        delegate: Button{
            id: item;
            anchors.left: parent.left; anchors.right: parent.right;
            height: 80;
            background: Rectangle { anchors.fill: parent; color: item.hovered ?"#e9f2ff":"white"}
            Image {
                id: img
                height: 60
                anchors.left: parent.left; anchors.verticalCenter: parent.verticalCenter
                source: fileType; fillMode: Image.PreserveAspectFit
            }
            Text{
                anchors.left: img.right; anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 32; font.family:"fontRoboto"
                text: nameFile; wrapMode: Text.WordWrap
            }

            Button{
                id: txtDel;
                anchors.fill: parent
                visible: item.hovered
                background: Rectangle{anchors.fill: parent; color: "#33000000"}
                Text{
                    clip: true
                    anchors.centerIn: parent;
                    font.pointSize: 32; font.family:"fontRoboto"
                    text: "убрать файл"; wrapMode: Text.WordWrap
                }
                onClicked: {
                    itemDel(index);
                }
            }

            Text { id: txt01; visible: false; text: nameFile; }
            Text { id: ind; visible: false; text: index; }
        }
        model: ListModel{id:listModel1}
    }
    FileDialog {
        id: fileDialog
        title: "Выберите документы для дополнения"
        nameFilters: ["Документы (*.pdf *.doc *.docx)", "Сканы (*.jpg *.png)"]
        folder: shortcuts.home
        onAccepted: {
            var name = fileDialog.fileUrls + ""
            var sourceIm = ""
            console.log("You chose: " + name)
            console.log(name[name.indexOf(".") + 1])
            if (name[name.indexOf(".") + 1] === "p" && name[name.indexOf(".") + 2] === "d"){
                sourceIm = "qrc:/Images/selectFile/pdf.svg"
            }
            else if (name[name.indexOf(".") + 1] === "j"){
                sourceIm = "qrc:/Images/selectFile/jpg.svg"
            }
            else if (name[name.indexOf(".") + 1] === "p"){
                sourceIm = "qrc:/Images/selectFile/png.svg"
            }
            else if (name[name.indexOf(".") + 1] === "d"){
                sourceIm = name[name.indexOf(".") + 4] === -1 ? "qrc:/Images/selectFile/docx.svg" : "qrc:/Images/selectFile/doc.svg"
            }
            var nameShort = ""
            for (var i=name.lastIndexOf("/") + 1; i<=name.indexOf(".")-1; i++){
                nameShort += name[i];
            }

            listModel1.append({nameFile: nameShort, fileType: sourceIm})
            root.files[root.files_count] = name


            console.log(root.files[root.files_count])


            root.files_count += 1;
        }
        onRejected: {
            console.log("Canceled")
        }
        Component.onCompleted: visible = false;
    }

    Rectangle{color:{load();return "white"}}
    function load(){
        listModel1.clear();
        var sourceIm = ""
        var name = ""
        for (var i=0;i<root.files_count;i++){
            name = root.files[i] + ""
            if (name[name.indexOf(".") + 1] === "p" && name[name.indexOf(".") + 2] === "d"){
                sourceIm = "qrc:/Images/selectFile/pdf.svg"
            }
            else if (name[name.indexOf(".") + 1] === "j"){
                sourceIm = "qrc:/Images/selectFile/jpg.svg"
            }
            else if (name[name.indexOf(".") + 1] === "p"){
                sourceIm = "qrc:/Images/selectFile/png.svg"
            }
            else if (name[name.indexOf(".") + 1] === "d"){
                sourceIm = name[name.indexOf(".") + 4] === -1 ? "qrc:/Images/selectFile/docx.svg" : "qrc:/Images/selectFile/doc.svg"
            }
            var nameShort = ""
            for (var j=name.lastIndexOf("/") + 1; j<=name.indexOf(".")-1; j++){
                nameShort += name[j];
            }
            listModel1.append({nameFile: nameShort, fileType: sourceIm})
        }
    }

    function itemDel(index){
        var i = 0; var j = 0;
        for (i=0, j = 0;i<root.files_count;i++, j++){
            if (i === index) i++;
            root.files[j] = root.files[i]
        }
        listModel1.remove(index)
        root.files_count--;
    }
}
