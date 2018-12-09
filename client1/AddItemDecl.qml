import QtQuick 2.9
import QtQuick.Controls 2.2
import "AllGlobal.js" as AllGlobal
import "button"

Rectangle{
    id: root2
    anchors.fill: parent;

    property string code_tovar
    property string graph31 //описание
    property string graph34 //Код страны
    property string graph35 //Вес бруто
    property string graph36 //Преференц
    property string graph37 //Нетто
    property string graph38 //цена
    property string full11 //пошлина
    property string pref11 //льгота
    property int nowGraph: 31
    Rectangle{
        id: head2
        anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
        height: 60; color: {root2.color ="white"; return"white"}
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
            width: parent.width / 4; height: 60
            background: Rectangle{anchors.fill: parent; color: bttnAdd.hovered ?"#3b4752":"#fafafa"}
            onClicked: rootAdd.visible = true;
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
    ListView{
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
        }
        model: ListModel{id:listModel}

    }

    Rectangle{
        id: rootAdd2
        color:"white"; height: parent.height; width: parent.width; visible: false
        Item{
            id: headTxt1; height: 60; width: parent.width / 3;
            anchors.left: parent.left; anchors.leftMargin: 20;
            Text{
                width: parent.width;  anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 18; font.family:"fontRoboto"
                text:"код товара"
            }
        }
        Item{
            id: headTxt2; height: 60; width: parent.width / 3; anchors.left: headTxt1.right;
            Text{
                width: parent.width; anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 18; font.family:"fontRoboto"
                text:"наименование товара"
            }
        }
        Button{
            anchors.left: headTxt2.right; height: 60; width: parent.width / 3; id: btnClose
            background: Rectangle{anchors.fill: parent; color: btnClose.hovered ?"#3b4752":"#fafafa"}
            Text{
                anchors.centerIn: parent; color: btnClose.hovered ?"white":"#787878"
                font.pointSize: 18; font.family:"fontRoboto"; text:"вернуться назад"
            }
            onClicked: {removeGroup()}
        }

        ListView{
            anchors.top: btnClose.bottom; anchors.bottom: parent.bottom; clip: true
            anchors.left: parent.left; anchors.right: parent.right
            delegate: Button{
                id: item2; clip: true
                anchors.left: parent.left; anchors.right: parent.right;
                height: {
                    if (txt02.height < 60) return 60;
                    else txt02.height + 25
                }
                background: Rectangle{anchors.fill: parent; color: item2.hovered ?"#e9f2ff":"white"}
                Text{
                    id: txt01; width: parent.width / 3
                    anchors.left: parent.left; anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: code1; wrapMode: Text.WordWrap
                }
                Text {
                    id: txt02; clip: true
                    width: parent.width / 3;
                    anchors.left: txt01.right;
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 18; font.family:"fontRoboto"
                    text: name1; wrapMode: Text.WordWrap
                }
                Text { id: txt03; visible: false; text: full1; }
                Text { id: txt04; visible: false; text: pref1; }

                onClicked: selectGroup2(code1, full1, pref1)
            }
            model: ListModel{id:listModel1}
        }

    }

    Rectangle{
        id: rootAdd;
        visible: false;
        color:"white"; height: parent.height; width: parent.width
        Text {
            id: txtSelcCH; font.family:"fontRoboto"; font.pixelSize: 42
            text:"НАИМЕНОВАНИЕ ТОВАРА"
            color:"#1f2228"
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.topMargin: 25; anchors.top: parent.top
        }
        Flickable{
            anchors.top: txtSelcCH.bottom; anchors.topMargin: 25; anchors.bottom: parent.bottom
            anchors.left: parent.left; anchors.right: parent.right
            contentHeight: rootAdd.height * 3; clip: true
            Grid{
                anchors.fill: parent
                spacing: 20; columns: 2
                Repeater{
                    model: ["(01-05)животные. продукты\nживотного происхождения","(06-14)Продукты растительного\nпроисхождения","(15)Жиры и масла жив. или рас. происхождения;\n воски жив. или рас. происхождения","(16-24)готовые пищевые продукты; алк. и безалк.\n напитки и уксус; табак и его заменители","(25-27)минеральные продукты","(28-38)продукция хим. и связанных с ней\nотраслей промышленности",
                   "(39-40)полимерные мат, пластмассы и\nизделия из них; каучук, резина","(41-43)кож. сырье, кожа, натур. мех и изделия из них;\nдорожные принадлежности, сумки и т.п","(44-46)древесина и изделия из древесины; пробка;\n изделия из соломы, альфы; плетеные изделия","(45-49)масса из древесины;\nбумага, картон и изделия из них","(50-63)текстиль и текстильные\nизделия",
                   "(64-67)обувь. головные уборы, зонты от дождя и\nсолнца, трости, хлысты, кнуты и их части","(68-70)изделия из камня, гипса, цемента, асбеста,\nслюды или аналогичных материалов; стекло.","(71)жемчуг. драг и полудраг камни, металлы;\nбижутерия; монеты","(72-83)недрагоценные металлы и\nизделия из них","(84-85)мех. оборуд; машины и механизмы; устр.\nдля воспроизведения звука\воспроизведения",
                   "(86-89)транспортные средства, оборудование\n и устройства, связанные с транспортом","(90-92)оптические, фотоизмер, киноматограф, \nизмерит, мед. или хир. аппараты","(93)оружие и боеприпасы;\nих части и принадлежности","(94-96)Разные товары\nи изделия","(97-99)Произведения искусства, предметы\n коллекционирования и антиквариат"]
                    BtnSelectItem{iconT:"qrc:/Images/categories/"+ (index+1) +".png"; textMain: modelData; onClicked: selectGroup(index)}
                }

            }
        }
    }

    Rectangle{
        id: rootAdd31
        visible: false; anchors.fill: parent
        Text {
            id: txtInput31; font.family:"fontRoboto"; font.pixelSize: 42
            text:"ГРУЗОВЫЕ МЕСТА И ОПИСАНИЕ ТОВАРОВ"
            color:"#1f2228"
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.topMargin: 25; anchors.top: parent.top
        }

        Flickable{
            anchors.topMargin: 25; anchors.top: txtInput31.bottom;
            anchors.left: parent.left; anchors.right: parent.right; anchors.bottom: flick.top
            contentHeight: txtPrevius.height; clip: true
            Text{
                id: txtPrevius; text: "код товара(33): " + code_tovar + "\nописание(31): "
                + graph31 + "\nкод страны происхождения(34):  " + graph34 + "\nбруто(34):  " + graph35 +
                "\nпреферц.(35): " + graph36 + "\nнетто(36): " + graph37 + "\nцена(38): " + graph38
                font.family:"fontRoboto"; font.pixelSize: 42
                color:"#787878"; padding: 25
            }
        }
        Button{
            anchors.left: parent.left; anchors.bottom: parent.bottom;
            width: parent.width / 2; height: 60; id: btnClose31
            background: Rectangle{anchors.fill: parent; color: btnClose31.hovered ?"#3b4752":"#fafafa"}
            Text{
                anchors.centerIn: parent; color: btnClose31.hovered ?"white":"#787878"
                font.pointSize: 18; font.family:"fontRoboto"; text:"вернуться назад"
            }
            onClicked: {cLoseGroup()}
        }
        Button{
            anchors.right: parent.right; anchors.left: btnClose31.right; anchors.bottom: parent.bottom; height: 60;
            id: btnAdd31
            background: Rectangle{anchors.fill: parent; color: btnAdd31.hovered ?"#3b4752":"#fafafa"}
            Text{
                anchors.centerIn: parent; color: btnAdd31.hovered ?"white":"#787878"
                font.pointSize: 18; font.family:"fontRoboto"; text:"следующий пункт"
            }
            onClicked: {nextMenu()}
        }
        Flickable{
            id: flick
            anchors.left: parent.left; anchors.right: parent.right; anchors.bottom: btnClose31.top; height: parent.height / 3
            clip: true; contentHeight: textEditInput.paintedHeight + 20

            function ensureVisible(r){
                if (contentX >= r.x) contentX = r.x;
                else if (contentX+width <= r.x+r.width)contentX = r.x+r.width-width;
                if (contentY >= r.y) contentY = r.y;
                else if (contentY+height <= r.y+r.height) contentY = r.y+r.height-height;
            }
            TextEdit{
                id: textEditInput
                width: flick.width; height: flick.height
                padding: 20
                font.family: "fontRoboto"; font.pixelSize: 28
                wrapMode: TextEdit.Wrap
                onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
                Text {
                    id: placholderInput; visible: !textEditInput.text
                    font.family: "fontRoboto"; font.pixelSize: 28; color: "#787878"
                    padding: 20
                    text: "Здесь сосредотачивают всю информацию о товарах, необходимую бухгалтеру для\nучета их количества. А именно: наименование, описание, количество, коммерческие,\nтехнические и качественные характеристики. Также здесь приводят сведения об упаковке и маркировке товаров"
                }
            }

            Rectangle{
                anchors.top: textEditInput.top; width: parent.width; height: 2; color: "#e8e8e8"
            }
        }

    }

    Rectangle{color: {modelFill(); return "white";} visible: false;}
    SequentialAnimation{
        id: selectGroupAn
        ParallelAnimation { // Анимация для календаря
            NumberAnimation {
                target: rootAdd
                property:"x"
                duration: 300; from: 0; to: root2.width;
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: rootAdd
                property:"opacity"
                duration: 300; from: 1; to: 0;
                easing.type: Easing.InOutQuad
            }
        }
        onRunningChanged: {
            if (!running){ rootAdd.x = 0; rootAdd.opacity = 1; rootAdd.visible = false;}
        }
    }
    function removeGroup(){
        listModel1.clear(); rootAdd2.visible = false;
    }

    function nextMenu(){
        switch(nowGraph){
        case 31:
            graph31 = textEditInput.text;
            placholderInput.text = "В ней фиксируют код страны происхождения товара согласно Классификатору\n Государств мира, утвержденному приказом Госкомстата Украины от 08.07.02 г. № 260.\n Источники данных для заполнения этой графы — Сертификат или декларация о происхождении товаров"
            textEditInput.text = ""
            txtInput31.text = "СТРАНА ПРОИСХОЖДЕНИЯ"
            break;
        case 32:
            graph34 = textEditInput.text;
            placholderInput.text = "Вес бруто (кг)"
            textEditInput.text = ""
            txtInput31.text = "ВЕС БРУТО"
            break;
        case 33:
            graph35 = textEditInput.text;
            placholderInput.text = "В этой графе собраны все льготы в налогообложении, предусмотренные для товаров,\nописание которых приведено в гр. 31. Их заносят в одну строку с использованием кодов из\nКлассификаторов льгот при обложении таможенной пошлиной, акцизным сбором и НДС,\n утвержденных приказом № 1048, следующим образом: на первом месте через знак\n \"/\" проставляют код льготы в уплате таможенной пошлины, на втором — акцизным сбором и на третьем — в обложении НДС.\nОб отсутствии льготы свидетельствует код \"000\""
            textEditInput.text = ""
            txtInput31.text = "ПРЕФЕРЕНЦИЯ"
            break;
        case 34:
            graph36 = textEditInput.text;
            placholderInput.text = "Тут записывают чистый вес товара, описание которого приведено"
            txtInput31.text = "ВЕС НЕТТО"
            textEditInput.text = ""
            break;
        case 35:
            graph37 = textEditInput.text;
            placholderInput.text = "В гр. 42 указывают фактурную стоимость (контрактную стоимость, приведенную,\n допустим, в счете-фактуре) каждого наименования товара в гривне по курсу НБУ на момент принятия ГТД \nк оформлению, который берут из гр. 23 \"Курс валюти\"."
            txtInput31.text = "ЦЕНА ТОВАРА"
            textEditInput.text = ""
            break;
        case 36:
            graph38 = textEditInput.text;
            placholderInput.text = ""; txtInput31.text = ""; textEditInput.text = ""
            addItem();
            rootAdd2.visible = false; rootAdd31.visible = false;
            modelFill();
            break;
        }
        nowGraph = nowGraph + 1
    }

    function addItem(){
        root.tovars[root.tovar_count] = "{\"code_tovar\": \"" + code_tovar + "\", \"graph31\": \"" + graph31.replace("\n", " ") + "\", \"graph34\": \"" + graph34.replace("\n", " ") +
                "\", \"graph35\": \"" + graph35.replace("\n", " ") + "\",\"graph36\": \"" + graph36.replace("\n", " ") + "\", \"graph37\": \"" + graph37.replace("\n", " ") + "\", \"graph38\": \"" + graph38.replace("\n", " ") +
                "\", \"pref\": \"" + pref11 + "\", \"full\": \"" + full11 + "\"}";
        root.tovar_count = root.tovar_count + 1;
        code_tovar = graph31 = graph34 = graph35 = graph36 = graph37 = graph38 = ""
    }

    function selectGroup(index){
        rootAdd2.visible = true
        selectGroupAn.restart();
        var list = [];
        var list2 = [];

        switch(index){
        case 0: list = ["Животные","Мясо и съедобные субпродукты","Рыба и ракообразные, моллюски и прочие водные беспозвоночные","Молоко и молочные продукты; яйца птицы; натуральный мед; пищевые продукты животного происхождения, в другом месте не поименованные","Продукты животного происхождения, в другом месте не поименованные"]; list2 = ["01","02","03","04","05"]; break;
        case 1: list = ["Живые деревья и другие растения; луковицы, корни и другие аналогичные части растений; срезанные цветы и декоративная зелень","Овощи и некоторые съедобные корнеплоды и клубни","Съедобные плоды и орехи; кожуры цитрусовых или дынь","Кофе, чай, мате, или парагвайский чай, и пряности","зерновые культуры","Продукция мукомольно-крупяной промышленности; солод; крахмалы; инулин; пшеничная клейковина","Продукция мукомольно-крупяной промышленности; солод; крахмалы; инулин; пшеничная клейковина","Шеллак природный неочищенный; камеди, смолы и прочие растительные соки и экстракты","Растительные материалы для изготовления плетеных изделий; прочие продукты растительного происхождения, в другом месте не поименованные"]; list2 = ["06","07","08","09","10","11","12","13","14"]; break;
        case 2: list = ["Жиры и масла животного или растительного происхождения; продукты их расщепления; готовые пищевые жиры; воски животного или растительного происхождения"]; list2 = ["15"]; break;
        case 3: list = ["Готовые пищевые продукты из мяса, рыбы или ракообразных, моллюсков или прочих водных беспозвоночных","Сахар и кондитерские изделия из сахара","Какао и продукты из него","Готовые продукты из зерна злаков, муки, крахмала или молока ; мучные кондитерские изделия","продукты переработки овощей, плодов или других частей растений","Разные пищевые продукты","Алкогольные и безалкогольные напитки и уксус","Остатки и отходы пищевой промышленности; готовые корма для животных","Табак и промышленные заменители табака"]; list2 = ["16","17","18","19","20","21","22","23","24"]; break;
        case 4: list = ["Соль; сера; земли и камней; штукатурные материалы, известь и цемент","Руды, шлак и зола","Топливо минеральные, нефть и продукты их перегонки; битуминозные вещества; воски минеральные"]; list2 = ["25","26","27"]; break;
        case 5: list = ["Продукты неорганической химии: неорганические или органические драгоценных металлов, редкоземельных металлов, радиоактивных элементов или изотопов","Органические химические соединения","Фармацевтическая продукция","Удобрения","Экстракты дубильные или красящие; танины и их производные, красители, пигменты и другие красящие вещества, краски и лаки; шпатлевки и прочие мастики; чернила, тушь","Эфирные масла и резиноиды; парфюмерные, косметические и туалетные препараты","Мыло, поверхностно-активные органические вещества, моющие средства, смазочные материалы, воски искусственные и готов и, составы для чистки или полировки, свечи и аналогичные изделия, пасты для лепки, пластилин, \"зубоврачебный воск\"и составы на основе гипса для стоматологии","Белковые вещества; модифицированные крахмалы; клеи; ферменты","Взрывчатые вещества; пиротехнические изделия; спички; пирофорные сплавы, некоторые горючие материалы","Фото- и кинотовары","Прочие химические продукты"]; list2 = ["28","29","30","31","32","33","34","35","36","37","38"]; break;
        case 6: list = ["Пластмассы и изделия из них","Каучук, резина и изделия из них"]; list2 = ["39","40"]; break;
        case 7: list = ["Шкуры необработанные (кроме натурального и искусственного меха) и выделанная кожа","Изделия из кожи, шорно-седельные изделия и упряжь; дорожные принадлежности, сумки и аналогичные товары, изделия из кишок животных (кроме волокна из натурального шелка)","Натуральное мех, изделия из него"]; list2 = ["41","42","43"]; break;
        case 8: list = ["Древесина и изделия из древесины, древесный уголь","Пробка и изделия из него","Изделия из соломы, травы эспарто и других материалов, используемых для плетения; корзиночные изделия и плетеные изделия"]; list2 = ["44","45","46"]; break;
        case 9: list = ["Масса из древесины или из других волокнистых целлюлозных материалов; бумага или картон, полученные из отходов и макулатуры","Бумага и картон, изделия из бумажной массы, бумаги или картона","Печатные периодические издания и другие изделия полиграфической промышленности; рукописи машинописные тексты и планы"]; list2 = ["47","48","49"]; break;
        case 10: list = ["Шелк","Шерсть, тонкий или грубый волос животных; пряжа и ткань из конского волоса","Хлопок","Прочие растительные текстильные волокна; пряжа и ткани из бумажной пряжи","Химические нити; ленточные и подобной нити из химических материалов","химических штапельные волокна","Вата, войлок и нетканые материалы; специальная пряжа; бечевки, веревки, канаты и тросы и изделия из них","Ковры и прочие текстильные напольные покрытия","Специальные ткани; тафтинговые текстильные материалы; кружева; гобелены; украсят ные материалы; вышивка","Текстильные материалы, пропитанные, с покрытием или дублированные; текстильные изделия технического назначения","Трикотажные полотна","Одежда и принадлежности к одежде, трикотажные","Одежда и принадлежности к одежде, текстильные, кроме трикотажных","Прочие готовые текстильные изделия; наборы, одежда и текстильные изделия, бывшие в употреблении; тряпье"]; list2 = ["50","51","52","53","54","55","56","57","58","59","60","61","62","63"]; break;
        case 11: list = ["Обувь, гетры и аналогичные изделия и их части","Головные уборы и их части","Зонты, солнцезащитные зонты, трости, палици- сиденья, хлысты, кнуты для верховой езды и их части","Обработанные перья и пух и изделия из них; искусственные цветы; изделия из человеческого волоса"]; list2 = ["64","65","66","67"]; break;
        case 12: list = ["Изделия из камня, гипса, цемента, асбеста, слюды или аналогичных материалов","Керамические изделия","Стекло и изделия из стекла"]; list2 = ["68","69","70"]; break;
        case 13: list = ["Жемчуг природный или культивированный, драгоценные или полудрагоценные камни, драгоценные металлы, металлы, плакированные драгоценными металлами, и изделия из них; бижутерия; монеты"]; list2 = ["71"]; break;
        case 14: list = ["Черные металлы","Изделия из черных металлов","Медь и изделия из нее","Никель и изделия из него","Алюминий и изделия из него","Свинец и изделия из него","Цинк и изделия из него","Олово и изделия из него","Прочие недрагоценные металлы; металлокерамика; изделия из них","Инструменты, ножевые изделия, ложки и вилки из недрагоценных металлов; их части из недрагоценных металлов","Прочие изделия из недрагоценных металлов"]; list2 = ["72","73","74","75","76",,"78","79","80","81","82","83"]; break;
        case 15: list = ["Реакторы ядерные, котлы, машины, оборудование и механические устройства; их части","Электрические машины, оборудование и их части; аппаратура для записи и воспроизведения звука, телевизионная аппаратура для записи и воспроизведения изображения и звука, их части и принадлежности"]; list2 = ["84","85"]; break;
        case 16: list = ["Железнодорожные локомотивы или моторные вагоны трамвая, подвижной состав и их части; путевое оборудование и устройства для железных дорог или трамвайных путей и их части; механическое (включая электромеханическое) сигнализационное оборудование всех видов","Средства наземного транспорта, кроме железнодорожного или трамвайного подвижного состава, их части и оборудование","Летательные аппараты, космические аппараты и их части","Суда, лодки и другие плавучие средства"]; list2 = ["86","87","88","89"]; break;
        case 17: list = ["Прилади та апарати оптичні, фотографічні, кінематографічні, контрольні, вимірювальні, прецизійні; медичні або хірургічні; їх частини та приладдя","Годинники всіх видів та їх частини","Музичні інструменти; частини та приладдя до них"]; list2 = ["90","91","92"]; break;
        case 18: list = ["Оружие, боеприпасы, их части и принадлежности"]; list2 = ["93"]; break;
        case 19: list = ["Мебель; постельные принадлежности, матрацы, матрацные основы, диванные подушки и аналогичные набивные принадлежности мебели, светильники и осветительные приборы, в другом месте не поименованные; световые указатели, табло и аналогичные изделия; сборные строительные конструкции","Игрушки, игры и спортивный инвентарь их части и принадлежности","Разные готовые изделия"]; list2 = ["94","95","96"]; break;
        case 20: list = ["Произведения искусства, предметы коллекционирования и антиквариат","Товары"]; list2 = ["97","99"]; break;
        }
        for (var i=0; i<list.length;i++){
            listModel1.append({code1: list2[i], name1: list[i], full1: "", pref1: ""})
        }
    }
    function selectGroup2(index, full1, pref1){
        full11 = full1; pref11 = pref1
        listModel1.clear()
        console.log(index.length)
        if (index.length < 5) network.sendingTakeGroup(index);
        else {
            nowGraph = 31
            code_tovar = index
            txtInput31.text = "ГРУЗОВЫЕ МЕСТА И ОПИСАНИЕ ТОВАРОВ"
            placholderInput.text = "Здесь сосредотачивают всю информацию о товарах, необходимую бухгалтеру для\nучета их количества. А именно: наименование, описание, количество, коммерческие,\nтехнические и качественные характеристики. Также здесь приводят сведения об упаковке и маркировке товаров"
            textEditInput.text = ""
            console.log(index)
            rootAdd.visible = false
            rootAdd31.visible = true
        }
    }
    function selectGroup3(message){
        var json_temp = JSON.parse(message)
        var list_temp = json_temp["chpnts"]
        for (var i=0; i<list_temp.length; i++){
            listModel1.append({full1: list_temp[i]["full"].toString(), pref1: list_temp[i]["pref"].toString(),
                                  code1: list_temp[i]["code"], name1: list_temp[i]["name"].replace(/^\s+|\s+$/g, "")})
        }
    }
    function cLoseGroup(){
        rootAdd31.visible = false
    }

    function modelFill(){
        console.log("root.tovar_count: " + root.tovar_count)
        listModel.clear();
        for (var i = 0; i < root.tovar_count; i++){
            console.log(root.tovars[i])
            var json_temp = JSON.parse(root.tovars[i])
            var addPrice = 0;
            var full_price = parseInt(json_temp["graph38"]); var poshlina = parseInt(json_temp["full"])
            addPrice = (poshlina * full_price) / 100;
            full_price += addPrice; addPrice += (full_price * 20) / 100
            listModel.append({indexTov: i, code: json_temp["code_tovar"], price: json_temp["graph38"], pref1: json_temp["pref"], full1: addPrice})
        }
    }
    function itemDel(index){
        var list2 = root.tovars;
        root.tovars = [];
        var i=0; var j=0;
        for (i=0,j=0;i<root.tovar_count;i++,j++){
            if (i === index) i++;
            root.tovars[j] = list2[i]
        }
        root.tovar_count--;
        modelFill();
    }

    Connections{
        target: network
        onTakeGroup:{
            selectGroup3(message)
        }
    }
}
