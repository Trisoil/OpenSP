import QtQuick 1.1

 Item {
     id: progressbar

     property int minimum: 0
     property int maximum: 100
     property int value: 0
     property alias color: gradient1.color
     property alias secondColor: gradient2.color

     width: 250; height: 23
     clip: true

     BorderImage {
         source: "Image/progressback.png"
         width: parent.width; height: parent.height
         border { left: 4; top: 4; right: 4; bottom: 4 }
     }

     Rectangle {
         id: highlight

         property int widthDest: ((progressbar.width * (value - minimum)) / (maximum - minimum) - 6)

         width: highlight.widthDest
         Behavior on width { SmoothedAnimation { velocity: 1200 } }
         color: "#232323"
         anchors { left: parent.left; top: parent.top; bottom: parent.bottom; margins: 3 }
         radius: 1
         gradient: Gradient {
             GradientStop { id: gradient1; position: 0.0 ;color: "#ffffff" }
             GradientStop { id: gradient2; position: 1.0 ;color: "#67C111"}
         }

     }
     Text {
         anchors { right: highlight.right; rightMargin: 6; verticalCenter: parent.verticalCenter }
         color: "#4F4F4F"
         font.bold: true
         text: Math.floor((value - minimum) / (maximum - minimum) * 100) + '%'
     }
 }
