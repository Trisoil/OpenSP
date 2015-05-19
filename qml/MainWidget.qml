import QtQuick 1.1

Rectangle {
    id:widget
    width:parent.width
    height:parent.height
    color:"white"
    state:"hide"

    property int index: 0

    states:
    [
        State
        {
            name:"active"
            PropertyChanges
            {
                target: widget
                x:parent.x
            }

        },
        State
        {
            name:"hide"
            PropertyChanges
            {
                target: widget
                x:parent.x - width
            }
        }

    ]

    transitions:
    [
        Transition
        {
            PropertyAnimation
            {
                property:"x"
                duration: 500
                easing.type: Easing.OutBounce
                easing.amplitude: 0.1
            }
        }
    ]
}
