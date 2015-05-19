import QtQuick 1.1
import QmlTest 1.0
Row
{
    id: sysbtngroup
    spacing: 0

    signal skin
    signal feedback
    signal menu
    signal min
    signal close

    /*SysBtn
    {
        id:skin
        picHover: "Image/skin_hover.png"
        picNormal: "Image/skin_normal.png"
        picPressed: "Image/skin_pressed.png"
        onClicked:
        {
            console.log("skin btn clicked")
            sysbtngroup.skin()
        }
    }

    SysBtn
    {
        id:feedback
        picHover: "Image/feedback_hover.png"
        picNormal: "Image/feedback_normal.png"
        picPressed: "Image/feedback_pressed.png"
        onClicked:
        {
            console.log("feedback btn clicked")
            sysbtngroup.feedback()
        }
    }*/
    QQmlTest{
        id:qmltest
    }
    SysBtn
    {
        id:menu
        picHover: "Image/menu_hover.png"
        picNormal: "Image/menu_normal.png"
        picPressed: "Image/menu_pressed.png"
        onClicked:
        {
            console.log("menu btn clicked")
            sysbtngroup.menu()
            qmltest.spInfo()
        }
    }


    SysBtn
    {
        id:min
        picHover: "Image/min_hover.png"
        picNormal: "Image/min_normal.png"
        picPressed: "Image/min_pressed.png"
        onClicked:
        {
            console.log("min btn clicked")
            sysbtngroup.min()

        }
    }

    SysBtn
    {
        id:close
        picHover: "Image/close_hover.png"
        picNormal: "Image/close_normal.png"
        picPressed: "Image/close_pressed.png"
        onClicked:
        {
            console.log("close btn clicked")
            sysbtngroup.close()
        }
    }
}
