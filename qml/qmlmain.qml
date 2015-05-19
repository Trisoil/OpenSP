import QtQuick 1.1
import Myconsole 1.0
import MyImage 1.0
//import QtQuick.Controls 1.2
//import QtQuick.Controls.Styles 1.2
Item {
    id: root
Rectangle {
     id: page
     x: 0
     width: 1000; height: 600
     color: mycolor
     property string mycolor: "#FF3C3C3C"//"#FF19160A"
     Behavior on mycolor { ColorAnimation {duration: 2000 } }
     QMyconsole{
     id:qmyconsole
     }
     Rectangle {
         id: skinpic
         x: 0
         y: 0
         width: 1000
         height: 40
         color:"#383A4C"
         //fillMode: Image.PreserveAspectFit
         //sourceSize.height: 60
         //sourceSize.width: 1600
         //source: "Image/Title.png"
         Image {
             id: icosmall
             width: 40
             height: 40
             source: "Image/icosmall.png"
         }
         Text {
             id: title
             x: 52
             y: 5
             color: "#ffffff"
             text: qsTr("OpenSP")
             font.strikeout: false
             font.bold: true
             font.family: "Courier"
             wrapMode: Text.WordWrap
             font.pointSize: 21

             Text {
                 id: title1
                 x: 115
                 y: 8
                 color: "#ffffff"
                 text: qsTr("V1.0")
                 font.pointSize: 16
                 font.family: "Courier"
                 font.bold: false
                 font.strikeout: false
                 wrapMode: Text.WordWrap
             }
         }
         QMyImage{
             id:qmyimage
         }
         MouseArea {
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
         }
         Rectangle
         {
             id: set
             x: 13
             y: 197
             width:237
             height:390
             color:"#383A4C"
             //source: "Image/Setting.png"
             DropWhere{}
             SetBackColor{
                 id:backcolor
                 x: 12
                 y: 62
                 width: 213
                 height: 26
                 onChange: {
                   page.mycolor=colorArray[currentIndex]
                 }
             }
             Text {
                 id: spset8
                 x: 20
                 y: 38
                 width: 98
                 height: 12
                 color: "#ffffff"
                 text: qsTr("程序背景色设定：")
                 font.pointSize: 10
                 font.family: "Arial"
             }
             Text {
                 id: spset7
                 x: 13
                 y: 15
                 width: 78
                 height: 12
                 color: "#ffffff"
                 text: qsTr("接收窗口操作")
                 font.bold: true
                 font.pointSize: 10
                 font.family: "Arial"
             }
                    SysBtn
                     {
                         x: 20
                         y: 99
                         width:20
                         height:20
                         picNormal: "Image/check.png"
                         picHover: "Image/disable.png"
                         picPressed: "Image/Unchecked.png"

                         Text {
                             id: spset15
                             x: 31
                             y: 0
                             width: 58
                             height: 20
                             color: "#ffffff"
                             text: qsTr("周期发送")
                             font.family: "Arial"
                             font.pointSize: 11
                         }
                     }

                    SysBtn {
                         id:period
                         x: 20
                         y: 171
                         width: 20
                         height: 20
                         picPressed: "Image/check.png"
                         picNormal: "Image/Unchecked.png"
                         picHover: "Image/disable.png"
                         Text {
                             id: spset17
                             x: 31
                             y: 0
                             width: 58
                             height: 20
                             color: "#ffffff"
                             text: qsTr("定时发送")
                             font.pointSize: 11
                             font.family: "Arial"
                         }
                         Text {
                             id: spset18
                             x: 166
                             y: 0
                             width: 17
                             height: 20
                             color: "#ffffff"
                             text: qsTr("分")
                             font.pointSize: 11
                             font.family: "Arial"
                         }
                         onClicked: {
                             qmyconsole.enPeriod(period.state=="pressed"?true:false)
                         }

                         Rectangle {
                             id: edit3
                             x: 105
                             y: 0
                             width: 50
                             height: 20
                             color: "#faf0e6"
                             Flickable {
                                 width: parent.width
                                 height: parent.height
                                 contentHeight: edit3.paintedHeight
                                 FocusScope {
                                     width: 166
                                     height: 21
                                     Rectangle {
                                         color: "#b0c5de"
                                         anchors.rightMargin: 117
                                         border.color: "#808080"
                                         anchors.fill: parent
                                     }

                                     TextEdit {
                                         id: input3
                                         text: "0"
                                         anchors.rightMargin: 117
                                         anchors.margins: 4
                                         readOnly: False
                                         persistentSelection: true
                                         anchors.fill: parent
                                         focus: true
                                         selectByMouse: true
                                         wrapMode: TextEdit.Wrap
                                         inputMethodHints:Qt.ImhHiddenText
                                         onTextChanged:
                                         {
                                             qmyconsole.setPeriod(input3.text)
                                         }
                                     }
                                 }
                                 clip: true
                                 contentWidth: edit3.paintedWidth
                             }
                         }

                         Text {
                             id: spset19
                             x: 31
                             y: 32
                             width: 58
                             height: 20
                             color: "#ffffff"
                             text: qsTr("允许超时")
                             font.family: "Arial"
                             font.pointSize: 11

                             Rectangle {
                                 id: edit4
                                 x: 74
                                 y: 0
                                 width: 50
                                 height: 20
                                 color: "#faf0e6"
                                 Flickable {
                                     width: parent.width
                                     height: parent.height
                                     contentWidth: edit4.paintedWidth
                                     clip: true
                                     contentHeight: edit4.paintedHeight
                                     FocusScope {
                                         width: 168
                                         height: 21
                                         Rectangle {
                                             color: "#b0c5de"
                                             anchors.rightMargin: 117
                                             border.color: "#808080"
                                             anchors.fill: parent
                                         }

                                         TextEdit {
                                             id: input4
                                             text: "1000"
                                             focus: true
                                             readOnly: False
                                             anchors.rightMargin: 117
                                             anchors.margins: 4
                                             inputMethodHints: Qt.ImhHiddenText
                                             persistentSelection: true
                                             anchors.fill: parent
                                             wrapMode: TextEdit.Wrap
                                             selectByMouse: true
                                             onTextChanged:
                                             {
                                                 qmyconsole.setWaitOutTime(input4.text)
                                             }
                                         }
                                     }
                                 }
                             }

                             Text {
                                 id: spset20
                                 x: 135
                                 y: 0
                                 width: 17
                                 height: 20
                                 color: "#ffffff"
                                 text: qsTr("毫秒")
                                 font.family: "Arial"
                                 font.pointSize: 11
                             }
                         }
                     }
                     SysBtn {
                         x: 120
                         y: 99
                         width: 20
                         height: 20
                         picPressed: "Image/Unchecked.png"
                         picNormal: "Image/check.png"
                         picHover: "Image/disable.png"

                         Text {
                             id: spset27
                             x: 31
                             y: 0
                             width: 58
                             height: 20
                             color: "#ffffff"
                             text: qsTr("数据回传")
                             font.family: "Arial"
                             font.pointSize: 11
                         }
                     }
                     SysBtn {
                         x: 20
                         y: 132
                         width: 20
                         height: 20
                         picPressed: "Image/Unchecked.png"
                         picNormal: "Image/check.png"
                         picHover: "Image/disable.png"

                         Text {
                             id: spset26
                             x: 31
                             y: 0
                             width: 58
                             height: 20
                             color: "#ffffff"
                             text: qsTr("转义字符")
                             font.family: "Arial"
                             font.pointSize: 11
                         }
                     }
                     SysBtn {
                         x: 120
                         y: 132
                         width: 20
                         height: 20
                         picPressed: "Image/Unchecked.png"
                         picNormal: "Image/check.png"
                         picHover: "Image/disable.png"

                         Text {
                             id: spset28
                             x: 31
                             y: 0
                             width: 61
                             height: 20
                             color: "#ffffff"
                             text: qsTr("HEX发送")
                             font.family: "Arial"
                             font.pointSize: 11
                         }
                     }
                     SysBtn {
                         x: 173
                         y: 270
                         width: 56
                         height: 21
                         picPressed: "Image/alert.png"
                         picNormal: "Image/normal.png"
                         picHover: "Image/focus.png"
                         Text{
                             x: 4
                             y: 3
                             width: 47
                             height: 17
                             color: "#000104"
                             text: qsTr("清除窗口")
                             styleColor: "#040000"
                             font.strikeout: false
                             font.bold: false
                             font.pointSize: 9
                             font.family: "Arial"
                         }
                         onClicked:
                         {
                             input.selectAll();
                             input.cut();
                         }
                     }
                     SysBtn {
                         x: 8
                         y: 270
                         width: 56
                         height: 21
                         picNormal: "Image/normal.png"
                         picHover: "Image/focus.png"
                         Text {
                             x: 4
                             y: 3
                             width: 47
                             height: 17
                             color: "#000104"
                             text: qsTr("复制数据")
                             font.pointSize: 9
                             font.bold: false
                             font.family: "Arial"
                             font.strikeout: false
                             styleColor: "#040000"
                         }
                         picPressed: "Image/alert.png"
                         onClicked:
                             input.copy()
                     }
                     Rectangle {
                         id: edit1
                         x: 8
                         y: 336
                         width: 159
                         height: 21
                         color: "#faf0e6"
                         Flickable {
                             width: parent.width
                             height: parent.height
                             contentHeight: edit1.paintedHeight
                             contentWidth: edit1.paintedWidth
                             FocusScope {
                                 width: 168
                                 height: 21
                                 Rectangle {
                                     color: "#b0c5de"
                                     border.color: "#808080"
                                     anchors.fill: parent
                                 }

                                 TextEdit {
                                     id: input1
                                     text: "Hello World"
                                     readOnly: False
                                     anchors.fill: parent
                                     focus: true
                                     persistentSelection: true
                                     selectByMouse: true
                                     wrapMode: TextEdit.Wrap
                                     anchors.margins: 4
                                 }
                             }
                             clip: true
                         }
                         SysBtn {
                             x: 165
                             y: 0
                             width: 56
                             height: 21
                             picNormal: "Image/normal.png"
                             picHover: "Image/focus.png"
                             picPressed: "Image/alert.png"
                             Text {
                                 x: 4
                                 y: 3
                                 width: 47
                                 height: 17
                                 color: "#000104"
                                 text: qsTr("发送数据")
                                 font.bold: false
                                 font.pointSize: 9
                                 styleColor: "#040000"
                                 font.strikeout: false
                                 font.family: "Arial"
                             }
                             onClicked: {
                                 if(qmyconsole.emitMessageRequ(input1.text)){
                                     input.paste()
                                 }
                                 else{
                                 input2.paste()
                                 }
                                 qmyconsole.clearclipboard()
                             }
                         }
                     }
                     SysBtn {
                         x: 91
                         y: 243
                         width: 56
                         height: 21
                         picHover: "Image/focus.png"
                         Text {
                             x: 4
                             y: 3
                             width: 47
                             height: 17
                             color: "#000105"
                             text: qsTr("    全选")
                             styleColor: "#050000"
                             font.pointSize: 9
                             font.family: "Arial"
                             font.bold: false
                             font.strikeout: false
                         }
                         picPressed: "Image/alert.png"
                         picNormal: "Image/normal.png"
                         onClicked:
                             input.selectAll()
                     }
                     SysBtn {
                         x: 91
                         y: 270
                         width: 56
                         height: 21
                         picHover: "Image/focus.png"
                         Text {
                             x: 4
                             y: 3
                             width: 47
                             height: 17
                             color: "#000104"
                             text: qsTr("    撤销")
                             styleColor: "#040000"
                             font.pointSize: 9
                             font.family: "Arial"
                             font.bold: false
                             font.strikeout: false
                         }
                         picPressed: "Image/alert.png"
                         picNormal: "Image/normal.png"
                         onClicked:
                             input.undo()
                     }
                     SysBtn {
                         x: 173
                         y: 243
                         width: 56
                         height: 21
                         picHover: "Image/focus.png"
                         Text {
                             x: 4
                             y: 3
                             width: 47
                             height: 17
                             color: "#000104"
                             text: qsTr("    redo")
                             styleColor: "#040000"
                             font.pointSize: 9
                             font.family: "Arial"
                             font.bold: false
                             font.strikeout: false
                         }
                         picPressed: "Image/alert.png"
                         picNormal: "Image/normal.png"
                         onClicked:
                             input.redo()
                     }
                     SysBtn {
                         x: 8
                         y: 243
                         width: 56
                         height: 21
                         picHover: "Image/focus.png"
                         Text {
                             x: 4
                             y: 3
                             width: 47
                             height: 17
                             color: "#000104"
                             text: qsTr("剪切数据")
                             styleColor: "#040000"
                             font.pointSize: 9
                             font.family: "Arial"
                             font.bold: false
                             font.strikeout: false
                         }
                         picPressed: "Image/alert.png"
                         picNormal: "Image/normal.png"
                         onClicked:
                             input.cut()
                     }
                     SysBtn {
                         x: 8
                         y: 297
                         width: 56
                         height: 21
                         Text {
                             x: 4
                             y: 3
                             width: 47
                             height: 17
                             color: "#000105"
                             text: qsTr("串口信息")
                             styleColor: "#050000"
                             font.family: "Arial"
                             font.bold: false
                             font.strikeout: false
                             font.pointSize: 9
                         }

                         Text {
                             id: spset16
                             x: 57
                             y: 2
                             width: 157
                             height: 18
                             color: "#57eb23"
                             text: qsTr("打印出所有串口设备信息")
                             font.pointSize: 11
                             font.family: "Arial"
                         }
                         picNormal: "Image/normal.png"
                         picHover: "Image/focus.png"
                         picPressed: "Image/alert.png"
                         onClicked:
                         {
                             qmyconsole.nowSpinfo()
                             input2.paste()
                             qmyconsole.clearclipboard()
                         }
                     }

                     Image {
                         id: spTip2
                         x: -119
                         y: 218
                         width: 93
                         height: 244
                         source: "Image/tip3.png"
                         Component.onCompleted: {
                             spTip2.visible=qmyconsole.enableWidget(1)
                         }
                         Text {
                             id: spset31
                             x: 20
                             y: 13
                             width: 17
                             height: 218
                             color: "#15eff9"
                             text: qsTr("请求数据回传时应尽量使数据")
                             horizontalAlignment: Text.AlignHCenter
                             wrapMode: Text.WrapAnywhere
                             font.pointSize: 11
                             font.family: "Arial"
                         }

                         Text {
                             id: spset32
                             x: 43
                             y: 13
                             width: 17
                             height: 218
                             color: "#15eff9"
                             text: qsTr("量不要过大以免产生BUG")
                             horizontalAlignment: Text.AlignHCenter
                             font.pointSize: 11
                             wrapMode: Text.WrapAnywhere
                             font.family: "Arial"
                         }
                         SysBtn {
                             id: close1
                             x: 0
                             y: 0
                             picPressed: "Image/close_pressed.png"
                             picNormal: "Image/close_normal.png"
                             picHover: "Image/close_hover.png"
                             onClicked:
                             {
                                 spTip2.visible=false
                                 qmyconsole.closeWidget(1)
                             }
                         }
                     }

         }
         Rectangle
         {
             id: grp1
             x: 13
             y: 53
             width:237
             height:131
             color:"#383A4C"
             //source: "Image/grp.png"
             DropWhere{}
             Mycombo{
                 id:liu
                 x: 171
                 y: 101
                 width: 58
                 height: 18
                 items:["无","硬件", "Xon/Xoff"]
                 onComboClicked:
                 {
                     qmyconsole.setFlowControl_com(liu.selectedIndex)
                 }
             }
             Mycombo{
                 id: data
                 x: 60
                 y: 101
                 width: 58
                 height: 18
                 items:["5", "6", "7","8"]
                 selectedItem:"8"
                 selectedIndex:3
                 onComboClicked:
                 {
                     qmyconsole.setDatabit_com(data.selectedIndex)
                 }
             }
             Mycombo{
                 id: baud
                 x: 60
                 y: 71
                 width: 58
                 height: 18
                 items:["110", "300", "600","1200","2400","4800","9600",
                        "14400","19200","28800","38400","56000","57600","115200",
                        "128000","230400","256000","460800","921600"]
                 onComboClicked:
                 {
                     qmyconsole.setBaud_com(baud.selectedItem)
                 }
             }
             Mycombo{
                 id: che
                 x: 171
                 y: 71
                 width: 58
                 height: 18
                 items:["无", "偶校验","奇校验","空格", "标记"]
                 onComboClicked:
                 {
                     qmyconsole.setParity_com(che.selectedIndex)
                 }

             }
             Mycombo{
                 id:com1
                 x: 60
                 y: 44
                 width: 58
                 height: 18
                 property variant  myCom:["COM1", "COM2", "COM3","COM4"]
                 items:myCom
                 Component.onCompleted:{
                     myCom=[qmyconsole.nowComAvailab(1),qmyconsole.nowComAvailab(2),
                            qmyconsole.nowComAvailab(3),qmyconsole.nowComAvailab(4),
                            qmyconsole.nowComAvailab(5),qmyconsole.nowComAvailab(6),
                            qmyconsole.nowComAvailab(7),qmyconsole.nowComAvailab(8),
                            qmyconsole.nowComAvailab(9),qmyconsole.nowComAvailab(10),
                            qmyconsole.nowComAvailab(11),qmyconsole.nowComAvailab(12)];
                 }
                 onComboClicked:
                 {
                     qmyconsole.setCom(com1.selectedItem)
                     input2.paste()
                     qmyconsole.clearclipboard()
                 }
             }
             Mycombo{
                 id: stop
                 x: 171
                 y: 44
                 width: 58
                 height: 18
                 radius: 0
                 border.width: 1
                 items:["1", "1.5", "2"]
                 onComboClicked:
                 {
                     qmyconsole.setStopbit_com(stop.selectedIndex)
                 }
             }
             Text {
                 id: spset6
                 x: 13
                 y: 44
                 width: 41
                 height: 12
                 color: "#ffffff"
                 text: qsTr("串口号")
                 font.pointSize: 10
                 font.family: "Arial"
             }
             Text {
                 id: spset5
                 x: 13
                 y: 71
                 width: 41
                 height: 12
                 color: "#ffffff"
                 text: qsTr("波特率")
                 font.pointSize: 10
                 font.family: "Arial"
             }
             Text {
                 id: spset4
                 x: 13
                 y: 101
                 width: 41
                 height: 12
                 color: "#ffffff"
                 text: qsTr("数据位")
                 font.pointSize: 10
                 font.family: "Arial"
             }
             Text {
                 id: spset3
                 x: 124
                 y: 44
                 width: 41
                 height: 12
                 color: "#ffffff"
                 text: qsTr("停止位")
                 font.pointSize: 10
                 font.family: "Arial"
             }
             Text {
                 id: spset2
                 x: 124
                 y: 71
                 width: 41
                 height: 12
                 color: "#ffffff"
                 text: qsTr("校验位")
                 font.pointSize: 10
                 font.family: "Arial"
             }
             Text {
                 id: spset1
                 x: 124
                 y: 101
                 width: 41
                 height: 12
                 color: "#ffffff"
                 text: qsTr("流控制")
                 font.pointSize: 10
                 font.family: "Arial"
             }
             Text {
                 id: spset
                 x: 13
                 y: 15
                 width: 57
                 height: 12
                 color: "#ffffff"
                 text: qsTr("串口设置：")
                 font.bold: true
                 font.pointSize: 10
                 font.family: "Arial"
             }
         }
         Rectangle
         {
             id:rct1
             x: 263
             y: 53
             width:164
             height:110
             color:"#00ACED"
             //source: "Image/grp4.png"
             DropWhere{}
             SysBtn {
                 id:openButton
                 x: 39
                 y: 47
                 width: 85
                 height: 31
                 picPressed: "Image/OFF.png"
                 picNormal: "Image/On.png"
                 picHover: "Image/OnOrOff.png"
                 onClicked:
                 {
                     if(!qmyconsole.comStateChange())
                     {
                         warn.change(warn);
                     }
                     qmyconsole.nNumbe()
                     input2.paste()
                     qmyconsole.clearclipboard()
                     if(!qmyconsole.isOpen())
                     {
                          openButton.state="pressed";
                     }
                 }
             }
             Text {
                 x: 16
                 y: 8
                 width: 59
                 height: 15
                 color: "#000000"
                 text: qsTr("打开串口")
                 styleColor: "#050000"
                 font.pointSize: 11
                 font.family: "Times New Roman"
             }
             Text {
                 x: 69
                 y: 24
                 width: 64
                 height: 15
                 color: "#000000"
                 text: qsTr("/关闭串口")
                 font.pointSize: 11
                 font.family: "Times New Roman"
             }
         }
         Image
         {
             id: rct3
             x: 441
             y: 53
             width:167
             height:288
             source: "Image/grp2.png"
             DropWhere{}
             Text {
                 x: 22
                 y: 229
                 width: 75
                 height: 15
                 color: "#7af1c6"
                 text: qsTr("当前待压缩")
                 styleColor: "#050000"
                 font.family: "Arial"
                 font.pointSize: 11
             }
             Text {
                 x: 57
                 y: 250
                 width: 89
                 height: 15
                 color: "#79f1c6"
                 text: qsTr("数据处理进度")
                 styleColor: "#050000"
                 font.family: "Arial"
                 font.pointSize: 11
             }
             Myprogress {
                 id: pro16
                 x: 7
                 y: 194
                 width: 157
                 height: 21
                 value: 100
                 Component.onCompleted:{
                     if(value==100)value=0;
                     else{
                     for (;value<100;value++);}
                 }
             }
             Myprogress {
                 id: pro15
                 x: 7
                 y: 167
                 width: 157
                 height: 21
                 value: 0
             }
             Myprogress {
                 id: pro14
                 x: 7
                 y: 140
                 width: 157
                 height: 21
                 value: 29
             }
             Myprogress {
                 id: pro13
                 x: 7
                 y: 113
                 width: 157
                 height: 21
                 value: 38
             }
             Myprogress {
                 id: pro12
                 x: 7
                 y: 86
                 width: 157
                 height: 21
                 value: 0
             }
             Myprogress {
                 id: pro11
                 x: 7
                 y: 59
                 width: 157
                 height: 21
                 value: 77
             }
             Myprogress {
                 id: pro10
                 x: 7
                 y: 32
                 width: 157
                 height: 21
                 value: 87
             }
             Myprogress {
                 id: pro9
                 x: 7
                  y: 5
                  width: 157
                  height: 21
                  value: 99
              }
         }
         Rectangle
         {
             id: rct4
             x: 263
             y: 357
             width:345
             height:230
             color:"#424457"
             //source: "Image/grp1.png"
             DropWhere{}
             Text {
                 x: 16
                 y: 8
                 width: 41
                 height: 12
                 color: "#ffffff"
                 text: qsTr("接收窗口")
                 font.bold: true
                 font.pointSize: 10
                 font.family: "Arial"
             }
             Rectangle{
                 id:edit
                 x:16
                 y:31
                 width: 313
                 height:183
                 color:"#b0c5de"
                 border.color:"gray"
                 /*Rectangle{
                     id:scrollbar_vertical
                     anchors.right: flick2.right
                     //当前可视区域的位置，为百分比值，0——1
                     y:flick2.visibleArea.yPosition*flick2.height
                     width:10
                     //当前可视区域的高度比例，为百分比的0——1
                     height:flick2.visibleArea.heightRatio*flick2.height
                     color: "#00B000"
                 }*/
                 Flickable{
                     id:flick2
                     width: parent.width;height: parent.height
                     contentWidth: edit.paintedWidth
                     contentHeight: edit.paintedHeight
                     clip: true

                     function ensureVisible(r)
                         {
                             if (contentX >= r.x)
                                 contentX = r.x;
                             else if (contentX+width <= r.x+r.width)
                                 contentX = r.x+r.width-width;
                             if (contentY >= r.y)
                                 contentY = r.y;
                             else if (contentY+height <= r.y+r.height)
                                 contentY = r.y+r.height-height;
                         }
                     Behavior on contentX { SmoothedAnimation { velocity: 200 } }
                     Behavior on contentY { SmoothedAnimation { velocity: 200 } }
                 FocusScope{
                     width:313;height:183
                     TextEdit{
                         id:input
                         anchors.fill: parent
                         anchors.margins: 4
                         focus:true
                         text:"Hello World"
                         readOnly: False
                         selectByMouse:true
                         persistentSelection:true
                         wrapMode:TextEdit.Wrap
                         onCursorRectangleChanged: flick2.ensureVisible(cursorRectangle)
                     }
                     }
                 }
             }
         }
         Image
         {
             id: rct5
             x: 623
             y: 53
             width:178
             height:534
             source: "Image/Proc.png"
             DropWhere{}
             AnimatedImage{
                 id:nekoplay
                 y: 501
                 property int  mywidth: 150
                 property int  myheight: 152
                 width: mywidth
                 height: myheight
                 fillMode:Image.PreserveAspectFit
                 anchors.left: parent.left
                 anchors.leftMargin: 290
                 source: "Image/neko.gif"
                 Component.onCompleted: {
                     nekoplay.visible=qmyconsole.enableWidget(3)
                 }
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                     onEntered:  {
                        parent.mywidth+=20;
                        parent.myheight+=20;
                    }
                    onExited: {
                        parent.mywidth-=20;
                        parent.myheight-=20;
                    }
                    onClicked: {
                        nekoplay.visible=false
                        qmyconsole.closeWidget(3)
                    }
                }
             }

              Text {
                  x: 18
                  y: 114
                  width: 102
                  height: 17
                  color: "#eaecea"
                  text: qsTr("二值图像处理：")
                  styleColor: "#050000"
                  font.strikeout: false
                  font.family: "Arial"
                  font.pointSize: 12
                  font.bold: false

                  SysBtn {
                      id:delivery
                      x: 2
                      y: 99
                      width: 12
                      height: 13
                      picNormal: "Image/checkradio.png"
                      picPressed: "Image/uncheckradio.png"
                      picHover: "Image/checkradio.png"
                      Text {
                          x: 17
                          y: 0
                          width: 47
                          height: 17
                          color: "#f3f3f3"
                          text: qsTr("横向取模")
                          font.pointSize: 9
                          styleColor: "#050000"
                          font.family: "Arial"
                          font.bold: false
                          font.strikeout: false
                      }
                      onClicked: {
                          delivery.state=="pressed"?undelivery.state="pressed":undelivery.state="normal"
                          if(delivery.state=="pressed")
                              qmyimage.setDeDirectC()
                          else qmyimage.setDeDirectD()
                      }
                  }

                  SysBtn {
                      x: 0
                      y: 148
                      width: 20
                      height: 20
                      picNormal: "Image/check.png"
                      picPressed: "Image/Unchecked.png"
                      picHover: "Image/disable.png"
                      Text {
                          id: spset21
                          x: 24
                          y: 2
                          width: 58
                          height: 20
                          color: "#ffffff"
                          text: qsTr("字节倒序")
                          font.family: "Arial"
                          font.pointSize: 11
                      }
                  }

                  SysBtn {
                      x: 89
                      y: 148
                      width: 56
                          height: 21
                          Text {
                              x: 4
                              y: 3
                              width: 47
                              height: 17
                              color: "#000105"
                              text: qsTr("存为文本")
                              font.pointSize: 9
                              font.bold: false
                              styleColor: "#050000"
                              font.family: "Arial"
                              font.strikeout: false
                          }
                          picPressed: "Image/alert.png"
                          picNormal: "Image/normal.png"
                          picHover: "Image/focus.png"
                          onClicked: {
                               qmyimage.saveToText()
                               input2.paste()
                               qmyconsole.clearclipboard()
                                     }
                  }

                  SysBtn {
                      x: 0
                      y: 35
                      width: 56
                      height: 21
                      picHover: "Image/focus.png"
                      picPressed: "Image/alert.png"
                      picNormal: "Image/normal.png"
                      Text {
                          x: 4
                          y: 3
                          width: 47
                          height: 17
                          color: "#000105"
                          text: qsTr("打开图像")
                          font.pointSize: 9
                          styleColor: "#050000"
                          font.strikeout: false
                          font.family: "Arial"
                          font.bold: false
                      }
                      onClicked: {
                          qmyimage.imOpen()
                          input2.paste()
                          qmyconsole.clearclipboard()
                      }
                  }

                  SysBtn {
                      id:undelivery
                      x: 72
                      y: 99
                      width: 12
                      height: 13
                      picNormal: "Image/uncheckradio.png"
                      picPressed: "Image/checkradio.png"
                      picHover: "Image/checkradio.png"
                      Text {
                          x: 16
                          y: 0
                          width: 47
                          height: 17
                          color: "#f3f3f3"
                          text: qsTr("纵向取模")
                          font.pointSize: 9
                          styleColor: "#050000"
                          font.family: "Arial"
                          font.bold: false
                          font.strikeout: false
                      }
                      onClicked: {
                          undelivery.state=="pressed"?delivery.state="pressed":delivery.state="normal"
                          if(undelivery.state=="pressed")
                              qmyimage.setDeDirectC()
                          else qmyimage.setDeDirectD()
                      }
                  }

                  SysBtn {
                      x: 0
                      y: 67
                      width: 56
                      height: 21
                      picNormal: "Image/normal.png"
                      picPressed: "Image/alert.png"
                      picHover: "Image/focus.png"
                      Text {
                          id:showbutton
                          x: 4
                          y: 3
                          width: 47
                          height: 17
                          color: "#000105"
                          text: qsTr("模拟显示")
                          font.bold: false
                          font.strikeout: false
                          font.pointSize: 9
                          styleColor: "#040000"
                          font.family: "Arial"
                      }
                      onClicked: {
                            imTimer.running=true;
                      }
                  }

                  SysBtn {
                      id: delivery1
                      x: 2
                      y: 119
                      width: 12
                      height: 13
                      picNormal: "Image/checkradio.png"
                      picPressed: "Image/uncheckradio.png"
                      picHover: "Image/checkradio.png"
                      Text {
                          x: 17
                          y: 0
                          width: 47
                          height: 17
                          color: "#f3f3f3"
                          text: qsTr("  共阴")
                          font.bold: false
                          font.strikeout: false
                          font.pointSize: 9
                          styleColor: "#050000"
                          font.family: "Arial"
                      }
                      onClicked: {
                          delivery1.state=="pressed"?undelivery1.state="pressed":undelivery1.state="normal"
                          if(delivery1.state=="pressed")
                              qmyimage.setReverseCodeC()
                          else qmyimage.setReverseCodeD()
                      }
                  }

                  SysBtn {
                      id: undelivery1
                      x: 72
                      y: 119
                      width: 12
                      height: 13
                      picNormal: "Image/uncheckradio.png"
                      picPressed: "Image/checkradio.png"
                      picHover: "Image/checkradio.png"
                      Text {
                          x: 16
                          y: 0
                          width: 47
                          height: 17
                          color: "#f3f3f3"
                          text: qsTr("  共阳")
                          font.bold: false
                          font.strikeout: false
                          font.pointSize: 9
                          styleColor: "#050000"
                          font.family: "Arial"
                      }
                      onClicked: {
                          undelivery1.state=="pressed"?delivery1.state="pressed":delivery1.state="normal"
                          if(undelivery1.state=="pressed")
                              qmyimage.setReverseCodeC()
                          else qmyimage.setReverseCodeD()
                      }
                  }

                  SysBtn {
                      x: 72
                      y: 67
                      width: 56
                      height: 21
                      Text {
                          x: 4
                          y: 3
                          width: 47
                          height: 17
                          color: "#000105"
                          text: qsTr("停止显示")
                          font.strikeout: false
                          styleColor: "#050000"
                          font.pointSize: 9
                          font.family: "Arial"
                          font.bold: false
                      }
                      picHover: "Image/focus.png"
                      picNormal: "Image/normal.png"
                      picPressed: "Image/alert.png"
                      onClicked: {
                          imTimer.running=false
                          image.source=""
                      }
                  }

                  SysBtn {
                      x: 72
                      y: 35
                      width: 56
                      height: 21
                      picPressed: "Image/alert.png"
                      picNormal: "Image/normal.png"
                      Text {
                          x: 4
                          y: 3
                          width: 47
                          height: 17
                          color: "#000105"
                          text: qsTr("批量处理")
                          font.strikeout: false
                          font.bold: false
                          font.pointSize: 9
                          styleColor: "#050000"
                          font.family: "Arial"
                      }
                      picHover: "Image/focus.png"
                  }
              }

              Text {
                  x: 18
                  y: 312
                  width: 87
                  height: 15
                  color: "#f4f2f2"
                  text: qsTr("LZ压缩设置：")
                  styleColor: "#050000"
                  font.pointSize: 12
                  font.family: "Arial"
                  font.bold: false
              }

              SysBtn {
                  x: 18
                  y: 341
                  width: 56
                  height: 21
                  Text {
                      x: 4
                      y: 3
                      width: 47
                      height: 17
                      color: "#000105"
                      text: qsTr("压缩图片")
                      styleColor: "#050000"
                      font.family: "Arial"
                      font.bold: false
                      font.strikeout: false
                  }
                  picNormal: "Image/normal.png"
                  picHover: "Image/focus.png"
                  picPressed: "Image/alert.png"
                  onClicked: {
                      qmyimage.dataCompress(qmyimage.dataToCompress())
                      input2.paste()
                      qmyconsole.clearclipboard()
                  }
              }

              Rectangle {
                  id: edit5
                  x: 84
                  y: 379
                  width: 50
                  height: 20
                  color: "#faf0e6"
                  Flickable {
                      width: parent.width
                      height: parent.height
                      FocusScope {
                          width: 168
                          height: 21
                          Rectangle {
                              color: "#b0c5de"
                              anchors.rightMargin: 117
                              border.color: "#808080"
                              anchors.fill: parent
                          }

                          TextEdit {
                              id: input5
                              text: "81024"
                              horizontalAlignment: Text.AlignHCenter
                              inputMethodHints: Qt.ImhHiddenText
                              selectByMouse: true
                              wrapMode: TextEdit.Wrap
                              anchors.rightMargin: 117
                              readOnly: False
                              persistentSelection: true
                              focus: true
                              anchors.margins: 4
                              anchors.fill: parent
                              onTextChanged: {
                                  qmyimage.setBufferSize(input5.text)
                              }
                          }
                      }
                      clip: true
                      contentWidth: edit5.paintedWidth
                      contentHeight: edit5.paintedHeight
                  }

                  Text {
                      x: -70
                      y: 3
                      width: 61
                      height: 18
                      color: "#f3f3f3"
                      text: qsTr("缓冲区大小")
                      font.pointSize: 10
                      styleColor: "#050000"
                      font.family: "Arial"
                      font.bold: false
                      font.strikeout: false
                  }

                  Text {
                      x: 56
                      y: 2
                      width: 19
                      height: 18
                      color: "#f3f3f3"
                      text: qsTr("Bit")
                      font.pointSize: 10
                      styleColor: "#050000"
                      font.family: "Arial"
                      font.bold: false
                      font.strikeout: false
                  }
              }

              SysBtn {
                  x: 90
                  y: 341
                  width: 56
                  height: 21
                  picHover: "Image/focus.png"
                  Text {
                      x: 4
                      y: 3
                      width: 47
                      height: 17
                      color: "#000105"
                      text: qsTr("批量发送")
                      font.bold: false
                      font.family: "Arial"
                      font.strikeout: false
                      styleColor: "#050000"
                      font.pointSize: 9
                  }
                  picNormal: "Image/normal.png"
                  picPressed: "Image/alert.png"
                  onClicked: {
                      qmyconsole.emitMessageRequ(qmyimage.sendlzData()+"#")
                      input2.paste()
                      qmyconsole.clearclipboard()
                  }
              }

              SysBtn {
                  x: 0
                  y: 493
                  width: 56
                  height: 21
                  picPressed: "Image/alert.png"
                  Text {
                      x: 1
                      y: 4
                      width: 47
                      height: 17
                      color: "#000105"
                      text: qsTr("文件至内存")
                      font.pointSize: 8
                      font.strikeout: false
                      font.family: "Arial"
                      styleColor: "#050000"
                      font.bold: false
                  }
                  picHover: "Image/focus.png"
                  picNormal: "Image/normal.png"
              }

              SysBtn {
                  x: 61
                  y: 493
                  width: 56
                  height: 21
                  picPressed: "Image/alert.png"
                  Text {
                      x: 1
                      y: 4
                      width: 47
                      height: 17
                      color: "#000105"
                      text: qsTr("内存到文件")
                      font.strikeout: false
                      font.family: "Arial"
                      font.pointSize: 8
                      font.bold: false
                      styleColor: "#050000"
                  }
                  picHover: "Image/focus.png"
                  picNormal: "Image/normal.png"
              }

              Rectangle {
                  id: edit6
                  x: 8
                  y: 417
                  width: 103
                  height: 21
                  color: "#faf0e6"
                  Flickable {
                      width: parent.width
                      height: parent.height
                      contentWidth: edit6.paintedWidth
                      clip: true
                      contentHeight: edit6.paintedHeight
                      FocusScope {
                          width: 168
                          height: 21
                          Rectangle {
                              color: "#b0c5de"
                              border.color: "#808080"
                              anchors.fill: parent
                          }

                          TextEdit {
                              id: input6
                              text: "压缩字符串"
                              anchors.margins: 4
                              wrapMode: TextEdit.Wrap
                              focus: true
                              readOnly: False
                              persistentSelection: true
                              selectByMouse: true
                              anchors.fill: parent
                          }
                      }
                  }

                  SysBtn {
                      x: 109
                      y: 0
                      width: 56
                      height: 21
                      picPressed: "Image/alert.png"
                      Text {
                          x: 4
                          y: 3
                          width: 47
                          height: 17
                          color: "#000104"
                          text: qsTr("Compress")
                          font.strikeout: false
                          font.family: "Arial"
                          font.pointSize: 8
                          font.bold: false
                          styleColor: "#040000"
                      }
                      picHover: "Image/focus.png"
                      picNormal: "Image/normal.png"
                      onClicked: {
                          qmyimage.dataCompress(input6.text)
                          input2.paste()
                          qmyconsole.clearclipboard()
                      }
                  }
              }

              Rectangle {
                  id: edit7
                  x: 8
                  y: 452
                  width: 103
                  height: 21
                  color: "#faf0e6"
                  Flickable {
                      width: parent.width
                      height: parent.height
                      contentWidth: edit7.paintedWidth
                      clip: true
                      contentHeight: edit7.paintedHeight
                      FocusScope {
                          width: 168
                          height: 21
                          Rectangle {
                              color: "#b0c5de"
                              anchors.rightMargin: 64
                              border.color: "#808080"
                              anchors.fill: parent
                          }

                          TextEdit {
                              id: input7
                              text: "解压Lzss数据"
                              anchors.margins: 4
                              wrapMode: TextEdit.Wrap
                              focus: true
                              readOnly: False
                              selectByMouse: true
                              persistentSelection: true
                              anchors.fill: parent
                          }
                      }
                  }

                  SysBtn {
                      x: 109
                      y: 0
                      width: 56
                      height: 21
                      picPressed: "Image/alert.png"
                      Text {
                          x: 1
                          y: 5
                          width: 47
                          height: 17
                          color: "#000104"
                          text: qsTr("UnCompress")
                          horizontalAlignment: Text.AlignLeft
                          font.strikeout: false
                          font.family: "Arial"
                          font.pointSize: 7
                          styleColor: "#040000"
                          font.bold: false
                      }
                      picHover: "Image/focus.png"
                      picNormal: "Image/normal.png"
                  }
              }

              SysBtn {
                  x: 122
                  y: 493
                  width: 56
                  height: 21
                  picPressed: "Image/alert.png"
                  Text {
                      x: 5
                      y: 2
                      width: 47
                      height: 17
                      color: "#000105"
                      text: qsTr("文件互转")
                      font.strikeout: false
                      font.family: "Arial"
                      font.pointSize: 9
                      styleColor: "#050000"
                      font.bold: false
                  }
                  picHover: "Image/focus.png"
                  picNormal: "Image/normal.png"
              }
         }
         Image
         {
             id: rct6
             x: 817
             y: 53
             width:169
             height:534
             source: "Image/sliding.png"
             DropWhere{}
             Rectangle{
                 id:imageplay
                 x: 8
                 y: 8
                 color:"#18181a"
                 width: 153
                 height: 85
                 Image{
                     id:imageico
                     x: 44
                     y: 10
                     width: 65
                     height: 65
                     visible: true
                     source: "image/play.png"
                 }
                 Image{
                     id:image
                     x: 0
                     y: 0
                     width: 153
                     height: 85
                     property int index:0
                     Timer{
                         id:imTimer
                         interval: 40
                         running:false
                         repeat:true
                         onTriggered: {
                             if(image.index++<qmyimage.numofImage())
                              image.source="file:///"+qmyimage.imageFrame(image.index);
                         }
                     }
                     MouseArea{
                           anchors.fill: parent
                           onClicked: {
                               imTimer.running=!imTimer.running
                           }
                     }
                 }
             }
             Rectangle {
                 id: edit2
                 x: 11
                 y: 165
                 width: 148
                 height: 354
                 color: "#b0c5de"
                 border.color: "#808080"
                 Flickable {
                     id:flick
                     width: parent.width
                     height: parent.height
                     contentWidth: edit2.paintedWidth
                     clip: true
                     contentHeight: edit2.paintedHeight

                     function ensureVisible(r)
                          {
                              if (contentX >= r.x)
                                  contentX = r.x;
                              else if (contentX+width <= r.x+r.width)
                                  contentX = r.x+r.width-width;
                              if (contentY >= r.y)
                                  contentY = r.y;
                              else if (contentY+height <= r.y+r.height)
                                  contentY = r.y+r.height-height;
                          }
                     Behavior on contentX { SmoothedAnimation { velocity: 200 } }
                     Behavior on contentY { SmoothedAnimation { velocity: 200 } }
                     FocusScope {
                         width: 148
                         height: 354
                         TextEdit {
                             id: input2
                             text: "Hello World"
                             focus: true
                             anchors.margins: 4
                             wrapMode: TextEdit.Wrap
                             persistentSelection: true
                             selectByMouse: true
                             anchors.fill: parent
                             readOnly: false
                             onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
                         }
                     }
                 }
             }
             Text {
                 x: 11
                 y: 126
                 width: 85
                 height: 15
                 color: "#f4f2f2"
                 text: qsTr("控制台输出：")
                 font.bold: true
                 styleColor: "#050000"
                 font.pointSize: 13
                 font.family: "Arial"
             }

             Image {
                 id: spTip1
                 x: 188
                 y: 160
                 width: 88
                 height: 225
                 source: "Image/tip1.png"

                 Text {
                     id: spset29
                     x: 22
                     y: 17
                     width: 19
                     height: 200
                     color: "#021991"
                     text: qsTr("通过选取文字来拖动控制")
                     styleColor: "#1869a4"
                     verticalAlignment: Text.AlignTop
                     horizontalAlignment: Text.AlignLeft
                     wrapMode: Text.WordWrap
                     font.pointSize: 12
                     font.family: "Arial"
                 }

                 Text {
                     id: spset30
                     x: 47
                     y: 17
                     width: 19
                     height: 200
                     color: "#021991"
                     text: qsTr("台及接受窗口的数据显示")
                     horizontalAlignment: Text.AlignLeft
                     verticalAlignment: Text.AlignTop
                     font.pointSize: 12
                     wrapMode: Text.WordWrap
                     font.family: "Arial"
                     styleColor: "#1869a4"
                 }
                 Component.onCompleted: {
                     spTip1.visible=qmyconsole.enableWidget(2)
                 }
                 SysBtn {
                     id: close2
                     x: 61
                     y: 0
                     picPressed: "Image/close_pressed.png"
                     picNormal: "Image/close_normal.png"
                     picHover: "Image/close_hover.png"
                     onClicked:
                     {
                         spTip1.visible=false
                         qmyconsole.closeWidget(2)
                     }
                 }
             }
         }

         SysBtnGroup
         {
             id: sysbtngrp
             x: 905
             y: 0
             onMin: window.showMinimized()
             onClose: window.close()
         }

         Image
         {
             id: rct2
             x: 263
             y: 191
             width:164
             height:150
             source: "Image/grp3.png"
             Warnning
             {
                 id:warn
                 x: 0
                 y: 0
                 Component.onCompleted:
                 {
                     if(qmyconsole.busy_com())
                     {
                         warn.mywidth=536;
                         warn.myheight=313;
                         warn.fontsize=16;
                         animacover.mywidth=0
                         animacover.myheight=0
                     }
                     else {
                         warn.mywidth=rct2.width;
                         warn.myheight=rct2.height;
                         warn.fontsize=4;
                         animacover.mywidth=205
                         animacover.myheight=164
                     }
                 }
                 mywidth: 162
                 myheight: 150
                 visible: true
                 fontsize: 4
                 onOk:
                 {
                     warn.mywidth=rct2.width
                     warn.myheight=rct2.height
                     warn.fontsize=4
                     animacover.mywidth=205
                     animacover.myheight=164
                 }
                 onCancel:
                 {
                     warn.mywidth=rct2.width
                     warn.myheight=rct2.height
                     warn.fontsize=4
                     animacover.mywidth=205
                     animacover.myheight=164
                 }
                 function change(x)
                 {
                     x.mywidth=536
                     x.myheight=313
                     x.fontsize=16
                     animacover.mywidth=0
                     animacover.myheight=0
                 }

                 Behavior on mywidth { SmoothedAnimation { velocity: 300 } }
                 Behavior on myheight { SmoothedAnimation { velocity: 300 } }
                 Behavior on fontsize { SmoothedAnimation { velocity: 10 } }

                 AnimatedImage{
                     id:animacover
                     x: -100
                     y: -14
                     property int mywidth:205
                     property int myheight:164
                     property int myrotate: 0
                     width: mywidth
                     height: myheight
                     fillMode:Image.PreserveAspectFit
                     anchors.left: parent.left
                     anchors.leftMargin: -21
                     source: "Image/nyantocat.gif"
                     rotation:myrotate
                     MouseArea{
                         anchors.fill: parent
                         onClicked: {
                             qmyconsole.playFile();
                               parent.myrotate=360;
                             if(parent.myrotate!=0)parent.myrotate=0;
                         }
                     }
                     Behavior on myrotate { SmoothedAnimation { velocity: 366 } }
                     Behavior on mywidth { SmoothedAnimation { velocity: 150 } }
                     Behavior on myheight { SmoothedAnimation { velocity: 150 } }
                 }
             }

         }

     }

     Image {
         id: spTip
         x: -198
         y: 55
         width: 191
         height: 123
         source: "Image/tip2.png"
         Component.onCompleted: {
             spTip.visible=qmyconsole.enableWidget(0)
         }

         Text {
             id: spset22
             x: 41
             y: 13
             width: 109
             height: 17
             color: "#ffffff"
             text: qsTr("关于串口设置：")
             font.pointSize: 12
             font.family: "Arial"
             font.bold: true
         }

         Text {
             id: spset23
             x: 8
             y: 46
             width: 164
             height: 15
             color: "#ffffff"
             text: qsTr("用户可以先用接收窗口下的串")
             font.pointSize: 10
             font.family: "Arial"
         }

         Text {
             id: spset24
             x: 8
             y: 67
             width: 164
             height: 15
             color: "#ffffff"
             text: qsTr("口信息按钮来查看当前串口信")
             font.pointSize: 10
             font.family: "Arial"
         }

         Text {
             id: spset25
             x: 8
             y: 88
             width: 164
             height: 15
             color: "#ffffff"
             text: qsTr("息来进行设置。")
             font.pointSize: 10
             font.family: "Arial"
         }
         SysBtn
         {
             id:close
             x: 0
             y: 0
             picHover: "Image/close_hover.png"
             picNormal: "Image/close_normal.png"
             picPressed: "Image/close_pressed.png"
             onClicked:
             {
                 spTip.visible=false
                 qmyconsole.closeWidget(0)
             }
         }
     }
     states: [
         State {
             name: "State1"

             PropertyChanges {
                 target: spTip
                 x: -204
                 y: 8
             }
         }
     ]
 }
}
