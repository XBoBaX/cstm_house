import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.6
import QtQuick.Controls 2.2

Item {
    property string country: "nan"
    property string start1: "false"
    property string end1: "false"
    ListModel {id: someModel}
    Map{
        id: map
        anchors.fill: parent
        plugin: Plugin{name: "osm"}
        center: QtPositioning.coordinate(48.117,29.266)
        zoomLevel: 9
        RouteModel {
            id: routeModel
            plugin: map.plugin
            query: RouteQuery{id: routeQuery}
            Component.onCompleted: {
                update()
            }
        }
        MapItemView{
            model: routeModel
            delegate: Component {
                MapRoute{
                    route: routeData
                    line.color: "blue"
                    line.width: 4
                    opacity: 0.8
                }
            }
        }


        MapItemView {
            model: someModel
            delegate: MapQuickItem{
                coordinate: QtPositioning.coordinate(lat, lon)
                sourceItem: Image {
                    id: image
                    source: "qrc:/Images/mapPoint.png";
                    width: 40; height: 40
                }
                anchorPoint.x: image.width / 2
                anchorPoint.y: image.height
            }
        }
        MapQuickItem {
            id:marker
            visible: false
            sourceItem: Image{
                id: image1
                source: "qrc:/Images/mapPoint.png"
                width: 40; height: 40
            }
            coordinate: QtPositioning.coordinate(49.3841, 34.86)
            anchorPoint.x: image1.width / 2
            anchorPoint.y: image1.height
        }

        MouseArea {
            enabled: start1 == "false" ? false : true
            anchors.fill: parent
            onClicked: {
                marker.visible = true
                marker.coordinate = map.toCoordinate(Qt.point(mouse.x,mouse.y))
                selectStart1.latitude1 = marker.coordinate.latitude
                selectStart1.longitude1 = marker.coordinate.longitude
                root.latitude2 = marker.coordinate.latitude
                root.longitude2 = marker.coordinate.longitude
                selectStart1.selectPoint();
            }
        }

    }
    Timer {
        id: timer
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }

    Component.onCompleted: {
        console.log("Completed Running2! ")
        delay(1000, function() {
            print("And I'm printed after 1 second!")
            someModel.clear();
            if (end1 !== "false"){
                console.log("1111111111111111111111")
                setPoint("moldova", root.pntAdress)
                return
            }
            if (country == "nan"){
                setPoint("moldova", "f")
                setPoint("roman", "f")
                setPoint("hungary", "f")
                setPoint("slovakia", "f")
                setPoint("poland", "f")
                setPoint("belarus", "f")
                setPoint("russia", "f")
            }
            else setPoint(country, "f")
        })
    }

    function setPoint(country, adress){
        console.log(country + " " + end1 + " " + start1 + "  " + adress)
        var listEng = ["moldova", "roman", "hungary", "slovakia", "poland", "belarus", "russia", "Crimea"]
        var list = []; var list2 = []; var listAdress = [];
        switch(listEng.indexOf(country)){
        case 0:
            list = [48.4564, 48.2590, 48.1438100, 48.4003300, 46.3375970, 46.4125, 47.4059, 47.7309, 46.7612,
                    46.6082, 45.4537, 46.4727, 46.0815, 45.9412, 48.1435]
            list2 = [27.7682, 26.5847, 28.7357730, 27.0028420, 29.9866520, 30.2615, 29.3374, 29.2490, 29.9737,
                     29.9319, 28.2832, 30.3604, 29.1211, 28.8612, 28.7346]
            listAdress = ["Могилів-Подільський – Отач", "Мамалига - Крива", "Болган - Хрістова", "Россошани - Брічень",
                          "Старокозаче - Тудора", "Маяки-Удобне-Паланка", "Платонове - Гоянул Ноу",
                          "Станіславка- Веренкеу", "Кучурган – Первомайськ", "Слов’яносербка – Ближній Хутір",
                          "Градинці – Незавертайлівка", "Рені – Джюрджюлешть", "Табаки-Мирне",
                          "Виноградівка-Вулкенєшть", "Нові Трояни – Чадир Лунга"]
            break;
        case 1:
            list = [48.01691, 47.9440, 47.9881]; list2 = [23.00890, 23.8786, 26.0610]
            listAdress = ["Дякове - Халмеу", "Солотвино-Сігету Мармацієй", "Порубне - Сірет"]
            break;
        case 2:
            list = [48.4312, 48.1689, 48.1112]; list2 = [22.2091, 22.5976, 22.8372]
            listAdress = ["Чоп-Захонь", "Лужанка – Берегшурань", "Вилок-Тісабеч"]
            break;
        case 3:
            list = [48.5627]; list2 = [22.1643]
            listAdress = ["Ужгород-Вишнє Нємецьке"]
            break;
        case 4:
            list = [51.1983, 49.95605, 49.8015, 50.2723]
            list2 = [23.8956, 23.12072, 22.9741, 23.5906]
            listAdress = ["Ягодин - Дорогуск", "Краківець-Корчова", "Шегині - Медика", "Рава-Руська-Хребенне"]
            break;
        case 5:
            list = [51.5633, 51.5395, 51.5007, 51.403, 51.8260, 51.8262]
            list2 = [29.0783, 27.8432, 30.5909, 29.351, 26.7015, 24.3140]
            listAdress = ["Виступовичі - Нова Рудня", "Вільча – Олександрівка", "Майдан-Копищанський – Глушкевичі",
                          "Славутич - Комарині", "Нові Яриловичі-Нова Гута\"", "Городище - Верхній Теребежів",
                          "Прикладники - Невель", "Доманове-Мокрани\""]
            break;
        case 6:
            list = [51.2000, 552.3373, 52.29514, 49.3794, 49.6063, 49.7673, 51.2567]
            list2 = [34.9366, 33.2942, 32.64745, 40.1453, 39.7068, 38.9299, 34.2579]
            listAdress = ["Сеньківка-Нові Юрковичі, Веселівка", "Гремяч - Погар", "Миколаївка - Ломаківка",
                          "Мілове-Чертково", "Просяне– Бугайовка", "Танюшівка – Ровеньки", "Рижівка – Тьоткіно"]
            break;
        }
        for (var i=0; i<list.length;i++) someModel.append({lat: list[i], lon: list2[i]})
        if (adress !== "f"){
            console.log(list[listAdress.indexOf(adress)])
            console.log(list2[listAdress.indexOf(adress)])
            routeQuery.clearWaypoints()
            routeQuery.addWaypoint(QtPositioning.coordinate(list[listAdress.indexOf(adress)],list2[listAdress.indexOf(adress)]))
            routeQuery.addWaypoint(QtPositioning.coordinate(root.latitude2, root.longitude2))
            routeModel.update();
            var list0 = routeQuery.waypoints
            for (var j=0;j<list0.length;j++){
                console.log(list0[j])
            }
        }
    }
}
