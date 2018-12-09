import QtQuick 2.9

Rectangle
{

    property bool commonBorder : true

    property int lBorderwidth : 0
    property int rBorderwidth : 0
    property int tBorderwidth : 0
    property int bBorderwidth : 0

    z : -1

    property string borderColor : "white"

    color: borderColor

    anchors
    {
        left: parent.left
        right: parent.right
        top: parent.top
        bottom: parent.bottom

        topMargin    : -tBorderwidth
        bottomMargin : -bBorderwidth
        leftMargin   : -lBorderwidth
        rightMargin  : -rBorderwidth
    }
}
