import QtQuick 1.1
Row{
   id:colorrow

   signal change
   spacing: 3
   property int currentIndex: 0
   property  variant colorArray: ["#FFFFAEC9","#67c111", "#ea7025","#3C3C3C","#ed1941","#ffe600","#d9d6c3","#543044"]
   Repeater{
       model:8
       Rectangle{
       width:24
       height: 24
       property int colorIndex: index
       color:colorrow.colorArray[index]
       border.color:Qt.lighter(color)
       MouseArea{
           anchors.fill: parent
           onPressed: {
               colorrow.currentIndex=colorIndex
               colorrow.change()
           }
       }
       }
   }
}
