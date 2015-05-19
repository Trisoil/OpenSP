import QtQuick 1.1
Rectangle {
    id:comboBox
    property variant items: ["test0", "test1", "test2", "test3"]
    property alias selectedItem: chosenItemText.text;
    property alias selectedIndex: listView.currentIndex;
    signal comboClicked;
    width: 110;
    height: 30;
    smooth:true;
    Rectangle {
        id:chosenItem
        radius:0;
        width:parent.width;
        height:comboBox.height;
        color: "#2EB3FF"
        smooth:true;
        Text {
            anchors.top: parent.top;
            anchors.left: parent.left;
            anchors.margins: 3;
            anchors.verticalCenter: parent.verticalCenter
            id:chosenItemText
            text:comboBox.items[0];
            font.family: "Arial"
            font.pointSize: 10;
            smooth:true
        }
        MouseArea {
            anchors.fill: parent;
            onClicked: {
                comboBox.state = comboBox.state==="dropDown"?"":"dropDown"
            }
        }
    }
    Rectangle {
        id:dropDown
        width:comboBox.width;
        height:0
        clip:true;
        radius:0;
        anchors.top: chosenItem.bottom;
        anchors.topMargin: 2
        color: "lightgray"
        Rectangle{
            id: dropDownMask
            height: 3
            width:parent.width
            anchors.bottom: listView.top
        }
        ListView {
            id:listView
            height:250
            width: dropDown.width-4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: dropDownMask.bottom
            anchors.topMargin: -1
            z:1
            model: comboBox.items
            currentIndex: 0
            delegate: Item{
                width:listView.width;
                height: comboBox.height;
                Rectangle {
                    id: mouseMoveHighLight
                    width:listView.width;
                    height:comboBox.height;
                    color: "#55FF55";
                    opacity: 0
                    radius: 4
                    z:0
                }
                Text {
                    text: modelData
                    anchors.top: parent.top;
                    anchors.left: parent.left;
                    anchors.margins: 5;
                    font.pointSize: 10;
                    z:1
                }
                MouseArea {
                    anchors.fill: parent;
                    hoverEnabled: true
                    onClicked: {
                        comboBox.state = ""
                        var preSelection = chosenItemText.text
                        chosenItemText.text = modelData
                        if(chosenItemText.text != preSelection){
                            comboBox.comboClicked();
                        }
                        listView.currentIndex = index;
                    }
                    onEntered: mouseMoveHighLight.opacity = 0.5;
                    onExited: mouseMoveHighLight.opacity = 0;
                }
            }
            highlight: Rectangle {
                width:listView.width;
                height:comboBox.height;
                color: "green";
                radius: 0
            }
        }
        MouseArea{
            anchors.fill: dropDown
            hoverEnabled: true
            onExited: {
                if(!containsMouse)
                    comboBox.state = "";
            }
        }
    }
    states: State {
        name: "dropDown";
        PropertyChanges { target: dropDown; height:18*comboBox.items.length+4 }
    }
    transitions: Transition {
        NumberAnimation { target: dropDown; properties: "height"; easing.type: Easing.OutExpo; duration: 200 }
    }
}
