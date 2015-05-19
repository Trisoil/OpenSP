import QtQuick 1.1

Rectangle {
    width:parent.width
    height:parent.height
    color:"#FF19160A"
    SysBtn
    {
        x:250
        y:250
        width:166
        height:66
        picNormal: "Image/check_normal.png"
        picHover: "Image/check_hover.png"
        picPressed: "Image/check_pressed.png"
        onClicked:
        {
            console.log("check btn clicked")
        }
    }

    Image {
        id: image1
        x: 650
        y: 10
        source: "Image/register_bg.png"

        AnimatedImage
        {
            fillMode:Image.PreserveAspectFit
            anchors.left: parent.left
            anchors.leftMargin: 100
            source: "Image/panda.gif"
        }
    }
}
