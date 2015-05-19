import QtQuick 1.1

Rectangle {
    id:warnning

    property int mywidth:536
    property int myheight:313
    property int fontsize:16
    signal ok
    signal cancel
    width: mywidth
    height:myheight
    Image{
        id:back
        x:0
        y:0
        width: parent.width;height:parent.height
        source:"Image/Warning.png"
        /*MouseArea{
            anchors.fill: parent
            property variant previousPosition
            height: 40
            onPressed: {
                previousPosition = Qt.point(mouseX, mouseY)
            }
            onPositionChanged: {
                if (pressedButtons == Qt.LeftButton) {
                    var dx = mouseX - previousPosition.x
                    var dy = mouseY - previousPosition.y
                    window.pos = Qt.point(window.pos.x + dx,
                                                window.pos.y + dy)
                }
            }
        }*/
        Text{
            id:ltitle
            x: back.x+mywidth*(192/536)
            y: back.y+myheight*(8/313)
            color: "#fafafa"
            text: qsTr("Warnning")
            font.pointSize: fontsize+12
        }
        Text{
            id:lcontent
            x: back.x+mywidth*(68/536)
            y: back.y+myheight*(91/313)
            width: back.width-mywidth*(138/536)
            height: back.height-myheight*(295/313)
            color: "#ececda"
            text: qsTr("当前串口被其他进程占用，将无法进行相关")
            font.pointSize: fontsize
        }
        Text {
            id: lcontent1
            x: back.x+mywidth*(68/536)
            y: back.y+myheight*(129/313)
            width: back.width-mywidth*(138/536)
            height: back.height-myheight*(295/313)
            color: "#f8f8f7"
            text: qsTr("串口的操作，请确认占用串口的程序并关闭")
            font.pointSize: fontsize
        }
        Image{
            id:ok
            x:back.x+mywidth*(328/536)
            y:back.y+myheight*(204/313)
            width: back.width-mywidth*(436/536)
            height:back.height-myheight*(263/313)
            source: "Image/Ok.png"
            Text{
                id:ac
                x: ok.width*(19/100)
                y: ok.height*(10/50)
                text: qsTr("取消")
                font.pointSize: fontsize+7
            }
            MouseArea
            {
                anchors.fill: parent
                onReleased:
                {
                    warnning.ok()
                }
            }
        }
        Image{
            id:cancel
            signal clicked
            x:back.x+mywidth*(113/536)
            y:back.y+myheight*(204/313)
            width: back.width-mywidth*(436/536)
            height:back.height-myheight*(263/313)
            source: "Image/Cancel.png"
            Text{
                id:canc
                x: ok.width*(19/100)
                y: ok.height*(10/50)
                text: qsTr("确定")
                font.pointSize: fontsize+7
            }
            MouseArea
            {
                anchors.fill: parent
                onReleased:
                {
                    warnning.cancel()
                }
            }
        }
    }
}
