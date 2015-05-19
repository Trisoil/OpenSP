import QtQuick 1.1

MouseArea{
     anchors.fill: parent
     property  variant previousPosition
     property  int prevX
     property  int prevY
     onPressed: {
         previousPosition=Qt.point(mouseX,mouseY)
         prevX=parent.x
         prevY=parent.y
     }
     onPositionChanged: {
         if (pressedButtons == Qt.LeftButton){
             var dx = mouseX - previousPosition.x
             var dy = mouseY - previousPosition.y
             parent.x=parent.x+dx
             parent.y=parent.y+dy
         }
     }
     onReleased: {
         parent.x=prevX
         parent.y=prevY
     }
}
