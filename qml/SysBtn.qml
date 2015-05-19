import QtQuick 1.1

Rectangle
{
    id:sysbtn

    property string picCurrent: ""
    property string picNormal: ""
    property string picHover: ""
    property string picPressed: ""
    signal clicked

    width: 27
    height: 22
    color:"#00000000"
    state:"normal"

    Image
    {
        source: picCurrent;
    }

    MouseArea
    {
        hoverEnabled: true
        anchors.fill: parent
        onEntered: sysbtn.state == "pressed" ? sysbtn.state = "pressed" : sysbtn.state = "hover"
        onExited: sysbtn.state == "pressed" ? sysbtn.state = "pressed" : sysbtn.state = "normal"
        onPressed: sysbtn.state == "pressed"?sysbtn.state="normal":sysbtn.state="pressed"
        onReleased:
        {
            //sysbtn.state = "normal"
            sysbtn.clicked()
        }
    }

    states:
    [
        State{
            name:"hover"
            PropertyChanges {
                target: sysbtn
                picCurrent:picHover
            }
        },
        State {
            name: "normal"
            PropertyChanges {
                target: sysbtn
                picCurrent:picNormal
            }
        },
        State {
            name: "pressed"
            PropertyChanges {
                target: sysbtn
                picCurrent:picPressed
            }
        }

    ]
}
